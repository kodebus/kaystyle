-- ============================================================
--  KARLA MARTINEZ — COMPLETE DATABASE SETUP (run once)
--  Paste ALL of this into Supabase → SQL Editor → New query → Run
-- ============================================================

-- ---------- ROLES ----------
CREATE TYPE public.app_role AS ENUM ('admin', 'user');

CREATE TABLE public.user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  role app_role NOT NULL,
  UNIQUE (user_id, role)
);
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN
LANGUAGE SQL STABLE SECURITY DEFINER SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = _user_id AND role = _role
  )
$$;

-- Allow logged-in users to read their own roles (needed by the admin panel)
CREATE POLICY "Users can view their own roles"
ON public.user_roles FOR SELECT
USING (auth.uid() = user_id);

-- ---------- TIMESTAMP HELPER ----------
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- ---------- PAINTINGS ----------
CREATE TABLE public.paintings (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  month TEXT,
  year INTEGER,
  size TEXT,
  image_url TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
ALTER TABLE public.paintings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view paintings" ON public.paintings FOR SELECT USING (true);
CREATE POLICY "Admins can insert paintings" ON public.paintings FOR INSERT WITH CHECK (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update paintings" ON public.paintings FOR UPDATE USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete paintings" ON public.paintings FOR DELETE USING (public.has_role(auth.uid(), 'admin'));

CREATE TRIGGER update_paintings_updated_at
BEFORE UPDATE ON public.paintings
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- ---------- EXHIBITIONS ----------
CREATE TABLE public.exhibitions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  venue TEXT NOT NULL,
  location TEXT NOT NULL,
  year INTEGER NOT NULL,
  month TEXT,
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
ALTER TABLE public.exhibitions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view exhibitions" ON public.exhibitions FOR SELECT USING (true);
CREATE POLICY "Admins can insert exhibitions" ON public.exhibitions FOR INSERT WITH CHECK (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update exhibitions" ON public.exhibitions FOR UPDATE USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete exhibitions" ON public.exhibitions FOR DELETE USING (public.has_role(auth.uid(), 'admin'));

CREATE TRIGGER update_exhibitions_updated_at
BEFORE UPDATE ON public.exhibitions
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- ---------- SITE CONTENT (bio, portrait, contact) ----------
CREATE TABLE public.site_content (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  key TEXT NOT NULL UNIQUE,
  value TEXT,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);
ALTER TABLE public.site_content ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view site content" ON public.site_content FOR SELECT USING (true);
CREATE POLICY "Admins can insert site content" ON public.site_content FOR INSERT WITH CHECK (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update site content" ON public.site_content FOR UPDATE USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete site content" ON public.site_content FOR DELETE USING (public.has_role(auth.uid(), 'admin'));

CREATE TRIGGER update_site_content_updated_at
BEFORE UPDATE ON public.site_content
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

INSERT INTO public.site_content (key, value) VALUES
  ('bio_1', 'Con más de tres décadas dedicadas al arte de la pintura al óleo, mi camino ha sido de exploración continua y expresión apasionada. Desde Ecuador, mi obra se nutre del rico patrimonio cultural y los paisajes impresionantes de Sudamérica.'),
  ('bio_2', 'Mis pinturas han sido expuestas en numerosas muestras de prestigio por toda Sudamérica, obteniendo reconocimiento por su vibrante uso del color, técnica magistral y profundidad emocional. Cada obra es un trabajo de amor, elaborado con esmero para capturar momentos de belleza y despertar emociones profundas.'),
  ('bio_3', 'Es un honor compartir mi obra con coleccionistas y amantes del arte en todo el mundo. Ya sea que busques una pieza central para tu hogar o desees ampliar tu colección, ofrezco envíos internacionales para llevar estas creaciones originales hasta donde estés.'),
  ('portrait_url', 'images/karla_portrait.jpg'),
  ('contact_email', 'karla@kaystyle.com'),
  ('contact_location', 'Ecuador, Sudamérica'),
  ('contact_shipping', 'Internacionales, empacados con cuidado')
ON CONFLICT (key) DO NOTHING;

-- ---------- STORAGE BUCKETS ----------
INSERT INTO storage.buckets (id, name, public) VALUES ('paintings', 'paintings', true) ON CONFLICT (id) DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('exhibitions', 'exhibitions', true) ON CONFLICT (id) DO NOTHING;

-- paintings bucket policies
CREATE POLICY "Anyone can view painting images" ON storage.objects FOR SELECT USING (bucket_id = 'paintings');
CREATE POLICY "Admins can upload painting images" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'paintings' AND public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update painting images" ON storage.objects FOR UPDATE USING (bucket_id = 'paintings' AND public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete painting images" ON storage.objects FOR DELETE USING (bucket_id = 'paintings' AND public.has_role(auth.uid(), 'admin'));

-- exhibitions bucket policies
CREATE POLICY "Anyone can view exhibition images" ON storage.objects FOR SELECT USING (bucket_id = 'exhibitions');
CREATE POLICY "Admins can upload exhibition images" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update exhibition images" ON storage.objects FOR UPDATE USING (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete exhibition images" ON storage.objects FOR DELETE USING (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));

-- ============================================================
--  DONE. Next: create your user in Authentication, then run:
--
--  INSERT INTO public.user_roles (user_id, role)
--  VALUES ('YOUR-USER-UID', 'admin');
-- ============================================================
