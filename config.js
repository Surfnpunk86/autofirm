/* ================================================================
   AUTOFIRM · CONFIGURACIÓN CENTRAL
   Edita SOLO este archivo. Lo usan tanto el catálogo (index.html)
   como el panel de administración (admin.html).
   ================================================================ */
window.AUTOFIRM_CONFIG = {

  /* 1) LLAVES DE SUPABASE ------------------------------------------
     Las obtienes en:  Supabase → Project Settings → API
     - SUPABASE_URL      = "https://zugfxcpzzhnxtaogukcm.supabase.com"
     - SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1Z2Z4Y3B6emhueHRhb2d1a2NtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM2NjM4NjcsImV4cCI6MjA5OTIzOTg2N30.jC9k91mKGGKGdhlWC6VaRxBFBvfcSkPNFUaO3-UgRhQ"  (esta llave es PÚBLICA y segura
        de exponer: la seguridad la dan las políticas RLS de la base).
     ⚠️ NUNCA pongas aquí la llave "service_role".                     */
  SUPABASE_URL:      "https://zugfxcpzzhnxtaogukcm.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1Z2Z4Y3B6emhueHRhb2d1a2NtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODM2NjM4NjcsImV4cCI6MjA5OTIzOTg2N30.jC9k91mKGGKGdhlWC6VaRxBFBvfcSkPNFUaO3-UgRhQ",

  /* 2) DATOS DEL NEGOCIO ------------------------------------------ */
  negocio:   "Autofirm",
  whatsapp:  "573022789840",          // 57 + número, sin + ni espacios
  telefono:  "+57 302 278 9840",
  ciudad:    "Barranquilla, Colombia",
  direccion: "Barranquilla, Atlántico",
  horario:   "Lun a Sáb · 8:00 a.m. – 6:00 p.m.",
  instagram: "https://www.instagram.com/autofirm_baq",                     // URL de Instagram (opcional)
  facebook:  "https://www.facebook.com/share/1RjbtfMudd/?mibextid=wwXIfr",                     // URL de Facebook (opcional)
};
