# Karla Martinez — Complete Website (kaystyle.com)

This is the full, current site. To deploy, put everything EXCEPT the
`_supabase-sql` folder into your GitHub `kaystyle` repo at the root level.

## Files that go in your repo (the website itself)
- index.html            → main site (gallery with Pinturas/Cerámica/Varios filter tabs)
- exposiciones.html     → exhibitions page
- admin.html            → Karla's login + editor (kaystyle.com/admin.html)
- config.js             → Supabase connection (your keys are already in it)
- CNAME                 → tells GitHub Pages your domain is kaystyle.com
- images/               → all painting, portrait, and ceramic images
- images/exhibitions/   → all exhibition images

## Reference only — do NOT upload these to the repo
- _supabase-sql/        → the SQL scripts we ran (kept for your records)
- SETUP-GUIDE.md        → original setup instructions
- WHATS-INSIDE.md       → this file

## If deploying fresh, the repo root should look like:
  index.html
  exposiciones.html
  admin.html
  config.js
  CNAME
  images/  (with everything inside)

## Reminders
- Supabase Site URL should be https://kaystyle.com (Authentication → URL Configuration)
- Karla logs in at kaystyle.com/admin.html
- Her account: karla@kaystyle.com (reset password from Supabase → Authentication → Users if needed)
