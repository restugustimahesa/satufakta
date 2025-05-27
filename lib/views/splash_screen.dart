import 'package:flutter/material.dart';
import 'package:satufakta/views/login_screen.dart';
import 'package:satufakta/views/utils/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin { // Tambahkan SingleTickerProviderStateMixin
  late AnimationController _controller;
  late Animation<double> _animation;

  final double _progressBarWidth = 300.0; // Lebar total progress bar
  final double _targetProgressWidth = 300.0; // Lebar target progress oranye

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Durasi animasi
      vsync: this, // Diperlukan oleh AnimationController
    );

    // Animasikan dari 0.0 (tidak ada progress) ke _targetProgressWidth
    _animation = Tween<double>(begin: 0.0, end: _targetProgressWidth).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Jenis kurva animasi
      ),
    )..addListener(() {
        // Panggil setState agar widget di-rebuild setiap kali nilai animasi berubah
        setState(() {});
      });

    _controller.forward(); // Mulai animasi
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', width: 200,),
            vsXLarge,
            Container(
              width: _progressBarWidth,
              height: 10,
              decoration: BoxDecoration(
                color: cGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _animation.value,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4500),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            vsLarge
          ],
        ),
      ),
    );
  }
}