import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final _formKeyTambah = GlobalKey<FormState>();
  final _formKeyEdit = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _daftarCustomer = [
    {"nama": "Budi Ilyas", "kode": "C-0001", "kategori": "Rumah tangga"},
    {"nama": "Tribudi Atmono", "kode": "C-0002", "kategori": "Komersial"},
    {"nama": "Putri Adilla", "kode": "C-0003", "kategori": "Industri"},
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
          "Kelola Customer",
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
                  onPressed: _tampilkanDialogTambahCustomer,
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    "Tambah customer",
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
                itemCount: _daftarCustomer.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final customer = _daftarCustomer[index];
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
                              customer["nama"],
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${customer['kode']} - ${customer['kategori']}",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
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
                                  _tampilkanDialogEditCustomer(index);
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
                                    () => _daftarCustomer.removeAt(index),
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

  void _tampilkanDialogTambahCustomer() {
    final nameCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Tambah Customer Baru",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
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
                    if (value == null || value.trim().isEmpty)
                      return "Nama customer tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: categoryCtrl,
                  decoration: const InputDecoration(
                    hintText: "Kategori (contoh: Rumah tangga)",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return "Kategori tidak boleh kosong";
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
              if (_formKeyTambah.currentState!.validate()) {
                setState(() {
                  int nextNum = _daftarCustomer.length + 1;
                  String codeStr = "C-${nextNum.toString().padLeft(4, '0')}";
                  _daftarCustomer.add({
                    "nama": nameCtrl.text,
                    "kode": codeStr,
                    "kategori": categoryCtrl.text,
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

  void _tampilkanDialogEditCustomer(int index) {
    final customerTerpilih = _daftarCustomer[index];

    final nameCtrl = TextEditingController(text: customerTerpilih["nama"]);
    final categoryCtrl = TextEditingController(
      text: customerTerpilih["kategori"],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Edit Data Customer",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
        ),
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
                    if (value == null || value.trim().isEmpty)
                      return "Nama customer tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: categoryCtrl,
                  decoration: const InputDecoration(hintText: "Kategori"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return "Kategori tidak boleh kosong";
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
              if (_formKeyEdit.currentState!.validate()) {
                setState(() {
                  _daftarCustomer[index] = {
                    "nama": nameCtrl.text,
                    "kode": customerTerpilih["kode"],
                    "kategori": categoryCtrl.text,
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
