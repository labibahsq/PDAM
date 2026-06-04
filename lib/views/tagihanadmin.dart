import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  // GlobalKey untuk mengontrol dan mengecek validasi Form
  final _formKeyTambah = GlobalKey<FormState>();
  final _formKeyEdit = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _daftarTagihan = [
    {"nama": "Budi Ilyas", "bulan": "Jul 2025", "volume": "12m³", "total": "Rp 100.000"},
    {"nama": "Tribudi Atmono", "bulan": "Jul 2025", "volume": "8m³", "total": "Rp 50.000"},
    {"nama": "Putri Adilla", "bulan": "Jul 2025", "volume": "20m³", "total": "Rp 75.000"},
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
              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF00557B)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Kelola Tagihan",
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: _tampilkanDialogTambahTagihan,
                  icon: const Icon(Icons.add, size: 16),
                  label: Text("Tambah tagihan", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: _daftarTagihan.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tagihan = _daftarTagihan[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1.2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tagihan["nama"], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(tagihan["bulan"], style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600)),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  width: 4, height: 4,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade400),
                                ),
                                Text(tagihan["volume"], style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600)),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  width: 4, height: 4,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade400),
                                ),
                                Text(tagihan["total"], style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // --- TOMBOL EDIT WARNA BIRU ---
                            Container(
                              width: 34, height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFF90CAF9)),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.edit_note_rounded, color: Color(0xFF1565C0), size: 22),
                                onPressed: () {
                                  _tampilkanDialogEditTagihan(index);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 34, height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFEF9A9A)),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.delete_forever_rounded, color: Color(0xFFC62828), size: 20),
                                onPressed: () {
                                  setState(() => _daftarTagihan.removeAt(index));
                                },
                              ),
                            ),
                          ],
                        )
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

  // --- POPUP DIALOG TAMBAH TAGIHAN + VALIDASI ---
  void _tampilkanDialogTambahTagihan() {
    final nameCtrl = TextEditingController();
    final monthCtrl = TextEditingController();
    final volumeCtrl = TextEditingController();
    final totalCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Tambah Rekaman Tagihan Baru", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
        content: Form(
          key: _formKeyTambah,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl, 
                  decoration: const InputDecoration(hintText: "Nama Customer"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Nama tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: monthCtrl, 
                  decoration: const InputDecoration(hintText: "Bulan Periode (contoh: Jul 2025)"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Bulan periode tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: volumeCtrl, 
                  decoration: const InputDecoration(hintText: "Volume Air (contoh: 12m³)"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Volume air tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: totalCtrl, 
                  decoration: const InputDecoration(hintText: "Total Biaya (contoh: Rp 100.000)"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Total biaya tidak boleh kosong";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Batal", style: GoogleFonts.inter(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00557B)),
            onPressed: () {
              if (_formKeyTambah.currentState!.validate()) {
                setState(() {
                  _daftarTagihan.add({
                    "nama": nameCtrl.text,
                    "bulan": monthCtrl.text,
                    "volume": volumeCtrl.text,
                    "total": totalCtrl.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text("Simpan", style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- POPUP DIALOG EDIT TAGIHAN + VALIDASI ---
  void _tampilkanDialogEditTagihan(int index) {
    final tagihanTerpilih = _daftarTagihan[index];

    final nameCtrl = TextEditingController(text: tagihanTerpilih["nama"]);
    final monthCtrl = TextEditingController(text: tagihanTerpilih["bulan"]);
    final volumeCtrl = TextEditingController(text: tagihanTerpilih["volume"]);
    final totalCtrl = TextEditingController(text: tagihanTerpilih["total"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Edit Rekaman Tagihan", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
        content: Form(
          key: _formKeyEdit,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl, 
                  decoration: const InputDecoration(hintText: "Nama Customer"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Nama tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: monthCtrl, 
                  decoration: const InputDecoration(hintText: "Bulan Periode"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Bulan periode tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: volumeCtrl, 
                  decoration: const InputDecoration(hintText: "Volume Air"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Volume air tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: totalCtrl, 
                  decoration: const InputDecoration(hintText: "Total Biaya"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Total biaya tidak boleh kosong";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Batal", style: GoogleFonts.inter(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00557B)),
            onPressed: () {
              if (_formKeyEdit.currentState!.validate()) {
                setState(() {
                  _daftarTagihan[index] = {
                    "nama": nameCtrl.text,
                    "bulan": monthCtrl.text,
                    "volume": volumeCtrl.text,
                    "total": totalCtrl.text,
                  };
                });
                Navigator.pop(context);
              }
            },
            child: Text("Simpan", style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}