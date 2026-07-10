-- ================================================================
--  AUTOFIRM · DATOS DE EJEMPLO (OPCIONAL)
--  Ejecútalo en el SQL Editor SOLO si quieres mostrar el catálogo
--  con vehículos de muestra desde el primer momento.
--  El cliente puede editarlos o borrarlos luego desde el panel.
--  (Las fotos quedan vacías: se mostrará una imagen de referencia
--   con la marca hasta que el cliente suba las reales.)
-- ================================================================

insert into public.vehiculos
  (marca, modelo, version, anio, precio, km, transmision, combustible, categoria, cilindraje, color, puertas, estado, destacado, descripcion, caracteristicas, fotos)
values
  ('Mazda','CX-30','Grand Touring',2022,92900000,38000,'Automática','Gasolina','SUV','2.0','Gris Meteoro',5,'Disponible',true,
   'SUV en excelente estado, único dueño y mantenimientos al día. Interior impecable y llantas nuevas.',
   array['Cámara de reversa','Sensores de parqueo','Pantalla táctil','Rines de lujo','Control crucero','Climatizador','Bluetooth','Faros LED'], '{}'),

  ('Chevrolet','Onix','Turbo RS',2023,66500000,22000,'Automática','Gasolina','Sedán','1.0T','Rojo Chili',4,'Disponible',true,
   'Sedán turbo casi nuevo, muy bajo kilometraje y garantía vigente de fábrica. Excelente consumo.',
   array['Pantalla 8" MyLink','Cámara de reversa','Wi-Fi a bordo','6 airbags','Control crucero','Bluetooth'], '{}'),

  ('Toyota','Hilux','2.4 4x4',2020,138000000,89000,'Mecánica','Diésel','Pick-Up','2.4 TD','Plata Metálico',4,'Disponible',true,
   'Pick-up doble cabina 4x4 diésel, referente de durabilidad. Ideal para trabajo y aventura.',
   array['Tracción 4x4','Estribos','Cámara de reversa','Pantalla táctil','Aire acondicionado','Forro de platón'], '{}'),

  ('Kia','Picanto','Emotion',2022,47900000,31000,'Automática','Gasolina','Hatchback','1.2','Azul Marino',5,'Disponible',false,
   'Hatchback ágil y económico, perfecto como primer carro o para ciudad. Muy bien cuidado.',
   array['Pantalla táctil','Cámara de reversa','Bluetooth','Vidrios eléctricos','Aire acondicionado'], '{}'),

  ('Renault','Duster','Intens 4x2',2021,68900000,54300,'Mecánica','Gasolina','SUV','1.6','Blanco Glaciar',5,'Disponible',false,
   'SUV robusta y económica, perfecta para trabajo y familia. Suspensión alta y amplio baúl.',
   array['Pantalla táctil','Cámara de reversa','Sensores traseros','Rines en aleación','Barras de techo'], '{}'),

  ('Toyota','Corolla Cross','Hybrid',2023,129000000,24000,'Automática','Híbrido','SUV','1.8 HEV','Blanco Perla',5,'Disponible',true,
   'SUV híbrida de bajísimo consumo, casi nueva y con garantía. Tecnología de última generación.',
   array['Motor híbrido','Pantalla táctil','Cámara 360','Toyota Safety Sense','Control crucero adaptativo','Faros LED'], '{}');
