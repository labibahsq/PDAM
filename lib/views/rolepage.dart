import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// 1. IMPORT FILE LOGIN ADMIN ANDA DI SINI
import 'loginadmin.dart';

class RoleView extends StatefulWidget {
  const RoleView({super.key});

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  // Menyimpan string role aktif saat disentuh user
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          // Elemen background ombak di bagian paling bawah
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pilih Role Anda",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // --- TOMBOL 1: ADMIN ---
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // Berubah biru jika dipilih, putih jika tidak
                        backgroundColor: selectedRole == 'admin'
                            ? const Color(0xFF003D5B)
                            : Colors.white,
                        side: BorderSide(
                          color: selectedRole == 'admin'
                              ? const Color(0xFF003D5B)
                              : const Color(
                                  0xFF004D73,
                                ), // Menyesuaikan warna border bawaan mockup Anda
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedRole = 'admin';
                        });
                        // Jeda singkat agar mata user menangkap perubahan warna biru
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (mounted) {
                            // 2. NAVIGASI LANGSUNG KE LOGIN ADMIN
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Ganti 'AdminLoginPage()' dengan nama class yang ada di file loginadmin.dart Anda
                                builder: (context) => const AdminLoginPage(),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        "Admin",
                        style: GoogleFonts.inter(
                          color: selectedRole == 'admin'
                              ? Colors.white
                              : const Color(0xFF003D5B),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // --- TOMBOL 2: USER / CUSTOMER ---
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // Berubah biru jika dipilih, putih jika tidak
                        backgroundColor: selectedRole == 'customer'
                            ? const Color(0xFF003D5B)
                            : Colors.white,
                        side: BorderSide(
                          color: selectedRole == 'customer'
                              ? const Color(0xFF003D5B)
                              : const Color(0xFF004D73),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedRole = 'customer';
                        });
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (mounted) {
                            // Diarahkan menuju halaman login customer Anda
                            Navigator.pushNamed(context, '/login');
                          }
                        });
                      },
                      child: Text(
                        "User", // Mengubah text menjadi 'User' sesuai tampilan gambar mockup terbaru Anda
                        style: GoogleFonts.inter(
                          color: selectedRole == 'customer'
                              ? Colors.white
                              : const Color(0xFF003D5B),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
