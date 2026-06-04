import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAdminPage extends StatefulWidget {
  final Map<String, dynamic> adminData;

  const DashboardAdminPage({super.key, required this.adminData});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  @override
  Widget build(BuildContext context) {
    // Warna tema utama sesuai mockup aplikasi Anda
    const primaryDarkBlue = Color(0xFF004D73);
    const backgroundGrey = Color(0xFFF8F9FB);

    return Scaffold(
      backgroundColor: backgroundGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER UTAMA ---
          Container(
            width: double.infinity,
            color: primaryDarkBlue,
            padding: const EdgeInsets.only(
              top: 30,
              left: 24,
              right: 24,
              bottom: 25,
            ),
            child: SafeArea(
              bottom: false,
              child: Text(
                "Dashboard",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // --- KONTEN HALAMAN (SCROLLABLE) ---
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GRID CARD: TOTAL CUSTOMER & BELUM DIVERIFIKASI
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          value: "24",
                          title: "Total customer",
                          icon: Icons.people_outline_rounded,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildSummaryCard(
                          value: "5",
                          title: "Belum diverif.",
                          icon: Icons.access_time_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // CARD LEBAR: TOTAL LAYANAN AKTIF
                  _buildFullWidthSummaryCard(
                    value: "3",
                    title: "Total layanan aktif",
                    icon: Icons.opacity_rounded,
                  ),
                  const SizedBox(height: 30),

                  // SUB-JUDUL DAFTAR VERIFIKASI
                  Text(
                    "Menunggu Verifikasi",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // KONTEN DAFTAR MENUNGGU VERIFIKASI
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildVerificationItem(
                          "Budi Santoso",
                          "Jul 2025 • Rp 100.000",
                        ),
                        _buildVerificationItem(
                          "Tribudi Atmono",
                          "Jul 2025 • Rp 50.000",
                        ),
                        _buildVerificationItem(
                          "Putri Adilla",
                          "Jul 2025 • Rp 75.000",
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- BOTTOM NAVIGATION BAR KHUSUS ADMIN (5 MENU) ---
    );
  }

  // Helper 1: Pembuat Kartu Grid Atas (Total Customer & Belum Diverif)
  Widget _buildSummaryCard({
    required String value,
    required String title,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF004D73),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper 2: Pembuat Kartu Panjang (Total Layanan Aktif)
  Widget _buildFullWidthSummaryCard({
    required String value,
    required String title,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF004D73),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper 3: Pembuat Baris List Antrean Verifikasi
  Widget _buildVerificationItem(
    String name,
    String subDetails, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: Colors.grey.shade100, width: 1.2),
              ),
      ),
      child: Row(
        children: [
          // Detail Teks (Nama & Detail Periode/Tarif)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subDetails,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // Badge Status "Menunggu" berwana oranye/cokelat kayu sesuai gambar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFC46A03),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Menunggu",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Ikon Panah Kanan tipis penanda item bisa diklik
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
