import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'infotagihanpage.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String _selectedFilter = 'Semua';
  Uint8List? _selectedImageBytes;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _allTransactions = [
    {
      "date": "Juli 2025",
      "price": "Rp 100.000",
      "status": "Belum dibayar",
      "color": const Color(0xFFC02A37),
    },
    {
      "date": "Juni 2025",
      "price": "Rp 65.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
    {
      "date": "Mei 2025",
      "price": "Rp 60.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
    {
      "date": "April 2025",
      "price": "Rp 200.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
    {
      "date": "Maret 2025",
      "price": "Rp 50.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
    {
      "date": "Februari 2025",
      "price": "Rp 75.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
    {
      "date": "Januari 2025",
      "price": "Rp 60.000",
      "status": "Terverifikasi",
      "color": const Color(0xFF28A745),
    },
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  void _showPickerOptions() {
    if (kIsWeb) {
      _pickImage(ImageSource.gallery);
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: Color(0xFF004D73),
                ),
                title: Text(
                  "Pilih dari Galeri",
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: Color(0xFF004D73),
                ),
                title: Text(
                  "Ambil Foto",
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi kirim pembayaran: ubah status Juli 2025 jadi "Menunggu Verifikasi"
  void _kirimPembayaran() {
    setState(() {
      final index = _allTransactions.indexWhere(
        (tx) => tx['date'] == 'Juli 2025' && tx['status'] == 'Belum dibayar',
      );
      if (index != -1) {
        _allTransactions[index]['status'] = 'Menunggu Verifikasi';
        _allTransactions[index]['color'] = const Color(0xFFE69500);
      }
      _selectedImageBytes = null; // reset foto setelah kirim
    });

    // Tampilkan snackbar konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF004D73),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              "Bukti pembayaran berhasil dikirim!",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Cek apakah masih ada tagihan belum dibayar
  bool get _adaTagihanBelumDibayar {
    return _allTransactions.any((tx) => tx['status'] == 'Belum dibayar');
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkBlue = Color(0xFF004D73);

    List<Map<String, dynamic>> filteredTransactions = _allTransactions.where((
      item,
    ) {
      if (_selectedFilter == 'Semua') return true;
      return item['status'].toString().toLowerCase() ==
          _selectedFilter.toLowerCase();
    }).toList();

    // Status tagihan terbaru (Juli 2025)
    final tagihanTerbaru = _allTransactions.first;
    final isBelumDibayar = tagihanTerbaru['status'] == 'Belum dibayar';
    final isMenunggu = tagihanTerbaru['status'] == 'Menunggu Verifikasi';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
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
                        "Tagihan Saya",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Konten Utama
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tagihan Terbaru",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildHistoryItem(
                      tagihanTerbaru['date'],
                      tagihanTerbaru['price'],
                      tagihanTerbaru['status'],
                      tagihanTerbaru['color'],
                    ),
                    const SizedBox(height: 15),

                    // Tampilkan area upload HANYA jika belum dibayar
                    if (isBelumDibayar) ...[
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: _showPickerOptions,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(minHeight: 120),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedImageBytes != null
                                    ? const Color(0xFF004D73)
                                    : Colors.grey.shade300,
                                width: _selectedImageBytes != null ? 1.5 : 1,
                              ),
                            ),
                            child: _selectedImageBytes == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 35,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.upload_file_outlined,
                                          size: 36,
                                          color: Colors.grey.shade400,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Ketuk untuk upload bukti pembayaran",
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Image.memory(
                                          _selectedImageBytes!,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.55,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.edit,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "Ganti",
                                                style: GoogleFonts.inter(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Tombol Kirim
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedImageBytes != null
                                ? primaryDarkBlue
                                : Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _selectedImageBytes != null
                              ? _kirimPembayaran
                              : null,
                          child: Text(
                            "Kirim Pembayaran",
                            style: GoogleFonts.inter(
                              color: _selectedImageBytes != null
                                  ? Colors.white
                                  : Colors.grey.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],

                    // Banner info jika sudah menunggu verifikasi
                    if (isMenunggu) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE69500)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.hourglass_top_rounded,
                              color: Color(0xFFE69500),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pembayaran sedang diverifikasi",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7A4F00),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Bukti pembayaran kamu sudah diterima. Mohon tunggu konfirmasi dari admin.",
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Color(0xFF7A4F00),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],

                    const SizedBox(height: 15),

                    Text(
                      "Riwayat & Status Tagihan",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filter Chips — tambah filter "Menunggu Verifikasi"
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildFilterChip("Semua"),
                          _buildFilterChip("Belum dibayar"),
                          _buildFilterChip("Menunggu Verifikasi"),
                          _buildFilterChip("Terverifikasi"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    filteredTransactions.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                "Tidak ada data tagihan.",
                                style: GoogleFonts.inter(color: Colors.grey),
                              ),
                            ),
                          )
                        : Column(
                            children: filteredTransactions.map((tx) {
                              return _buildHistoryItem(
                                tx['date'],
                                tx['price'],
                                tx['status'],
                                tx['color'],
                              );
                            }).toList(),
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

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selected) setState(() => _selectedFilter = label);
        },
        selectedColor: const Color(0xFF004D73),
        backgroundColor: Colors.white,
        labelStyle: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.black87,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? const Color(0xFF004D73) : Colors.grey.shade300,
          ),
        ),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildHistoryItem(
    String date,
    String price,
    String status,
    Color statusColor,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InfoTagihanPage()),
        );
      },
      child: Container(
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
      ),
    );
  }
}
