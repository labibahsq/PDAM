import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTagihanPage extends StatelessWidget {
  const InfoTagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryDarkBlue = Color(0xFF004D73);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Biru Tua "Info tagihan"
          Container(
            width: double.infinity,
            color: primaryDarkBlue,
            padding: const EdgeInsets.only(
              top: 25,
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: primaryDarkBlue,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "Info tagihan",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Konten Utama Berkulir
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Info tagihan",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tabel Informasi Detail Tagihan
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Customer", "Budi Ilyas", isFirst: true),
                          _buildDetailRow("Periode", "Juli 2025"),
                          _buildDetailRow("Pemakaian", "12m³"),
                          _buildDetailRow("Total tagihan", "Rp 100.000", isLast: true, isBoldValue: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Section Bukti Pembayaran
                    Text(
                      "Bukti pembayaran",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kotak Bukti Pembayaran "Tidak Tersedia"
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBE7F6), // Warna biru muda sesuai gambar mockup
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF90CAF9)),
                      ),
                      child: Center(
                        child: Text(
                          "Tidak Tersedia",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF004D73),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Section Status
                    Text(
                      "Status",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Badge Status Belum Dibayar (Merah Kotak tipis)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC02A37), // Merah tua gelap sesuai mockup
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Belum dibayar",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

  // Helper Widget untuk membuat baris detail tabel bergaris pembatas (Divider)
  Widget _buildDetailRow(String label, String value, {bool isFirst = false, bool isLast = false, bool isBoldValue = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast ? BorderSide.none : BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}