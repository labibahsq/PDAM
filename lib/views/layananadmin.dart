import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({super.key});

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  // GlobalKey digunakan untuk mengontrol dan mengecek validasi Form
  final _formKeyTambah = GlobalKey<FormState>();
  final _formKeyEdit = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _daftarLayanan = [
    {"nama": "Rumah Tangga", "ukuran": "0 - 10 m³", "harga": "Rp 2.000/m³"},
    {"nama": "Komersial", "ukuran": "11 - 50 m³", "harga": "Rp 4.000/m³"},
    {"nama": "Industri", "ukuran": "51 - 100 m³", "harga": "Rp 6.000/m³"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00557B),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Color(0xFF00557B),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Kelola Layanan",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 36,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00557B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: _tampilkanDialogTambahLayanan,
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    "Tambah layanan",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: _daftarLayanan.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final layanan = _daftarLayanan[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              layanan["nama"],
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  layanan["ukuran"],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  layanan["harga"],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFF90CAF9),
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.edit_note_rounded,
                                  color: Color(0xFF1565C0),
                                  size: 22,
                                ),
                                onPressed: () {
                                  _tampilkanDialogEditLayanan(index);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFEF9A9A),
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Color(0xFFC62828),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _daftarLayanan.removeAt(index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- POPUP DIALOG TAMBAH LAYANAN + VALIDASI ---
  void _tampilkanDialogTambahLayanan() {
    final nameCtrl = TextEditingController();
    final rangeCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Tambah Kategori Layanan baru",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Form(
          key: _formKeyTambah, // Pasang formKey
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(hintText: "Nama Layanan"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama layanan tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: rangeCtrl,
                  decoration: const InputDecoration(
                    hintText: "Rentang Ukuran (contoh: 0 - 10 m³)",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Rentang ukuran tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(
                    hintText: "Harga Per m³ (contoh: Rp 2.000/m³)",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Harga tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00557B),
            ),
            onPressed: () {
              // Menjalankan pengecekan validasi form tambah
              if (_formKeyTambah.currentState!.validate()) {
                setState(() {
                  _daftarLayanan.add({
                    "nama": nameCtrl.text,
                    "ukuran": rangeCtrl.text,
                    "harga": priceCtrl.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              "Simpan",
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // --- POPUP DIALOG EDIT LAYANAN + VALIDASI ---
  void _tampilkanDialogEditLayanan(int index) {
    final layananTerpilih = _daftarLayanan[index];

    final nameCtrl = TextEditingController(text: layananTerpilih["nama"]);
    final rangeCtrl = TextEditingController(text: layananTerpilih["ukuran"]);
    final priceCtrl = TextEditingController(text: layananTerpilih["harga"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Edit Kategori Layanan",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Form(
          key: _formKeyEdit, // Pasang formKey edit
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(hintText: "Nama Layanan"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama layanan tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: rangeCtrl,
                  decoration: const InputDecoration(hintText: "Rentang Ukuran"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Rentang ukuran tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(hintText: "Harga Per m³"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Harga tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00557B),
            ),
            onPressed: () {
              // Menjalankan pengecekan validasi form edit
              if (_formKeyEdit.currentState!.validate()) {
                setState(() {
                  _daftarLayanan[index] = {
                    "nama": nameCtrl.text,
                    "ukuran": rangeCtrl.text,
                    "harga": priceCtrl.text,
                  };
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              "Simpan",
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
