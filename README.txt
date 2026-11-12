AAB ADVENTURE V6 — WEBSITE + PORTAL KEUANGAN

ISI PAKET
- index.html: website publik AAB Adventure.
- portal.html: portal login dan dashboard keuangan.
- portal-aab.html: salinan portal untuk pengujian lokal.
- supabase-setup.sql: skema dan kebijakan keamanan database (RLS).
- assets/: foto anggota dan dokumentasi AAB yang tersedia di paket sumber.

PENTING SEBELUM LOGIN
1. Pastikan 8 akun sudah ada di Supabase Authentication > Users.
2. Email login Abang 1–7 mengikuti pola abang1@aab.local sampai abang7@aab.local.
3. Username superadmin/bosbesar diarahkan ke email Auth BOS BESAR yang disetel pada konstanta SUPER_ADMIN_EMAIL di portal.html.
4. Nilai SUPER_ADMIN_EMAIL pada paket ini adalah jakseldoraemon@gmail.com berdasarkan informasi percakapan. Pastikan email ini benar-benar akun Auth yang UID-nya sama dengan profiles.id untuk profil role super_admin. Jika berbeda, ubah nilainya.
5. Setiap profil harus memiliki id yang sama persis dengan UUID pengguna di Authentication > Users. Role harus super_admin untuk BOS BESAR dan admin untuk Abang 1–7.
6. Password tidak disimpan di file dan tidak bisa dibaca dari Supabase. Gunakan password yang dibuat saat akun Auth dibuat atau reset password dari Supabase.
7. Supabase Publishable Key boleh berada di frontend. Jangan pernah memasukkan sb_secret/service_role key ke file HTML atau GitHub.

PENGUJIAN
- Buka portal.html melalui server lokal atau hosting (misalnya branch preview GitHub Pages).
- File HTML yang dibuka dengan file:// mungkin tetap memuat Supabase, tetapi server lokal/hosting lebih disarankan.
- Jika login gagal, baca pesan pada kotak login. Periksa email Auth, password, UID pada profiles, role, dan kebijakan RLS.
- Login belum dapat dinyatakan berhasil sebelum diuji dengan kredensial nyata di project Supabase.

HAK AKSES YANG DITUJU
- SUPER ADMIN: akses seluruh kas organisasi dan seluruh tabungan.
- Abang 1–7: akses kas organisasi dan tabungan milik akun masing-masing.
- Pembatasan data tabungan harus ditegakkan oleh RLS di Supabase, bukan hanya tampilan website.

DEPLOY AMAN
1. Cadangkan repository/website lama.
2. Buat branch preview, jangan timpa main terlebih dahulu.
3. Unggah index.html, portal.html, supabase-setup.sql, dan folder assets dengan struktur tetap.
4. Uji website publik, login tiap peran, pembatasan data, dan transaksi dummy.
5. Baru gabungkan ke branch utama setelah seluruh pengujian lolos.
