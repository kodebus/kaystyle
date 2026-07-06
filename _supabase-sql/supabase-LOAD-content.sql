-- ============================================================
--  KARLA MARTINEZ — LOAD ALL CONTENT (run once)
--  Inserts every painting + exhibition, pointing to the images
--  already live at kaystyle.com/images/...
--
--  Paste ALL of this into Supabase → SQL Editor → New query → Run
--  Safe to run on the empty tables you already created.
-- ============================================================

-- ---------- PAINTINGS ----------
INSERT INTO public.paintings (title, description, month, year, size, image_url) VALUES
(
  'Iglesia del lago',
  'Una iglesia de piedra se asoma entre el follaje bajo un cielo luminoso — una de las obras más queridas de Karla, presentada en la Cumbre Mundial de las Artes por la Paz y la Vida.',
  NULL, 2003,
  'Óleo sobre lienzo · Firmado Karla, 2003 · Exhibida en la Cumbre Mundial de las Artes, 2019',
  'https://kaystyle.com/images/iglesia_del_lago.jpg'
),
(
  'Atardecer en el Pacífico',
  'Un árbol curtido se inclina hacia un cielo en llamas, pintado con trazos gruesos y texturizados que atrapan la luz. Diseñado para colgar como conjunto sobre una repisa o pared larga.',
  NULL, NULL,
  'Óleo sobre lienzo, espátula · Tríptico de tres paneles',
  'https://kaystyle.com/images/tree_sunset_triptych.jpg'
),
(
  'Mariposas del Estero',
  'Un estanque verde y tranquilo cobra vida con mariposas en vuelo — una faceta más serena y pastoral dentro del repertorio de la artista.',
  NULL, 2008,
  'Óleo sobre lienzo · Firmado Kay, 2008',
  'https://kaystyle.com/images/butterflies_pond.jpg'
),
(
  'Bosque en Dos Luces',
  'Sombra índigo y luz ámbar dividen un grupo de árboles en dos — un estudio expresivo y de pequeño formato sobre el contraste y la textura de espátula.',
  NULL, NULL,
  'Acrílico sobre lienzo · Disponible',
  'https://kaystyle.com/images/forest_blue_orange.jpg'
),
(
  'Desde la Mirada',
  'Pintada íntegramente en turquesa, esta obra fue presentada en una exposición colectiva en 2016 — una apuesta atrevida hacia una paleta única y saturada.',
  NULL, 2016,
  'Técnica mixta sobre lienzo · Exposición colectiva "Colectivo", 2016',
  'https://kaystyle.com/images/teal_tree.jpg'
),
(
  'Árbol de Otoño',
  'Decenas de hojas construidas individualmente se elevan del lienzo en relieve, resplandeciendo sobre un fondo rojo intenso. Una obra de gran presencia escultórica.',
  NULL, NULL,
  'Acrílico con relieve sobre lienzo · Firmado Kay',
  'https://kaystyle.com/images/orange_leaf_tree.jpg'
),
(
  'Escarabajo Amarillo',
  'Un Volkswagen Beetle desgastado capta la luz junto a una cerca de campo — prueba de que el ojo de la artista se mueve con soltura del paisaje a la nostalgia cotidiana.',
  NULL, NULL,
  'Óleo sobre lienzo · Firmado Kay',
  'https://kaystyle.com/images/yellow_beetle.jpg'
),
(
  'Camino al Río',
  'Una tormenta se cierne sobre un camino rural mientras un pastor lleva su rebaño al agua — un estudio de paisaje clásico, enmarcado y firmado en los inicios de la carrera de la artista.',
  'Noviembre', 2003,
  'Óleo sobre lienzo · Firmado y fechado Karla Martinez, Nov. 2003',
  'https://kaystyle.com/images/countryside_landscape.jpg'
);

-- ---------- EXHIBITIONS ----------
INSERT INTO public.exhibitions (title, description, venue, location, year, month, image_url) VALUES
(
  'Cumbre Mundial de las Artes por la Paz y la Vida',
  'Karla participó en esta muestra colectiva internacional con su obra "Iglesia del lago", junto a artistas de distintos países. Una celebración del arte como lenguaje de paz.',
  'Palacio de Cristal', 'Ecuador', 2019, 'Agosto',
  'https://kaystyle.com/images/exhibitions/cumbre-mundial-artes-2019.jpg'
),
(
  'Exposición "Mujeres en Acción"',
  'Muestra colectiva organizada por la Fundación Bellas Artes, con el respaldo del Ministerio de Cultura y Patrimonio del Ecuador, reuniendo a mujeres artistas del país.',
  'Museo Centro Cultural Manta', 'Manta, Ecuador', 2020, 'Marzo',
  'https://kaystyle.com/images/exhibitions/mujeres-en-accion-2020.jpg'
),
(
  'Artista del Bicentenario de América',
  'Diploma concedido a Karla por su participación en el Bicentenario de América, reconociéndola como una artista del bicentenario. Otorgado por la Municipalidad de Manantay.',
  'Municipalidad de Manantay', 'Pucallpa, Perú', 2022, 'Julio',
  'https://kaystyle.com/images/exhibitions/diploma-bicentenario-2022.jpg'
),
(
  'The NALA Project — La Habana, Cuba',
  'Karla representó a Ecuador en esta exposición internacional itinerante que ha recorrido países de África, Europa y América. Un proyecto que une artistas de todo el mundo.',
  'The NALA Project', 'La Habana, Cuba', 2024, 'Mayo',
  'https://kaystyle.com/images/exhibitions/nala-project-cuba-2024.jpg'
),
(
  'Festival de Corea del Sur',
  'Karla representó a Ecuador en este festival internacional dedicado al arte como lenguaje de convivencia, bajo el lema "El clímax del arte no es un destino sino un camino."',
  'Festival Internacional', 'Corea del Sur', 2023, NULL,
  'https://kaystyle.com/images/exhibitions/festival-korea-del-sur.jpg'
),
(
  'Embajadora del Arte de América',
  'Título de nobleza otorgado a Karla como "Grande de las Artes" y Embajadora del Arte de América, por pintar el Bicentenario de América. Un reconocimiento a toda su trayectoria.',
  'Galería Jaime Chávez', 'América', 2022, NULL,
  'https://kaystyle.com/images/exhibitions/distincion-embajador-arte.jpg'
);

-- ============================================================
--  DONE. Refresh kaystyle.com — paintings + exhibitions now
--  come from the database and are fully editable in the admin.
-- ============================================================
