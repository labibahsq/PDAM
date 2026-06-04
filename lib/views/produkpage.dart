import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/keranjangmodel.dart'; 

class ProdukPage extends StatefulWidget {
  final VoidCallback onProdukDitambahkan;

  const ProdukPage({super.key, required this.onProdukDitambahkan});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  String _formatRupiah(int nominal) {
    return "Rp ${nominal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void _tambahKeKeranjang(String id, String nama, String kategori, int harga) {
    setState(() {
      int index = daftarKeranjangGlobal.indexWhere((item) => item.id == id);

      if (index != -1) {
        daftarKeranjangGlobal[index].quantity++;
      } else {
        daftarKeranjangGlobal.add(
          CartItem(id: id, namaProduk: nama, kategori: kategori, harga: harga, quantity: 1),
        );
      }
    });

    widget.onProdukDitambahkan(); // Trigger navbar biar ikut refresh badge angka

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$nama dimasukkan ke keranjang!'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF004D73),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00557B),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Katalog Layanan & Produk",
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
        children: [
          _buildCardProduk("P-01", "Pemasangan Pipa Baru", "Layanan", 150000, Icons.plumbing),
          _buildCardProduk("P-02", "Air Tangki 5000L", "Produk Air", 75000, Icons.water_drop),
          _buildCardProduk("P-03", "Service Meteran Air", "Layanan", 50000, Icons.build),
          _buildCardProduk("P-04", "Filter Air Bersih", "Produk Air", 120000, Icons.filter_alt),
        ],
      ),
    );
  }

  Widget _buildCardProduk(String id, String nama, String kategori, int harga, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
            child: Icon(iconData, color: const Color(0xFF004D73), size: 24),
          ),
          const Spacer(),
          Text(nama, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold)),
          Text(kategori, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatRupiah(harga), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF004D73))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D73),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () => _tambahKeKeranjang(id, nama, kategori, harga),
                child: Text("+ Beli", style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }
}