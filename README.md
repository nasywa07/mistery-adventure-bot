# 🎮 THE MYSTERY ADVENTURE BOT - Pencarian Kitab Suci

Game petualangan interaktif berbasis teks tentang pencarian harta karun (Kitab Suci) di SMAN 1 YOGYAKARTA dengan karakter utama Ayrus.

## 📖 Deskripsi Game

Anda dimulai di halaman SMAN 1 YOGYAKARTA dengan misi mencari Kitab Suci yang tersembunyi. Jelajahi berbagai lokasi di sekolah, berbicara dengan NPC yang berbeda, kumpulkan item, dan pecahkan misteri untuk menemukan kitab suci!

## 🎯 Fitur Utama

- **8 Lokasi Berbeda**: Halaman, Perpustakaan, Ruang Arsip, Kamar Rahasia, Ruang Guru, Lab Komputer, Kantor Kepala, dan Aula
- **8 NPC Interaktif**: Satpam, Ibu Pustakawan, Pak Guru Fisika, Guru TI, Sekretaris Kepala, Roh Penjaga, dan Penari
- **Sistem Inventori**: Kumpulkan item penting untuk membuka akses ke lokasi-lokasi baru
- **Nilai Misteri & Moralitas**: Raih poin dengan menjelajahi, berbicara dengan NPC, dan mengumpulkan item
- **4 Teka-teki Puzzle**: Pecahkan teka-teki cerdas di lokasi-lokasi berbeda untuk mendapat skor bonus
- **Multiple Endings**: Lihat 5+ ending yang berbeda berdasarkan pilihan dan performa Anda
- **Sistem Kesehatan**: Monitor kondisi pemain selama petualangan
- **Gameplay Non-Linear**: Jelajahi sesuai keinginan Anda

## 🎮 Cara Bermain

### Perintah Utama
- **L** - Lihat deskripsi lokasi saat ini
- **A** - Ambil item (jika tersedia)
- **B** - Bicara dengan NPC untuk mendapat petunjuk
- **T** - Jawab Teka-teki di lokasi saat ini
- **P** - Pindah ke lokasi lain
- **I** - Lihat inventori Anda
- **K** - Keluar dari permainan

### Strategi Bermain
1. Mulai dari Halaman Sekolah
2. Jelajahi setiap lokasi dan ambil item yang Anda temukan
3. Berbicara dengan NPC untuk mendapatkan petunjuk
4. Cari Kunci Emas - item kunci untuk membuka Kamar Rahasia
5. Dengan Kunci Emas, buka Kamar Rahasia dan ambil Kitab Suci!

## 📍 Lokasi-Lokasi

| Lokasi | Deskripsi | Item | NPC |
|--------|-----------|------|-----|
| **Halaman** | Pusat sekolah, titik awal | - | Satpam Pak Jono |
| **Perpustakaan** | Berisi ribuan buku tua | Buku Petunjuk | Ibu Pustakawan |
| **Ruang Arsip** | Tersembunyi di belakang perpustakaan | Kunci Emas | - |
| **Kamar Rahasia** | Hanya bisa dibuka dengan Kunci Emas | **Kitab Suci** | Roh Penjaga |
| **Ruang Guru** | Penuh dengan meja kerja | Catatan Tersembunyi | Pak Guru Fisika |
| **Lab Komputer** | Puluhan mesin berjajar rapi | - | Guru TI |
| **Kantor Kepala** | Kantor mewah dan sepi | Surat Rahasia | Sekretaris Kepala |
| **Aula** | Ruang besar untuk acara penting | - | Penari Tari |

## 🧩 Teka-Teki (Puzzle System)

Game ini memiliki 4 teka-teki yang harus dipecahkan untuk mendapatkan skor tertinggi:

