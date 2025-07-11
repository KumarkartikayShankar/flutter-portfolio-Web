import 'package:flutter/material.dart';
import 'package:portfolio_web/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartikay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AppLoader(),
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  Future<void> _loadResources() async {
    // Add your actual initialization here
    await Future.delayed(const Duration(seconds: 2)); // Simulated loading
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadResources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingScreen();
        }
        return const HomePage();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C5364),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your custom PNG logo
            Center(
              child: Image.asset(
                'assets/kumarcircular.png', // Update with your actual path
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                // Add error builder in case image fails to load
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 100);
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}