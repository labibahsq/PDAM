import 'package:flutter/material.dart';
import 'rolepage.dart'; // Pastikan path rolepage ini benar sesuai struktur proyekmu

class ProfilView extends StatelessWidget {
  final Map<String, dynamic>
  userData; // Menerima data dinamis customer yang login

  const ProfilView({super.key, required this.userData});

  // Fungsi untuk memunculkan Popup Dialog Keluar persis seperti mockup
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Mengharuskan user memilih Ya/Batal
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4.0,
            ), // Kotak agak tegas sesuai mockup
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tombol "X" (Close) kecil di kanan atas popup
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Anda yakin ingin keluar?',
                  style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                // Row Tombol Aksi Ya & Batal
                Row(
                  children: [
                    // Tombol Ya (Warna Biru Tua PDAM)
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF004D73,
                            ), // Sesuaikan Hex Biru Aplikasi Anda
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Keluar dan hapus semua stack page, kembali ke RolePage
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoleView(),
                              ), // Sesuaikan nama class rolepage Anda
                              (route) => false,
                            );
                          },
                          child: const Text(
                            'Ya',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Tombol Batal (Outline Merah/Coklat pudar)
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFC05C5C),
                            ), // Warna border merah soft sesuai mockup
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Menutup popup
                          },
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              color: Color(0xFFC05C5C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data dari map userData secara dinamis.
    // Jika null, akan menggunakan nilai fallback/default agar aplikasi tidak crash.
    String namaCustomer =
        userData['name'] ?? userData['username'] ?? ' bebeb ';
    String usernameCustomer = userData['username'] ?? 'bebeb';
    String noPelanggan =
        userData['customer_number'] ?? userData['id']?.toString() ?? 'C-00013';
    String noTelepon = userData['phone'] ?? '08123456789';

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // Latar belakang putih abu-abu bersih
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(
                0xFF004D73,
              ), // Background tombol back biru tua pdam
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {
                // Sesuai sistem navbar, ini akan mengembalikan ke halaman beranda/index 0
                // atau sesuaikan aksi back Anda.
              },
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Profil',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Avatar Profil Lingkaran Biru Tua dengan Icon Orang
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF004D73), // Lingkaran biru tua
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .person_outline, // Menggunakan icon person outline sesuai foto
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 16),
              // Teks Nama Customer (Dinamis)
              Text(
                namaCustomer,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              // Teks @username (Dinamis)
              Text(
                '@$usernameCustomer',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              // Badge Hijau "Customer"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1B7A4D,
                  ), // Warna hijau gelap sesuai foto mockup
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Customer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              // Kotak Detail Informasi Akun Pelanggan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // Baris 1: No. Pelanggan
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. Pelanggan',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            noPelanggan,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ), // Garis pemisah tipis
                    // Baris 2: No. Telepon
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. Telepon',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            noTelepon,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(), // Mendorong tombol Logout ke posisi paling bawah layar
              // Tombol Logout Outline Merah di bagian bawah
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFC05C5C),
                    ), // Sesuai warna mockup
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    _showLogoutDialog(
                      context,
                    ); // Panggil dialog konfirmasi saat ditekan
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFFC05C5C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Padding jarak aman terbawah
            ],
          ),
        ),
      ),
    );
  }
}
