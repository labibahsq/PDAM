import 'package:flutter/material.dart';
import 'package:flutter_application_13/views/profilepage.dart';
import 'views/splashscreen.dart';
import 'views/rolepage.dart';
import 'views/logincustomer.dart';
import 'models/customermodel.dart';
import 'models/responsedatamap.dart';
import 'views/dashboardcustomer.dart';
import 'views/navbar.dart';
import 'views/pembayaranpage.dart';
import 'views/profilepage.dart';
import 'views/infotagihanpage.dart';
import 'views/loginadmin.dart';
import 'views/dashboardadmin.dart';
import 'views/navbaradmin.dart';
import 'services/adminservices.dart';
import 'services/customerservices.dart';
import 'views/layananadmin.dart';
import 'views/customeradmin.dart';
import 'views/tagihanadmin.dart';
import 'views/profiladmin.dart';
import 'models/keranjangmodel.dart';
import 'views/keranjangpage.dart';
import 'views/checkoutsuccespage.dart';
import 'views/produkpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDAM',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/role': (context) => const RoleView(),
        '/login': (context) => const Loginview(),
        '/dashboard': (context) => DashboardCustomer(
          onBayarSekarangPressed: () {},
          userData: const {},
        ),
        '/navbar': (context) => const Navbar(userData: {}),
        '/pembayaran': (context) => const PembayaranPage(),
        '/profil': (context) => ProfilView(
          userData: const {},
        ), // Ganti dengan ProfilView jika sudah dibuat
        '/infotagihan': (context) =>
            const InfoTagihanPage(), // Tambahkan route untuk halaman info tagihan
        '/loginadmin': (context) =>
            const AdminLoginPage(), // Tambahkan route untuk halaman login admin
        '/dashboardadmin': (context) => const DashboardAdminPage(adminData: {}),
        '/navbaradmin': (context) => const NavbarAdmin(
          adminData: {},
        ), // Tambahkan route untuk halaman navbar admin
        '/layananadmin': (context) =>
            const LayananPage(), // Tambahkan route untuk halaman layanan admin
        '/customeradmin': (context) =>
            const CustomerPage(), // Tambahkan route untuk halaman customer admin
        '/tagihanadmin': (context) =>
            const TagihanPage(), // Tambahkan route untuk halaman tagihan admin
        '/profiladmin': (context) => const ProfilAdminPage(),
        '/keranjang': (context) =>
            const KeranjangPage(), // Tambahkan route untuk halaman keranjang
        '/produk': (context) => ProdukPage(
          onProdukDitambahkan: () {},
        ), // Tambahkan route untuk halaman produk
        '/checkoutsuccess': (context) =>
            const CheckoutSuccessPage(totalTransfer: 0),
        // Tambahkan route untuk halaman checkout sukses
      },
    );
  }
}
