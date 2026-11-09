AAB ADVENTURE V4
================

CARA MENJALANKAN
1. Ekstrak AAB_Adventure_V4.zip.
2. Buka folder AAB_Adventure_V4.
3. Klik dua kali index.html untuk membuka web di browser.
4. Untuk mengedit, buka index.html menggunakan VS Code.

STRUKTUR
AAB_Adventure_V4/
  index.html
  assets/
    foto 7 anggota dan dokumentasi AAB

FITUR V4
- Tampilan responsif untuk laptop dan HP.
- Profil 7 anggota menggunakan nama samaran Abang 1–Abang 7.
- Galeri dokumentasi dengan tampilan foto besar.
- Whitelist 16 destinasi; Gunung Gede tercatat sebagai pencapaian pertama.
- Filter tercapai/belum tercapai dan pencarian destinasi.
- Progres otomatis tersimpan pada browser perangkat.
- Buku perjalanan untuk menulis catatan.
- Ekspor dan impor backup JSON agar data bisa dipindahkan.
- Tidak membutuhkan instalasi library atau database untuk dicoba secara lokal.

CATATAN PENTING
- Data progres dan jurnal V4 disimpan di browser perangkat (localStorage), bukan tersinkron otomatis ke semua pengunjung.
- Saat web dipublikasikan sebagai website statis, semua orang bisa melihatnya, tetapi perubahan progres/jurnal setiap pengunjung tetap tersimpan di browser masing-masing.
- Jika ingin satu akun admin dan data bersama yang tersinkron untuk semua orang, tahap berikutnya memerlukan backend/database dan sistem login.
- Untuk mengganti foto, pertahankan nama file di folder assets atau sesuaikan jalur gambar di index.html.
