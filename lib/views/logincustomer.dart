import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/customerservices.dart';
import 'navbar.dart'; // Mengarahkan ke Navbar pembungkus agar bottom bar muncul

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              // Background Ombak
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/Elemen.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
              ),

              // Konten Utama Form
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 30.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "Sign In",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Silakan masuk untuk melanjutkan",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 35),

                        // USERNAME FIELD
                        _buildLabelField("Username"),
                        _buildTextField(
                          _username,
                          "Masukkan username Anda",
                          false,
                        ),

                        // PASSWORD FIELD
                        _buildLabelField("Password"),
                        _buildTextField(
                          _password,
                          "Masukkan password Anda",
                          true,
                        ),

                        const SizedBox(height: 30),

                        // TOMBOL MASUK
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF003D5B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isLoading = true);

                                      // Menembak service login API
                                      final result = await CustomerServices()
                                          .loginCustomer(
                                            _username.text.trim(),
                                            _password.text.trim(),
                                          );

                                      setState(() => _isLoading = false);

                                      // Pengecekan token / kesuksesan dari API
                                      if (result != null &&
                                          (result['token'] != null ||
                                              result['success'] == true)) {
                                        if (mounted) {
                                          // 1. Ambil data user dari API
                                          final Map<String, dynamic>
                                          finalUserData =
                                              result['data'] ??
                                              result['user'] ??
                                              result;

                                          // 2. Tampilkan Snackbar Berhasil Warna Hijau
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Kamu sudah berhasil login!",
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor:
                                                  Colors.green.shade600,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );

                                          // 3. SEKARANG DIPERBAIKI: Pindah ke Navbar, bukan langsung ke DashboardCustomer
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Navbar(
                                                userData:
                                                    finalUserData, // Data dikirim ke Navbar agar diteruskan ke dashboard
                                              ),
                                            ),
                                            (route) => false,
                                          );
                                        }
                                      } else {
                                        // JIKA GAGAL: Munculkan pop-up error
                                        if (mounted) {
                                          String msgError =
                                              "Username atau password salah.";
                                          if (result != null &&
                                              result['message'] != null) {
                                            msgError = result['message'];
                                          }
                                          _showDialogError(msgError);
                                        }
                                      }
                                    }
                                  },
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Masuk",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // FOOTER TEXT
                        Center(
                          child: Text(
                            "Lupa kata sandi? Hubungi petugas PDAM setempat.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey.shade500,
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
        ),
      ),
    );
  }

  Widget _buildLabelField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: ctrl,
        obscureText: isPassword ? _isObscure : false,
        cursorColor: const Color(0xFF003D5B),
        style: GoogleFonts.inter(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: Colors.grey.shade400,
            fontSize: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF003D5B), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        validator: (v) => v!.isEmpty ? "Kolom ini wajib diisi" : null,
      ),
    );
  }

  void _showDialogError(String msg) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: const Color(0xFFF3EEF5),
        title: Text(
          "Gagal Masuk",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          style: GoogleFonts.inter(color: Colors.grey.shade800, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFE8E1ED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            onPressed: () => Navigator.pop(c),
            child: Text(
              "OK",
              style: GoogleFonts.inter(
                color: const Color(0xFF003D5B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
