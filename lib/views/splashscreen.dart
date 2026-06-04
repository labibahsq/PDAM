import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rolepage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Berpindah ke RoleView setelah 3,5 detik dengan transisi memudar halus (Fade)
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const RoleView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. ANIMASI LOGO: Datang dari ATAS ke BAWAH (Nilai minus ke nol)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: -150.0,
                end: 0.0,
              ), // Mulai dari -150 (di atas layar) ke 0 (posisi asli)
              duration: const Duration(milliseconds: 1200),
              curve: Curves.bounceOut, // Efek memantul saat sampai di bawah
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              // SEKARANG MENGGUNAKAN GAMBAR ASET LOGO PDAM
              child: Image.asset(
                'assets/LogoAir.png', // Pastikan file logo Anda ada di folder assets dan namanya sesuai
                width: 125, // Sesuaikan ukuran agar pas dengan logo aset Anda
                height: 125,
              ),
            ),
            const SizedBox(height: 20),

            // 2. ANIMASI TEKS: Muncul pelan-pelan (Fade In)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ), // Mulai dari transparan (0.0) ke terlihat jelas (1.0)
              duration: const Duration(
                milliseconds: 1500,
              ), // Durasi muncul pelan-pelan
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Text(
                "PDAM",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF003D5B),
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
