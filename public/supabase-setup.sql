-- ================================================================
--  AUTOFIRM · CONFIGURACIÓN DE SUPABASE
--  Cópialo COMPLETO y ejecútalo una vez en:  Supabase → SQL Editor → Run
--  Crea la tabla de vehículos, la seguridad (RLS), el control de
--  administradores y el bucket de fotos.
-- ================================================================

-- 1) TABLA DE VEHÍCULOS ------------------------------------------
create table if not exists public.vehiculos (
  id             bigint generated always as identity primary key,
  created_at     timestamptz not null default now(),
  marca          text not null,
  modelo         text not null,
  version        text default '',
  anio           int,
  precio         bigint,               -- en pesos colombianos (COP)
  km             int,
  transmision    text,                 -- 'Automática' | 'Mecánica'
  combustible    text,                 -- 'Gasolina' | 'Diésel' | 'Híbrido' ...
  categoria      text,                 -- 'SUV' | 'Sedán' | 'Pick-Up' ...
  cilindraje     text,
  color          text,
  puertas        int,
  estado         text not null default 'Disponible', -- Disponible|Reservado|Vendido
  destacado      boolean not null default false,
  descripcion    text default '',
  caracteristicas text[] default '{}', -- lista de equipamiento
  fotos          text[] default '{}'   -- URLs públicas de las fotos
);

-- 2) TABLA DE ADMINISTRADORES (lista blanca de correos) ----------
create table if not exists public.admins (
  email text primary key
);

-- 3) FUNCIÓN is_admin() ------------------------------------------
--    Verifica si el usuario autenticado está en la lista de admins.
--    SECURITY DEFINER le permite leer la tabla admins de forma segura.
create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.admins
    where email = (auth.jwt() ->> 'email')
  );
$$;

-- 4) ACTIVAR SEGURIDAD A NIVEL DE FILA (RLS) ---------------------
alter table public.vehiculos enable row level security;
alter table public.admins    enable row level security;

-- 5) LECTURA PÚBLICA DE VEHÍCULOS (cualquier visitante) ----------
drop policy if exists "lectura publica vehiculos" on public.vehiculos;
create policy "lectura publica vehiculos"
  on public.vehiculos for select
  to anon, authenticated
  using (true);

-- 6) ESCRITURA SOLO PARA ADMINISTRADORES ------------------------
drop policy if exists "admin inserta vehiculos" on public.vehiculos;
create policy "admin inserta vehiculos"
  on public.vehiculos for insert
  to authenticated with check (public.is_admin());

drop policy if exists "admin actualiza vehiculos" on public.vehiculos;
create policy "admin actualiza vehiculos"
  on public.vehiculos for update
  to authenticated using (public.is_admin()) with check (public.is_admin());

drop policy if exists "admin elimina vehiculos" on public.vehiculos;
create policy "admin elimina vehiculos"
  on public.vehiculos for delete
  to authenticated using (public.is_admin());

-- (La tabla admins queda con RLS activo y SIN políticas: nadie la puede
--  leer/editar desde el cliente. is_admin() la consulta internamente.)

-- 7) BUCKET DE FOTOS (público para lectura) ---------------------
insert into storage.buckets (id, name, public)
values ('vehiculos', 'vehiculos', true)
on conflict (id) do nothing;

-- 8) POLÍTICAS DEL BUCKET ---------------------------------------
drop policy if exists "fotos lectura publica" on storage.objects;
create policy "fotos lectura publica"
  on storage.objects for select
  to anon, authenticated
  using (bucket_id = 'vehiculos');

drop policy if exists "fotos admin sube" on storage.objects;
create policy "fotos admin sube"
  on storage.objects for insert
  to authenticated with check (bucket_id = 'vehiculos' and public.is_admin());

drop policy if exists "fotos admin actualiza" on storage.objects;
create policy "fotos admin actualiza"
  on storage.objects for update
  to authenticated using (bucket_id = 'vehiculos' and public.is_admin());

drop policy if exists "fotos admin elimina" on storage.objects;
create policy "fotos admin elimina"
  on storage.objects for delete
  to authenticated using (bucket_id = 'vehiculos' and public.is_admin());

-- ================================================================
--  DESPUÉS de ejecutar esto:
--  1. Crea el usuario del cliente en:  Authentication → Users → Add user
--  2. Autorízalo como admin (reemplaza el correo):
--
--       insert into public.admins (email) values ('correo-del-cliente@ejemplo.com');
--
--  3. (Recomendado) Desactiva el registro público en:
--       Authentication → Sign In / Providers → "Allow new users to sign up" = OFF
-- ================================================================
