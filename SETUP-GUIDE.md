# Karla's Site + Admin Panel — Setup Guide

Your site now has an admin panel where Karla can log in and manage paintings,
exhibitions, her bio, portrait, and contact info. Here's how to finish setup.

---

## What's in this folder

- `index.html` — main site (now loads content from Supabase, falls back to built-in content)
- `exposiciones.html` — exhibitions page (same)
- `admin.html` — the login + editor panel (Karla uses this)
- `config.js` — where you paste your Supabase keys  ← **YOU MUST EDIT THIS**
- `supabase-site-content.sql` — one small table to add (for bio/contact editing)
- `images/` — current images (used as fallback before Supabase has data)

---

## Step 1 — Paste your Supabase keys into `config.js`

1. Open your Supabase project → **Project Settings → API**
2. Copy these two values into `config.js`:
   - **Project URL** → `SUPABASE_URL`
   - **Project API keys → `anon` `public`** → `SUPABASE_ANON_KEY`

⚠️ Only use the **anon public** key. Never paste the `service_role` key.

---

## Step 2 — Add the site_content table

Your paintings + exhibitions tables already exist. You just need one more
for the editable bio/contact.

1. Supabase → **SQL Editor → New query**
2. Paste the entire contents of `supabase-site-content.sql`
3. Click **Run**

---

## Step 3 — Create the `exhibitions` storage bucket

Your paintings bucket already exists. Add one for exhibition images:

1. Supabase → **Storage → New bucket**
2. Name it exactly `exhibitions`, check **Public bucket**, save.
3. Then go to **SQL Editor** and run this so admins can upload:

```sql
CREATE POLICY "Anyone can view exhibition images"
ON storage.objects FOR SELECT USING (bucket_id = 'exhibitions');

CREATE POLICY "Admins can upload exhibition images"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins can update exhibition images"
ON storage.objects FOR UPDATE
USING (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));

CREATE POLICY "Admins can delete exhibition images"
ON storage.objects FOR DELETE
USING (bucket_id = 'exhibitions' AND public.has_role(auth.uid(), 'admin'));
```

---

## Step 4 — Create Karla's login + make her an admin

1. Supabase → **Authentication → Users → Add user**
   - Email: `karla@kaystyle.com` (or whichever she'll use)
   - Set a password, and check **Auto Confirm User**
2. Copy her **User UID** (shown in the users list)
3. Supabase → **SQL Editor**, run this (paste her UID):

```sql
INSERT INTO public.user_roles (user_id, role)
VALUES ('PASTE-HER-USER-UID-HERE', 'admin');
```

Now she has edit permissions. Anyone else who logs in without this role can't edit.

---

## Step 5 — Deploy

Upload everything in this folder to your GitHub repo (same as before), keeping
the structure. `admin.html` and `config.js` sit next to `index.html`.

- Karla's site: `https://kaystyle.com`
- Karla's admin: `https://kaystyle.com/admin.html`

---

## How Karla uses it

1. Go to `kaystyle.com/admin.html`
2. Log in with her email + password
3. Three tabs: **Pinturas**, **Exposiciones**, **Sobre mí / Contacto**
4. Add / edit / delete freely, upload images. Changes appear on the live site
   immediately on reload — no code, no waiting.

---

## Important notes

- **Migrating current content:** the site shows the built-in paintings/exhibitions
  until you add them in the admin panel. Once you add even one painting in the
  panel, the site switches to showing the database list. So either add them all
  in the panel, or leave the panel empty to keep the built-in ones. (Tip: re-add
  each painting once through the panel using the images in the `images/` folder.)
- **Security:** editing is protected by Supabase Row Level Security + the admin
  role. The public can only read. The anon key in `config.js` is safe to expose.
- **Contact form:** still uses Web3Forms, unchanged.
