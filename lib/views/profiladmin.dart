import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// TODO: Sesuaikan nama_file_role_page Anda dengan nama file lokasi kelas RolePage berada
import 'rolepage.dart';

class ProfilAdminPage extends StatefulWidget {
  const ProfilAdminPage({super.key});

  @override
  State<ProfilAdminPage> createState() => _ProfilAdminPageState();
}

class _ProfilAdminPageState extends State<ProfilAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            24.0,
          ), // Padding bawah untuk tombol logout
          child: Column(
            children: [
              // --- HEADER & TOMBOL KEMBALI KOTAK ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00557B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- AVATAR PROFIL LINGKARAN BESAR ---
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  color: Color(0xFF00557B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // --- INFO NAMA & USERNAME ---
              Text(
                "nia",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "@nia",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),

              // --- BADGE STATUS ADMIN ---
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5E20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Admin",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // --- DETAIL KARTU INFORMASI NO TELEPON ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No. Telepon",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        "08123456789",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(), // Mendorong tombol logout ke area paling bawah screen
              // --- TOMBOL LOGOUT ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFC62828),
                        width: 1.2,
                      ), // Border merah tipis
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      _tampilkanDialogKeluar(context);
                    },
                    child: Text(
                      "Logout",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFC62828), // Teks merah murni
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- POPUP DIALOG KELUAR ---
  void _tampilkanDialogKeluar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Pojok tumpul halus
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Konten Utama Dialog
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 28.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Sesuai ukuran konten
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Keluar",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Anda yakin ingin keluar?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Baris Tombol Aksi (Ya & Batal)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol YA (Biru Tua Solid) -> Berpindah ke RolePage ketika ditekan
                        SizedBox(
                          width: 100,
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF00557B,
                              ), // Biru tua aplikasi
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              // 1. Menutup popup dialog terlebih dahulu
                              Navigator.pop(context);

                              // 2. Berpindah ke Halaman Pilihan Peran (RolePage)
                              // Menggunakan pushAndRemoveUntil agar tumpukan halaman sebelumnya hancur total demi keamanan sistem logout
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RoleView(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Ya",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Tombol BATAL (Outline Merah Tua)
                        SizedBox(
                          width: 100,
                          height: 38,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFFC62828),
                                width: 1.2,
                              ), // Border merah
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog saja
                            },
                            child: Text(
                              "Batal",
                              style: GoogleFonts.inter(
                                color: const Color(0xFFC62828), // Teks merah
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tombol Close 'x' Kecil di Pojok Kanan Atas Dialog
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.grey.shade400, // Ikon abu-abu halus
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
