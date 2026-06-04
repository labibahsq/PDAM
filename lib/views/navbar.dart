import 'package:flutter/material.dart';
import 'dashboardcustomer.dart';
import 'pembayaranpage.dart';
import 'profilepage.dart';
import 'produkpage.dart';    
import 'keranjangpage.dart';  
import '../models/keranjangmodel.dart';

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
    const activeBlue = Color(0xFF004D73);
    const inactiveGrey = Color(0xFF8E8E93);

    // Daftar halaman aplikasi
    final pages = [
      DashboardCustomer(
        userData: widget.userData,
        onBayarSekarangPressed: () {
          setState(() {
            _currentIndex = 2; // Pindah ke tab keranjang
          });
        },
      ),
      ProdukPage(
        onProdukDitambahkan: () {
          setState(() {}); // Refresh Navbar untuk memperbarui angka badge belanjaan
        },
      ),    
      const KeranjangPage(), 
      ProfilView(userData: widget.userData), 
    ];

    return Scaffold(
      // PERBAIKAN: Menggunakan pemanggilan dinamis bukan IndexedStack agar halaman me-refresh otomatis
      body: pages[_currentIndex], 
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: activeBlue,
          unselectedItemColor: inactiveGrey,
          selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Produk',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (daftarKeranjangGlobal.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '${daftarKeranjangGlobal.fold<int>(0, (sum, item) => sum + item.quantity)}',
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: const Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
            const BottomNavigationBarItem(
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