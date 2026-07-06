-- ============================================================
--  FIX IMAGE URLS
--  Your files live at japps.ai/sites/kaystyle/, not kaystyle.com.
--  This updates every painting + exhibition image URL to the
--  correct, working address.
--
--  Paste ALL of this into Supabase → SQL Editor → New query → Run
-- ============================================================

-- Fix paintings: swap the old base URL for the correct one
UPDATE public.paintings
SET image_url = REPLACE(
  image_url,
  'https://kaystyle.com/images/',
  'https://www.japps.ai/sites/kaystyle/images/'
);

-- Fix exhibitions the same way
UPDATE public.exhibitions
SET image_url = REPLACE(
  image_url,
  'https://kaystyle.com/images/',
  'https://www.japps.ai/sites/kaystyle/images/'
);

-- Fix the portrait in site_content (if it points to kaystyle.com)
UPDATE public.site_content
SET value = REPLACE(
  value,
  'https://kaystyle.com/images/',
  'https://www.japps.ai/sites/kaystyle/images/'
)
WHERE key = 'portrait_url' AND value LIKE 'https://kaystyle.com/%';

-- ============================================================
--  DONE. Refresh the site — all images should now load.
-- ============================================================
