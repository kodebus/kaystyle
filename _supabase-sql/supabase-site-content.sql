-- ============================================================
--  SITE CONTENT ADD-ON
--  Lets the admin edit bio, portrait, and contact info.
--  Run AFTER your existing paintings + exhibitions schema.
--  Reuses your existing has_role() function.
-- ============================================================

-- Single-row key/value style table for editable site text + portrait
CREATE TABLE public.site_content (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  key TEXT NOT NULL UNIQUE,      -- e.g. 'bio_1', 'portrait_url', 'contact_email'
  value TEXT,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.site_content ENABLE ROW LEVEL SECURITY;

-- Anyone can read; only admins can change
CREATE POLICY "Anyone can view site content"
ON public.site_content
FOR SELECT
USING (true);

CREATE POLICY "Admins can insert site content"
ON public.site_content
FOR INSERT
WITH CHECK (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins can update site content"
ON public.site_content
FOR UPDATE
USING (public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins can delete site content"
ON public.site_content
FOR DELETE
USING (public.has_role(auth.uid(), 'admin'));

-- Timestamp trigger (reuses your existing function)
CREATE TRIGGER update_site_content_updated_at
BEFORE UPDATE ON public.site_content
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Seed the current site text so the admin panel starts populated.
INSERT INTO public.site_content (key, value) VALUES
  ('bio_1', 'Con más de tres décadas dedicadas al arte de la pintura al óleo, mi camino ha sido de exploración continua y expresión apasionada. Desde Ecuador, mi obra se nutre del rico patrimonio cultural y los paisajes impresionantes de Sudamérica.'),
  ('bio_2', 'Mis pinturas han sido expuestas en numerosas muestras de prestigio por toda Sudamérica, obteniendo reconocimiento por su vibrante uso del color, técnica magistral y profundidad emocional. Cada obra es un trabajo de amor, elaborado con esmero para capturar momentos de belleza y despertar emociones profundas.'),
  ('bio_3', 'Es un honor compartir mi obra con coleccionistas y amantes del arte en todo el mundo. Ya sea que busques una pieza central para tu hogar o desees ampliar tu colección, ofrezco envíos internacionales para llevar estas creaciones originales hasta donde estés.'),
  ('portrait_url', 'images/karla_portrait.jpg'),
  ('contact_email', 'karla@kaystyle.com'),
  ('contact_location', 'Ecuador, Sudamérica'),
  ('contact_shipping', 'Internacionales, empacados con cuidado')
ON CONFLICT (key) DO NOTHING;
