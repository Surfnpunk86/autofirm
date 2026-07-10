# Autofirm — Manual de despliegue (para Howard)

Sitio de catálogo **autogestionable**. Frontend estático (HTML/CSS/JS) + **Supabase** como backend (base de datos Postgres, autenticación y almacenamiento de fotos). El cliente administra el inventario desde `admin.html` sin tocar código.

**Archivos del proyecto**
```
index.html               → catálogo público
admin.html               → panel de administración (login + CRUD + fotos)
config.js                → ⚙️ llaves de Supabase y datos del negocio (SE EDITA)
logo-autofirm.png        → logo (fondos oscuros)
logo-autofirm-dark.png   → logo (fondos claros: login)
supabase-setup.sql       → script de base de datos (se corre 1 vez)
seed-demo-opcional.sql   → datos de ejemplo (opcional)
GUIA-CLIENTE.md          → guía de uso para el cliente
```

Tiempo estimado: **~15 minutos**.

---

## 1) Crear el proyecto en Supabase
1. Entra a https://supabase.com → **New project**.
2. Nombre: `autofirm`. Define y **guarda** la contraseña de la base de datos. Región: la más cercana (ej. *East US* / *South America (São Paulo)*).
3. Espera a que el proyecto termine de aprovisionarse.

## 2) Crear la base de datos y la seguridad
1. En el proyecto → menú lateral **SQL Editor** → **New query**.
2. Abre `supabase-setup.sql`, copia **todo** el contenido, pégalo y presiona **Run**.
   - Crea la tabla `vehiculos`, las políticas de seguridad (RLS), la función `is_admin()` y el bucket de fotos `vehiculos`.
3. *(Opcional)* Para mostrar datos de muestra desde el inicio: abre `seed-demo-opcional.sql`, pégalo en una query nueva y **Run**.

## 3) Crear el usuario del cliente
1. Menú lateral **Authentication → Users → Add user**.
2. Escribe el **correo** y una **contraseña** para el cliente. Marca *Auto Confirm User* (o confirma el correo) para que pueda entrar de una vez.

## 4) Autorizar a ese usuario como administrador
En **SQL Editor**, corre esta línea reemplazando el correo por el del cliente:
```sql
insert into public.admins (email) values ('correo-del-cliente@ejemplo.com');
```
> Solo los correos que estén en la tabla `admins` pueden crear/editar/eliminar. Los visitantes solo pueden ver el catálogo.

## 5) Cerrar el registro público (recomendado)
**Authentication → Sign In / Providers** (o *Settings*) → desactiva **“Allow new users to sign up”**.
Así nadie puede auto-registrarse; los usuarios los creas tú manualmente.

## 6) Copiar las llaves al sitio
1. **Project Settings → API**. Copia:
   - **Project URL**
   - **anon public** key
2. Abre `config.js` y pega ambos valores:
```js
SUPABASE_URL:      "https://xxxxxxxx.supabase.co",
SUPABASE_ANON_KEY: "eyJhbGciOi....(anon public)",
```
> ⚠️ La llave **anon** es pública y segura de exponer: la protección la dan las políticas RLS. **Nunca** pongas aquí la llave `service_role`.
3. De paso, verifica en `config.js` el WhatsApp, teléfono, dirección y redes del negocio.

## 7) Verificar el bucket de fotos
**Storage** → debe existir el bucket **`vehiculos`** marcado como **Public** (lo crea el script). Si no aparece, créalo manualmente: *New bucket* → nombre `vehiculos` → **Public** ✔.

## 8) Desplegar en Render
El sitio es 100% estático, así que va como **Static Site**:
1. Sube la carpeta del proyecto a un repositorio (GitHub/GitLab).
2. Render → **New → Static Site** → conecta el repositorio.
3. Configuración:
   - **Build Command:** *(vacío)*
   - **Publish Directory:** la carpeta que contiene `index.html` (normalmente `.` o la raíz del repo).
4. **Create Static Site** y espera el deploy.

> Cualquier hosting estático sirve (Netlify, Vercel, Cloudflare Pages), pero aquí seguimos con Render.

## 9) Dominio
En el Static Site → **Settings → Custom Domains → Add Custom Domain** → agrega el dominio del cliente y crea el registro **CNAME** que Render indique en el DNS del dominio. Render emite el certificado SSL automáticamente.

## 10) Probar de punta a punta
1. Abre `https://EL-DOMINIO/admin.html` → inicia sesión con el usuario del cliente.
2. **Agregar vehículo** → llena datos → sube 2–3 fotos → **Guardar**.
3. Abre `https://EL-DOMINIO/` (catálogo) → el vehículo debe aparecer, con su foto, filtros y botón de WhatsApp.

---

## Notas y solución de problemas
- **URL del panel:** `tudominio.com/admin.html`. (Lleva `noindex`, no lo indexan los buscadores.)
- **No cargan vehículos / error 401-403 al guardar:** el correo del usuario no está en `admins`, o no corrió el `supabase-setup.sql`. Revisa el paso 4.
- **No suben fotos:** revisa que el bucket `vehiculos` exista y sea público (paso 7) y que el usuario esté en `admins`.
- **“Supabase no está configurado”** en el panel: faltan las llaves en `config.js` (paso 6).
- **Restablecer contraseña del cliente:** Authentication → Users → el usuario → *Reset password* / *Send recovery*.
- **Costo:** el plan gratuito de Supabase cubre de sobra un catálogo de este tamaño. El Static Site de Render también.
- **Backups:** Supabase respalda la base automáticamente; las fotos viven en Storage.

## Seguridad (resumen)
- RLS activo: el público **solo lee**; escribir requiere estar autenticado **y** figurar en `admins`.
- Registro público desactivado.
- Llave `anon` en el cliente = correcto y seguro. `service_role` = jamás en el frontend.
