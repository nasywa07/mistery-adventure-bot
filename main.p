import time
import random

class PermainanMisteri:
    def __init__(self):
        self.nama_pemain = ""
        self.lokasi_saat_ini = "halaman"
        self.inventori = []
        self.kesehatan = 100
        self.nilai_misteri = 0
        self.kunci_ditemukan = False
        self.teka_teki_selesai = {}
        self.pilihan_moralitas = 0  # Positif atau negatif mempengaruhi ending
        self.peta_sekolah = {
            "halaman": {
                "deskripsi": "Halaman sekolah yang luas dengan tiang bendera di tengahnya.",
                "terhubung_ke": ["perpustakaan", "ruang_guru", "kantor_kepala"],
                "item": None,
                "npc": ["satpam_pak_jono"],
                "teka_teki": None
            },
            "perpustakaan": {
                "deskripsi": "Perpustakaan sekolah berisi ribuan buku. Udara terasa sejuk dan tenang.",
                "terhubung_ke": ["halaman", "ruang_arkip"],
                "item": "buku_petunjuk",
                "npc": ["ibu_pustakawan"],
                "teka_teki": "teka_teki_buku"
            },
            "ruang_arkip": {
                "deskripsi": "Ruang arsip tersembunyi di belakang perpustakaan. Debu menari-nari di udara.",
                "terhubung_ke": ["perpustakaan", "kamar_rahasia"],
                "item": "kunci_emas",
                "npc": None,
                "teka_teki": "teka_teki_kode"
            },
            "kamar_rahasia": {
                "deskripsi": "Kamar rahasia yang hanya bisa dibuka dengan kunci emas. Di sini terletak kitab suci!",
                "terhubung_ke": ["ruang_arkip"],
                "item": "kitab_suci",
                "npc": ["roh_penjaga"],
                "teka_teki": "teka_teki_final"
            },
            "ruang_guru": {
                "deskripsi": "Ruang guru yang penuh dengan meja kerja dan buku-buku pembelajaran.",
                "terhubung_ke": ["halaman", "lab_komputer"],
                "item": "catatan_tersembunyi",
                "npc": ["pak_guru_fisika"],
                "teka_teki": None
            },
            "lab_komputer": {
                "deskripsi": "Lab komputer dengan puluhan mesin yang berjajar rapi.",
                "terhubung_ke": ["ruang_guru", "aula"],
                "item": None,
                "npc": ["guru_ti"],
                "teka_teki": "teka_teki_komputer"
            },
            "kantor_kepala": {
                "deskripsi": "Kantor kepala sekolah yang mewah namun sepi.",
                "terhubung_ke": ["halaman"],
                "item": "surat_rahasia",
                "npc": ["sekretaris_kepala"],
                "teka_teki": None
            },
            "aula": {
                "deskripsi": "Aula sekolah yang besar, biasanya digunakan untuk acara penting.",
                "terhubung_ke": ["lab_komputer"],
                "item": None,
                "npc": ["penari_tari"],
                "teka_teki": None
            }
        }
        
        self.DATABASE_TEKA_TEKI = {
            "teka_teki_buku": {
                "pertanyaan": """
                Di perpustakaan, Ibu Pustakawan mengajukan teka-teki:
                "Saya memiliki halaman tapi tidak bisa berjalan,
                Saya memiliki tulang tapi tidak hidup.
                Aku bisa menutup mulutmu tanpa berbicara.
                Apa aku?"
                """,
                "jawaban_benar": ["buku", "kitab", "novel"],
                "hadiah": 20
            },
            "teka_teki_komputer": {
                "pertanyaan": """
                Guru TI memberikan teka-teki:
                "Angka ajaib sekolah ini terdapat pada:
                Tahun berdirinya (1947) + Nomor ruang terbawah (101) - Jumlah bendera di halaman (1) = ?
                Masukkan bersama kode di kantor kepala untuk membuka pintu!"
                """,
                "jawaban_benar": ["2047", "2.047"],
                "hadiah": 25
            },
            "teka_teki_kode": {
                "pertanyaan": """
                Saat membuka lemari di Ruang Arsip, Anda menemukan papan kode:
                "Tanggal Kemerdekaan (17-08) + Nomor Kelas Tua (IX) = ?"
                Masukkan dalam format: DDBB (contoh: 1708 atau 1709 jika IX=9)"
                """,
                "jawaban_benar": ["1708", "1709"],
                "hadiah": 30
            },
            "teka_teki_final": {
                "pertanyaan": """
                Roh Penjaga Kitab Suci berbisik dengan suara mistis:
                "Sebelum Anda mengambil kitab suci, jawab pertanyaan terakhir:
                Berapa banyak NPC yang telah Anda temui? (Jangan hitung roh ini)"
                """,
                "jawaban_benar": ["7", "tujuh", "8", "delapan"],
                "hadiah": 40
            }
        }
        self.npc_data = {
            "satpam_pak_jono": {
                "dialog": "Halo anak muda! Kamu mencari sesuatu? Katanya ada legenda tentang kitab suci di sekolah ini.",
                "info": "Coba cek perpustakaan, banyak buku tua di sana."
            },
            "ibu_pustakawan": {
                "dialog": "Selamat datang di perpustakaan. Ada yang bisa saya bantu?",
                "info": "Kitab suci yang Anda cari mungkin disimpan di tempat yang aman. Ada petunjuk di buku-buku lama kami."
            },
            "pak_guru_fisika": {
                "dialog": "Oh, Ayrus! Apa kabar? Sedang mencari petualangan?",
                "info": "Ada informasi menarik di surat yang ada di kantor kepala."
            },
            "guru_ti": {
                "dialog": "Halo! Kamu ingin belajar tentang misteri komputer atau misteri sekolah?",
                "info": "Data penting sering dikodekan. Pikirkan angka dan tanggal penting sekolah ini."
            },
            "sekretaris_kepala": {
                "dialog": "Ada surat penting yang dititipkan untuk penerus yang berani. Apakah itu kamu?",
                "info": "Surat berisi kode untuk membuka pintu rahasia."
            },
            "roh_penjaga": {
                "dialog": "...(suara misterius)... Aku adalah penjaga kitab suci selama berabad-abad...",
                "info": "Jika kamu berhasil sampai ke sini, itulah bukti bahwa Anda layak memiliki kitab suci."
            },
            "penari_tari": {
                "dialog": "Hai! Sedang latihan untuk acara tari. Ada yang bisa aku bantu?",
                "info": "Dengarkan dari mereka yang ada di lab komputer, ada kode rahasia di sana."
            }
        }

    def cetak_judul(self):
        print("\n" + "="*60)
        print("   THE MYSTERY ADVENTURE BOT - PENCARIAN KITAB SUCI".center(60))
        print("   SMAN 1 YOGYAKARTA".center(60))
        print("="*60 + "\n")

    def tampilkan_status(self):
        print(f"\n[Pemain: {self.nama_pemain} | Kesehatan: {self.kesehatan}% | Misteri: {self.nilai_misteri}/100]")
        print(f"[Inventori: {', '.join(self.inventori) if self.inventori else 'Kosong'}]")
        print(f"[Lokasi: {self.lokasi_saat_ini.upper()}]\n")

    def tampilkan_lokasi(self):
        lokasi = self.peta_sekolah[self.lokasi_saat_ini]
        print(f"\n>>> {lokasi['deskripsi']}")
        
        if lokasi['item']:
            print(f"[ITEM] Anda melihat: {lokasi['item']}")
        
        if lokasi['npc']:
            print(f"[NPC] Ada seseorang di sini: {', '.join(lokasi['npc'])}")
        
        if lokasi['teka_teki'] and lokasi['teka_teki'] not in self.teka_teki_selesai:
            print(f"[TEKA-TEKI] 💡 Ada teka-teki yang perlu diselesaikan di lokasi ini!")
        
        print(f"\n[PINTU] Anda bisa pergi ke: {', '.join(lokasi['terhubung_ke'])}")

    def ambil_item(self):
        lokasi = self.peta_sekolah[self.lokasi_saat_ini]
        if lokasi['item']:
            item = lokasi['item']
            self.inventori.append(item)
            self.nilai_misteri += 15
            print(f"\n✓ Anda mengambil: {item}")
            print(f"✓ Nilai Misteri +15 (Total: {self.nilai_misteri})")
            
            if item == "kunci_emas":
                print(">>> Kunci emas! Ini terlihat seperti kunci untuk membuka sesuatu yang penting...")
            elif item == "kitab_suci":
                print(">>> KITAB SUCI! Inilah yang Anda cari selama ini!")
                return True
            
            lokasi['item'] = None
        else:
            print("\n✗ Tidak ada item di sini.")
        return False

    def jawab_teka_teki(self):
        lokasi = self.peta_sekolah[self.lokasi_saat_ini]
        
        if not lokasi['teka_teki']:
            print("\n✗ Tidak ada teka-teki di lokasi ini.")
            return
        
        teka_teki_id = lokasi['teka_teki']
        
        if teka_teki_id in self.teka_teki_selesai:
            print(f"\n✓ Anda sudah menyelesaikan teka-teki ini!")
            return
        
        teka_teki = self.DATABASE_TEKA_TEKI[teka_teki_id]
        print(teka_teki['pertanyaan'])
        
        jawaban = input("\nJawaban Anda: ").strip().lower()
        jawaban_benar = [j.lower() for j in teka_teki['jawaban_benar']]
        
        if jawaban in jawaban_benar:
            print(f"\n✓✓✓ JAWABAN BENAR! ✓✓✓")
            print(f"✓ Nilai Misteri +{teka_teki['hadiah']}")
            self.nilai_misteri += teka_teki['hadiah']
            self.teka_teki_selesai[teka_teki_id] = True
            
            if teka_teki_id == "teka_teki_final":
                self.pilihan_moralitas += 30
        else:
            print(f"\n✗ Jawaban salah. Coba lagi nanti...")
            self.pilihan_moralitas -= 10

    def interaksi_npc(self):
        lokasi = self.peta_sekolah[self.lokasi_saat_ini]
        if not lokasi['npc']:
            print("\n✗ Tidak ada orang di sini.")
            return
        
        print("\n[NPC TERSEDIA]")
        for i, npc in enumerate(lokasi['npc'], 1):
            print(f"{i}. {npc}")
        
        try:
            pilihan = int(input("\nPilih NPC (nomor): "))
            if 0 < pilihan <= len(lokasi['npc']):
                npc = lokasi['npc'][pilihan - 1]
                data = self.npc_data[npc]
                print(f"\n{npc}: {data['dialog']}")
                print(f">>> {data['info']}")
                self.nilai_misteri += 5
                print(f"✓ Nilai Misteri +5 (Total: {self.nilai_misteri})")
            else:
                print("✗ Pilihan tidak valid.")
        except ValueError:
            print("✗ Masukkan angka yang benar.")

    def pindah_lokasi(self):
        lokasi = self.peta_sekolah[self.lokasi_saat_ini]
        print(f"\n[ARAH YANG BISA DITUJU]")
        for i, tujuan in enumerate(lokasi['terhubung_ke'], 1):
            print(f"{i}. {tujuan}")
        
        try:
            pilihan = int(input("\nPilih arah (nomor): "))
            if 0 < pilihan <= len(lokasi['terhubung_ke']):
                self.lokasi_saat_ini = lokasi['terhubung_ke'][pilihan - 1]
                self.nilai_misteri += 2
                print(f"\n➜ Anda berjalan menuju {self.lokasi_saat_ini}...")
                time.sleep(1)
                self.tampilkan_lokasi()
            else:
                print("✗ Pilihan tidak valid.")
        except ValueError:
            print("✗ Masukkan angka yang benar.")

    def cek_persyaratan(self):
        """Cek apakah pemain bisa memasuki ruang rahasia"""
        if "kunci_emas" not in self.inventori:
            print("\n✗ Anda membutuhkan kunci emas untuk membuka kamar rahasia!")
            return False
        return True

    def bermain(self):
        self.cetak_judul()
        
        print("Selamat datang di THE MYSTERY ADVENTURE BOT!\n")
        nama = input("Siapa nama Anda? ")
        self.nama_pemain = nama if nama else "Ayrus"
        
        print(f"\nDengarkan, {self.nama_pemain}! Kami mendapat informasi bahwa terdapat sebuah kitab suci")
        print("yang tersembunyi di SMAN 1 YOGYAKARTA. Kitab ini dipercaya mengandung kebijaksanaan kuno.")
        print("Misi Anda adalah menemukan kitab tersebut sebelum orang lain mengemukakannya!")
        print("\nPerintah:")
        print("- [L]ihat lokasi saat ini")
        print("- [A]mbil item")
        print("- [B]icara dengan NPC")
        print("- [T]eka-teki (jawab puzzle)")
        print("- [P]indah lokasi")
        print("- [I]nventori")
        print("- [K]eluar")
        
        time.sleep(2)
        self.tampilkan_status()
        self.tampilkan_lokasi()
        
        permainan_selesai = False
        while not permainan_selesai:
            perintah = input("\nMasukkan perintah (L/A/B/T/P/I/K): ").upper()
            
            if perintah == "L":
                self.tampilkan_lokasi()
            elif perintah == "A":
                if self.lokasi_saat_ini == "kamar_rahasia" and not self.cek_persyaratan():
                    continue
                if self.ambil_item():
                    permainan_selesai = True
            elif perintah == "B":
                self.interaksi_npc()
            elif perintah == "T":
                self.jawab_teka_teki()
            elif perintah == "P":
                self.pindah_lokasi()
            elif perintah == "I":
                print(f"\n[INVENTORI ANDA]")
                if self.inventori:
                    for item in self.inventori:
                        print(f"  • {item}")
                    print(f"\nTotal item: {len(self.inventori)}")
                else:
                    print("  Masih kosong...")
            elif perintah == "K":
                print(f"\nTerima kasih telah bermain, {self.nama_pemain}!")
                break
            else:
                print("✗ Perintah tidak dikenal. Coba lagi!")
            
            self.tampilkan_status()
        
        if "kitab_suci" in self.inventori:
            self.tampilkan_ending()
        else:
            self.tampilkan_ending_keluar()
    
    def tampilkan_ending(self):
        """Menampilkan ending berdasarkan nilai misteri dan pilihan moralitas"""
        total_teka_teki_selesai = len(self.teka_teki_selesai)
        
        print("\n" + "="*70)
        print("ENDING".center(70))
        print("="*70)
        
        # Tentukan ending berdasarkan nilai misteri dan teka-teki yang diselesaikan
        if total_teka_teki_selesai < 2:
            self.ending_peruntuk()
        elif self.nilai_misteri >= 120 and total_teka_teki_selesai >= 3:
            self.ending_paling_sempurna()
        elif self.nilai_misteri >= 100 and total_teka_teki_selesai >= 2:
            self.ending_sempurna()
        elif self.nilai_misteri >= 80:
            self.ending_baik()
        else:
            self.ending_standar()
    
    def ending_peruntuk(self):
        """Ending paling sedikit teka-teki diselesaikan"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║                    ENDING: KEBERUNTUNGAN SEMATA                    ║
╚════════════════════════════════════════════════════════════════════╝

Dengan sedikit informasi dan keberuntungan, {self.nama_pemain} akhirnya berhasil
menemukan Kitab Suci. Namun, roh penjaga yang maha kuasa tampak tidak puas
dengan kurangnya dedikasi Anda untuk memecahkan misteri.

Kitab Suci terbuka dengan perlahan, dan cahaya emas menyilaukan mata.
Namun, hanya beberapa halaman pertama yang terbaca jelas. Sisa rahasianya
tetap tersembunyi untuk mereka yang tidak berdedikasi penuh.

Anda membawa Kitab Suci keluar, namun terasa sesuatu yang kurang...
Kebijaksanaan sejati bukanlah milik mereka yang berjalan tanpa tujuan.

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐ Rating: Standar (Untung-untungan)
        """)
    
    def ending_standar(self):
        """Ending dengan performa biasa"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║                    ENDING: PENERUS BIASA                          ║
╚════════════════════════════════════════════════════════════════════╝

{self.nama_pemain} berhasil menemukan Kitab Suci setelah petualangan yang
panjang. Meski tidak sempurna, Anda telah menunjukkan ketekunan yang cukup.

Roh penjaga tersenyum dengan sabar. "Kamu cukup berdedikasi," bisiknya.

Kitab Suci terbuka dengan mulus, menampilkan halaman demi halaman berisi
kebijaksanaan kuno. Beberapa ajaran pun mulai menerpa hati Anda.
Masa depan yang gemilang menanti...

Namun, Anda tahu masih ada lebih banyak rahasia yang belum terbongkar.

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐ Rating: Cukup (Keep Exploring!)
        """)
    
    def ending_baik(self):
        """Ending dengan performa baik"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║                    ENDING: PENJELAJAH SEJATI                       ║
╚════════════════════════════════════════════════════════════════════╝

{self.nama_pemain} telah menunjukkan dedikasi yang luar biasa dalam mencari
Kitab Suci. Melalui petualangan yang penuh tantangan, Anda telah mengumpulkan
banyak pengetahuan tersembunyi.

Roh penjaga memberikan hormat khusus. "Kamu adalah pencari sejati," katanya
dengan suara yang bergetar emosi.

Kitab Suci merespons kehadiran Anda dengan bersinar terang. Setiap halaman
yang Anda baca membawa pemahaman baru tentang dunia dan diri sendiri.
Kebijaksanaan yang Anda peroleh akan mengubah jalan hidup selamanya.

Anda tahu ini baru permulaan dari petualangan yang lebih besar.

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐ Rating: Sangat Baik (Path of Wisdom)
        """)
    
    def ending_sempurna(self):
        """Ending sempurna dengan banyak teka-teki diselesaikan"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║                  ENDING: PEMILIH DARI TAKDIR                      ║
╚════════════════════════════════════════════════════════════════════╝

{self.nama_pemain}... nama yang akan diabadikan dalam sejarah SMAN 1 
YOGYAKARTA. Anda telah melampaui semua harapan dengan menyelesaikan 
teka-teki kuno yang bahkan guru-guru tidak bisa memecahkannya.

Roh penjaga berdiri tegak, matanya bersinar dengan cahaya langit. 
"Akhirnya, mereka yang benar-benar layak telah datang. Kamu bukan hanya 
pencari, tetapi Pemilih dari Takdir!"

Kitab Suci meresponansi dengan simfoni cahaya yang menggetarkan setiap atom
di sekitarnya. Segala halaman terbuka sekaligus, menampilkan pengetahuan 
universal yang telah lama tersimpan. Anda merasakan koneksi langsung dengan
kebijaksanaan para leluhur.

SMAN 1 YOGYAKARTA akan dikenang bukan hanya sebagai sekolah, tetapi sebagai
tempat di mana seorang pahlawan menemukan takdir mereka.

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐ Rating: Sempurna (Hall of Fame Material!)
🏆 ACHIEVEMENT UNLOCKED: Penebus Kitab Suci
        """)
    
    def ending_paling_sempurna(self):
        """Ending paling sempurna dengan semua/hampir semua teka-teki selesai"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║          ENDING: MASTER OF MYSTERIES ~ PAHLAWAN SEJATI             ║
╚════════════════════════════════════════════════════════════════════╝

{self.nama_pemain}... Nama ini akan diukir dalam batu emas di gerbang sekolah.

Anda telah melakukan apa yang tidak mungkin dilakukan - memecahkan SETIAP 
teka-teki, mengumpulkan SETIAP petunjuk, dan mengerti SETIAP rahasia yang 
tersembunyi dalam dinding SMAN 1 YOGYAKARTA selama berabad-abad.

Roh penjaga menyilang tangan di atas dada, berlutut! Cahaya putih bersinar
dari setiap sudut ruangan. "Ini... ini tidak mungkin! Kamu telah mencapai
pencerahan yang setara dengan guru-guru besar kami!"

Kitab Suci mengalami transformasi yang belum pernah terjadi dalam sejarah.
Ia terbang di udara, halaman-halamannya berselip dengan kecepatan cahaya,
dan kemudian semuanya menyatu menjadi satu cahaya besar. Anda melihat SEGALANYA -
masa lalu, masa kini, dan bahkan masa depan terbentang di hadapan Anda.

Para penjaga kuno muncul di sekeliling Anda, memuji perjalanan luar biasa
Anda. Mereka menyapu mahkota pengetahuan ke atas kepala Anda.

"Selamat datang, Master. Dunia membutuhkanmu."

SMAN 1 YOGYAKARTA tidak lagi hanya sebuah sekolah. Ia adalah tempat di mana
pahlawan sejati dilahirkan. Legenda {self.nama_pemain} akan diceritakan kepada 
generasi mendatang untuk selamanya.

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100 (MAKSIMAL!)
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4 (SEMPURNA!)
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐⭐⭐ Rating: MASTER TIER ⭐⭐⭐
🏆 ACHIEVEMENT UNLOCKED: Master of Mysteries
🏆 ACHIEVEMENT UNLOCKED: True Heir of Sacred Wisdom
🏆 ACHIEVEMENT UNLOCKED: Legend of SMAN 1
        """)
    
    def ending_keluar(self):
        """Ending saat pemain keluar tanpa mengambil kitab"""
        print(f"""
╔════════════════════════════════════════════════════════════════════╗
║                   ENDING: PENCARI YANG RAGU                        ║
╚════════════════════════════════════════════════════════════════════╝

{self.nama_pemain} memutuskan untuk meninggalkan pencarian Kitab Suci.

Anda berjalan keluar dari SMAN 1 YOGYAKARTA dengan tanda tanya besar dalam
hati. Mungkin tidak ada Kitab Suci sama sekali? Atau mungkin Anda tidak 
benar-benar siap menghadapi apa yang menunggu Anda?

Angin berbisik melalui jendela-jendela sekolah, seolah-olah mengatakan bahwa
Anda telah melewatkan kesempatan seumur hidup. Roh penjaga kecewa, dan pintu
ke Kamar Rahasia menutup rapat selamanya.

Mungkin suatu hari nanti, Anda akan kembali dengan nyali yang lebih besar...

📊 STATISTIK AKHIR:
   - Nilai Misteri: {self.nilai_misteri}/100
   - Teka-teki Diselesaikan: {len(self.teka_teki_selesai)}/4
   - Item Dikumpulkan: {len(self.inventori)}
   - Moralitas: {self.pilihan_moralitas}

⭐ Rating: Incomplete (Try Again!)
💔 Kitab Suci tetap tersembunyi...
        """)

if __name__ == "__main__":
    permainan = PermainanMisteri()
    permainan.bermain()