class CartItem {
  final String id;
  final String namaProduk;
  final String kategori;
  final int harga;
  int quantity;

  CartItem({
    required this.id,
    required this.namaProduk,
    required this.kategori,
    required this.harga,
    this.quantity = 1,
  });
}

// Data simulasi keranjang belanja (Simpan sebagai global list)
List<CartItem> daftarKeranjangGlobal = [];