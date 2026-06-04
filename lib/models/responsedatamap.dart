class Responsedatamap {
  bool status; // Kita isi manual berdasarkan sukses/tidaknya HTTP request
  String message;
  dynamic data;

  Responsedatamap({
    required this.status,
    required this.message,
    this.data,
  });

  // Digunakan untuk memetakan response dari Postman
  factory Responsedatamap.fromMap(Map<String, dynamic> json, bool isSuccess) {
    return Responsedatamap(
      status: isSuccess,
      // Jika ada field 'message' dari API pakai itu, jika tidak pakai string kosong
      message: json['message'] ?? '', 
      data: json, // Masukkan seluruh body json ke dalam data
    );
  }
}