import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/login_screen_widgets/error_message.dart';
import 'change_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // For toggling password visibility
  bool registered = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Clear any pre-existing values (if any)
    // _passwordController.text = "";
    //_usernameController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              SvgPicture.asset(
                'lib/assets/svgImgs/logo.svg',
                height: 50,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              const Text(
                'Epensy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              if (errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white70,
                  ),
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                /*     onTap: () {
                  // Ensure the field is cleared when user taps
                  setState(() {
                    _passwordController.clear();
                  });
                }, */
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white70,
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  //_usernameController.text;
                  // _passwordController.text;

                  if (registered) {
                    setState(() {
                      errorMessage = "Incorrect username or password";
                    });
                  } else
                    Navigator.of(context).pushReplacementNamed('/home');
                },
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()),
                  );
                },
                child: const Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Or',
                style: TextStyle(color: Colors.white38),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white70,
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.apple,
                    color: Colors.white70,
                  ),
                  label: const Text(
                    'Continue with Apple',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to register
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
