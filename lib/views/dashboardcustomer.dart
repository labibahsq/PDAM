import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pembayaranpage.dart';

class DashboardCustomer extends StatelessWidget {
  final VoidCallback
  onBayarSekarangPressed; // Parameter penampung aksi klik tombol
  final Map<String, dynamic> userData;

  const DashboardCustomer({
    super.key,
    required this.onBayarSekarangPressed,
    required this.userData, // Masukkan ke dalam constructor wajib
  });

  @override
  Widget build(BuildContext context) {
    // Ambil data dinamis hasil login API dari Postman
    final String namaPelanggan = userData['name'] ?? "bebeb";
    final String nomorPelanggan = userData['customer_number'] ?? "C-00871";

    // Definisikan kode warna persis sesuai dengan mockup foto
    const primaryBlue = Color(0xFF196EA6); // Biru tema utama / grafik
    const bgHeaderGradient = Color(
      0xFF28A0F6,
    ); // Biru terang bagian atas gradient

    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F7FA,
      ), // Background abu-abu sangat muda bersih
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT KEPALA (Hanya di bagian atas seperti foto)
          Container(
            height: 240,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bgHeaderGradient, primaryBlue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),

          // 2. KONTEN UTAMA (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // --- PROFIL USER & NOTIFIKASI ---
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('assets/LogoAir.jpg'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              namaPelanggan,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              nomorPelanggan,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: const Text(
                                  '9',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // --- 3. BOX JUMLAH TAGIHAN (PUTIH) ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            spreadRadius: 0,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jumlah Tagihan:",
                                style: GoogleFonts.inter(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Rp 100.000",
                                style: GoogleFonts.inter(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                  children: [
                                    const TextSpan(text: "jatuh tempo pada: "),
                                    TextSpan(
                                      text: "2 hari",
                                      style: GoogleFonts.inter(
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // ===================================================
                          // DI SINI PERBAIKANNYA: Mengganti Navigator dengan Callback
                          // ===================================================
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PembayaranPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Bayar Sekarang",
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // --- 4. ROW STATISTIK ---
                    Row(
                      children: [
                        _buildStatCard(
                          "Total Tagihan:",
                          "1",
                          "Per bulan Juli 2025",
                          const Color(0xFFC02A37),
                          null,
                        ),
                        const SizedBox(width: 15),
                        _buildStatCard(
                          "Pemakaian:",
                          "12",
                          "Per bulan Juli 2025",
                          const Color(0xFF28A745),
                          "m³",
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // --- 5. GRAFIK BATANG DATA TAGIHAN ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Data Tagihan",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "6 bulan terakhir",
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Stack(
                            children: [
                              Positioned(
                                bottom: 22,
                                left: 20,
                                right: 0,
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "20",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "10",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        _buildBar(55, "15", "Jan", primaryBlue),
                                        _buildBar(70, "18", "Feb", primaryBlue),
                                        _buildBar(40, "12", "Mar", primaryBlue),
                                        _buildBar(50, "14", "Apr", primaryBlue),
                                        _buildBar(60, "16", "Mei", primaryBlue),
                                        _buildBar(85, "20", "Jun", primaryBlue),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // --- 6. HISTORI PEMBAYARAN ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Histori Pembayaran",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Lihat semua",
                          style: GoogleFonts.inter(
                            color: primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildHistoryItem(
                      "Juli 2025",
                      "Rp 10.000",
                      "Belum dibayar",
                      const Color(0xFFC02A37),
                    ),
                    _buildHistoryItem(
                      "Mei 2025",
                      "Rp 10.000",
                      "Terverifikasi",
                      const Color(0xFF28A745),
                    ),
                    _buildHistoryItem(
                      "April 2025",
                      "Rp 10.000",
                      "Terverifikasi",
                      const Color(0xFF28A745),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String sub,
    Color valColor,
    String? unit,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: valColor,
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: valColor,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Text(
              sub,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: const Color(0xFFA6A6A6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(double height, String value, String label, Color barColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 25,
          height: height,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: const Color(0xFFA6A6A6),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    String date,
    String price,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.assignment_outlined,
            color: Color(0xFF196EA6),
            size: 24,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFFA6A6A6),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
