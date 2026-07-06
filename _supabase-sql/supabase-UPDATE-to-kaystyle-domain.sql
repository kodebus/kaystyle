-- ============================================================
--  UPDATE IMAGE URLS → kaystyle.com
--  The site now lives at its own domain. Point every image
--  back to the clean kaystyle.com address.
--
--  Paste into Supabase → SQL Editor → New query → Run
-- ============================================================

UPDATE public.paintings
SET image_url = REPLACE(
  image_url,
  'https://www.japps.ai/sites/kaystyle/images/',
  'https://kaystyle.com/images/'
);

UPDATE public.exhibitions
SET image_url = REPLACE(
  image_url,
  'https://www.japps.ai/sites/kaystyle/images/',
  'https://kaystyle.com/images/'
);

UPDATE public.site_content
SET value = REPLACE(
  value,
  'https://www.japps.ai/sites/kaystyle/images/',
  'https://kaystyle.com/images/'
)
WHERE key = 'portrait_url';

-- ============================================================
--  DONE. Images now served from kaystyle.com
-- ============================================================
