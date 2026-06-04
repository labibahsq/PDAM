class CustomerModel {
  final dynamic id;
  final String name;
  final String customerNumber;
  final String address;
  final String phone;

  CustomerModel({
    required this.id,
    required this.name,
    required this.customerNumber,
    required this.address,
    required this.phone,
  });

  // Fungsi konversi JSON ala factory model di PDF halaman 3
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'] ?? "Tanpa Nama",
      customerNumber: json['customer_number'] ?? "-",
      address: json['address'] ?? "-",
      phone: json['phone'] ?? "-",
    );
  }
}