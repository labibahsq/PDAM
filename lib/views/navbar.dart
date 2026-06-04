import 'package:flutter/material.dart';
import 'dashboardcustomer.dart';
import 'pembayaranpage.dart';
import 'profilepage.dart';

class Navbar extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Navbar({super.key, required this.userData});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Warna biru ikon sesuai gambar mockup yang Anda kirim
    const activeBlue = Color(0xFF004D73);
    // Warna abu-abu untuk ikon yang sedang tidak aktif
    const inactiveGrey = Color(0xFF8E8E93);

    final pages = [
      DashboardCustomer(
        userData: widget.userData,
        onBayarSekarangPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      const PembayaranPage(),
      ProfilView(userData: widget.userData),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        // Memberikan border atas tipis agar terlihat rapi dan elegan membatasi konten
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              Colors.white, // Latar belakang putih bersih sesuai gambar
          selectedItemColor: activeBlue, // Ikon & Teks menjadi Biru saat diklik
          unselectedItemColor:
              inactiveGrey, // Ikon & Teks menjadi Abu-abu saat tidak aktif
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ), // Menggunakan versi outline agar lebih clean
              activeIcon: Icon(Icons.home),
              label:
                  'Beranda', // Mengubah 'Dashboard' menjadi 'Beranda' sesuai gambar
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card_outlined,
              ), // Ikon kartu/pembayaran minimalis
              activeIcon: Icon(Icons.credit_card),
              label: 'Pembayaran',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
