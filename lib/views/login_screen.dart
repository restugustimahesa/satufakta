// lib/login_page.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satufakta/services/auth_service.dart';
import 'package:satufakta/views/home_screen.dart';
import 'package:satufakta/views/resgister_screen.dart';
import 'package:satufakta/views/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(
    text: 'news@itg.ac.id',
  ); // Default value for easy testing
  final _passwordController = TextEditingController(
    text: 'ITG#news',
  ); // Default value
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _login() async {
    print('--- Tombol Login Ditekan! Proses _login() dimulai. ---');

    setState(() { _isLoading = true; });

    print('Mencoba memanggil Provider.of<AuthService>...');

    try {
        await Provider.of<AuthService>(context, listen: false).login(
            _emailController.text,
            _passwordController.text,
        );
        print('Pemanggilan AuthService.login() selesai tanpa error langsung.');

    } catch (error, stackTrace) {
        // BLOK INI AKAN JALAN JIKA ADA ERROR
        print('--- TERJADI ERROR SAAT MENCOBA LOGIN! ---');
        print('TIPE ERROR: ${error.runtimeType}');
        print('PESAN ERROR: $error');
        print('STACK TRACE:');
        print(stackTrace);
        print('-------------------------------------------');
        
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text('Login Gagal'),
                content: Text(error.toString()),
                actions: <Widget>[
                    TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(ctx).pop(),
                    )
                ],
            ),
        );
    }
    
    if (mounted) {
        setState(() { _isLoading = false; });
    }
}

  // Perkiraan Warna dari Gambar
  static const Color primaryButtonColor = Color(
    0xFFF76788,
  ); // Merah muda pada tombol
  static const Color linkTextColor = Color(0xFFFFA726); // Oranye untuk link

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: cBlack,
                  ),
                ),
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    color: cBlack,
                  ),
                ),
                const SizedBox(height: 48),

                // Email
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: cBlack,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: primaryButtonColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                vsLarge,

                // Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: primaryButtonColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                vsLarge,

                // Lupa Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30), // area tap yang cukup
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight,
                    ),
                    child: const Text(
                      'Lupa Password',
                      style: TextStyle(
                        color: linkTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol Sign In
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryButtonColor,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _login,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                vsMassive,

                // Belum memiliki akun? Daftar
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Belum memiliki akun? ',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar',
                          style: const TextStyle(
                            color: linkTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: linkTextColor,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const ResgisterScreen(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