### 1. **Teka-teki Buku** (Perpustakaan)
```
"Saya memiliki halaman tapi tidak bisa berjalan,
Saya memiliki tulang tapi tidak hidup.
Aku bisa menutup mulutmu tanpa berbicara.
Apa aku?"
```
**Jawaban**: Buku (atau Kitab/Novel)  
**Bonus**: +20 Nilai Misteri

### 2. **Teka-teki Komputer** (Lab Komputer)
```
"Angka ajaib sekolah ini terdapat pada:
Tahun berdirinya (1947) + Nomor ruang terbawah (101) - Jumlah bendera (1) = ?"
```
**Jawaban**: 2047  
**Bonus**: +25 Nilai Misteri

### 3. **Teka-teki Kode** (Ruang Arsip)
```
"Tanggal Kemerdekaan (17-08) + Nomor Kelas Tua (IX) = ?"
```
**Jawaban**: 1708 atau 1709  
**Bonus**: +30 Nilai Misteri

### 4. **Teka-teki Final** (Kamar Rahasia)
```
"Berapa banyak NPC yang telah Anda temui? (Jangan hitung roh ini)"
```
**Jawaban**: 7 atau 8  
**Bonus**: +40 Nilai Misteri

## 🎬 Sistem Ending (Multiple Endings)

Game ini memiliki **5+ ending berbeda** berdasarkan:
- **Nilai Misteri**: Jumlah poin yang dikumpulkan
- **Teka-teki Diselesaikan**: Berapa banyak puzzle yang Anda selesaikan
- **Pilihan Moralitas**: Keputusan yang Anda buat sepanjang game

### Ending yang Tersedia:

| Ending | Syarat | Rating | Deskripsi |
|--------|--------|--------|-----------|
| **Keberuntungan Semata** | Teka-teki < 2 | ⭐ Standar | Menemukan kitab tanpa banyak usaha |
| **Penerus Biasa** | Misteri 80-99 | ⭐ Cukup | Perjalanan yang panjang tapi biasa |
| **Penjelajah Sejati** | Misteri 80+ | ⭐ Sangat Baik | Dedikasi yang luar biasa |
| **Pemilih dari Takdir** | Misteri 100+ & Puzzle 2+ | ⭐⭐ Sempurna | Pahlawan sejati yang terpilih |
| **Master of Mysteries** | Misteri 120+ & Puzzle 3+ | ⭐⭐⭐ MASTER | Pencapaian tertinggi |
| **Pencari yang Ragu** | Keluar tanpa mengambil kitab | ❌ Incomplete | Kehilangan kesempatan seumur hidup |

Kumpulkan **Kitab Suci** dan raih skor Nilai Misteri setinggi mungkin. Game berakhir ketika Anda berhasil mengambil Kitab Suci dari Kamar Rahasia!

## 💻 Cara Menjalankan

```bash
python main.p
```

atau

```bash
python3 main.p
```

## 📝 Persyaratan

- Python 3.x
- Terminal/Command Prompt

## 🎨 Elemen Gameplay

- **Eksplorasi**: Jelajahi 8 lokasi unik di sekolah
- **Interaksi**: Berbicara dengan 7+ NPC yang masing-masing punya dialog unik
- **Pengumpulan Item**: Temukan dan kumpulkan item penting
- **Progres Misteri**: Tingkatkan nilai misteri dengan setiap aksi
- **Puzzle Element**: Temukan kunci yang tepat untuk membuka pintu rahasia

## 🎬 Alur Cerita

Ayrus mendapat informasi bahwa ada Kitab Suci yang tersembunyi di SMAN 1 YOGYAKARTA. Dipercaya bahwa kitab ini mengandung kebijaksanaan kuno yang sangat berharga. Dengan petualangan yang menegangkan, Ayrus harus menjelajahi sekolah, mengumpulkan petunjuk dari berbagai sumber, dan menemukan kunci rahasia untuk membuka Kamar Rahasia di mana Kitab Suci tersimpan.

## 👨‍💻 Developer

Created as an interactive text adventure game for educational entertainment.

---

**Selamat berpetualang! 🗺️✨**