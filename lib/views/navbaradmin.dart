import 'package:flutter/material.dart';

import 'dashboardadmin.dart';
import 'layananadmin.dart';
import 'customeradmin.dart';
import 'tagihanadmin.dart';
import 'profiladmin.dart';

class NavbarAdmin extends StatefulWidget {
  final Map<String, dynamic> adminData;

  const NavbarAdmin({super.key, required this.adminData});

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      DashboardAdminPage(adminData: widget.adminData),
      const LayananPage(),
      const CustomerPage(),
      const TagihanPage(),
      const ProfilAdminPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkBlue = Color(0xFF004D73);

    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDarkBlue,
        unselectedItemColor: const Color(0xFF8E8E93),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.opacity_outlined),
            activeIcon: Icon(Icons.opacity),
            label: 'Layanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Tagihan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
