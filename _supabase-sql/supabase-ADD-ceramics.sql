-- ============================================================
--  ADD ART TYPES + CERAMIC PIECES
--  1) Adds a "type" column to paintings (pintura / ceramica / varios)
--  2) Marks all existing works as 'pintura'
--  3) Inserts the two ceramic birds
--
--  Paste into Supabase → SQL Editor → New query → Run
-- ============================================================

-- 1) Add the type column (default 'pintura' so existing rows are safe)
ALTER TABLE public.paintings
ADD COLUMN IF NOT EXISTS type TEXT NOT NULL DEFAULT 'pintura';

-- 2) Ensure all current works are marked as paintings
UPDATE public.paintings SET type = 'pintura' WHERE type IS NULL OR type = '';

-- 3) Insert the two ceramic birds
INSERT INTO public.paintings (title, description, month, year, size, image_url, type) VALUES
(
  'Pájaro Rojo',
  'Ave de cerámica modelada y esmaltada a mano, en un rojo vibrante. Las alas se abren formando un pequeño cuenco esmaltado en gris con pinceladas doradas — una pieza que es a la vez escultura y objeto funcional.',
  NULL, NULL,
  'Cerámica esmaltada a mano',
  'https://kaystyle.com/images/ceramica-pajaro-rojo.jpg',
  'ceramica'
),
(
  'Petirrojo',
  'Petirrojo de cerámica modelado y esmaltado a mano, con pecho anaranjado, cabeza y alas en gris con vetas doradas, y vientre color crema. El acabado brillante y el ojo expresivo le dan vida. La cola se eleva formando un cuenco poco profundo.',
  NULL, NULL,
  'Cerámica esmaltada a mano',
  'https://kaystyle.com/images/ceramica-petirrojo.jpg',
  'ceramica'
);

-- ============================================================
--  DONE.
--  Add the two images to your repo as:
--    images/ceramica-pajaro-rojo.jpg   (from 2.jpg)
--    images/ceramica-petirrojo.jpg     (from 3.jpg)
-- ============================================================
