# AAB ADVENTURE V6 — WEBSITE + PORTAL 8 AKUN

## Peran yang dituju
- BOS BESAR: `super_admin`, akses kas organisasi dan seluruh tabungan.
- Abang 1 sampai Abang 7: `admin`, akses kas organisasi dan tabungan milik sendiri.
- Kebijakan RLS Supabase harus aktif agar pembatasan benar-benar berlaku di database.

## Login portal
- Username Abang: `abang1` sampai `abang7`; email Auth masing-masing mengikuti `abangN@aab.local`.
- Username BOS BESAR: `superadmin` atau `bosbesar`; portal mengarahkan ke nilai `SUPER_ADMIN_EMAIL` di `portal.html`. Nilai paket saat ini `jakseldoraemon@gmail.com`; pastikan itu email Auth yang UUID-nya sama dengan `profiles.id` BOS BESAR.
- Password tidak dapat ditampilkan kembali dari Supabase. Gunakan password saat membuat akun atau lakukan reset password.

## Verifikasi sebelum produksi
1. Cocokkan setiap `auth.users.id` dengan `profiles.id`.
2. Pastikan role BOS BESAR `super_admin`, dan tujuh akun lain `admin`.
3. Pastikan email confirmation sesuai alur pembuatan akun.
4. Uji login masing-masing akun.
5. Uji bahwa Abang tidak dapat membaca tabungan anggota lain, sedangkan BOS BESAR dapat membaca seluruhnya.
6. Uji transaksi dummy sebelum memakai data keuangan nyata.

Jangan menaruh `sb_secret` atau `service_role` key di frontend. Jangan deploy ke branch utama sebelum pengujian selesai.
