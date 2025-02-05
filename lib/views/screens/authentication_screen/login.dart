import 'package:expensy/views/screens/authentication_screen/resset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _handleLogin() async {
  //   if (_isLoading) return;

  //   setState(() {
  //     _isLoading = true;
  //     errorMessage = null;
  //   });

  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();

  //   try {
  //     if (email.isEmpty || password.isEmpty) {
  //       throw const AuthException('Please fill in all fields');
  //     }

  //     final response = await Supabase.instance.client.auth.signInWithPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (response.session != null) {
  //       // Retrieve the JWT token from the session
  //       final String jwtToken = response.session!.accessToken;

  //       // Print or use the JWT token as needed
  //       print('JWT Token: $jwtToken');

  //       if (!mounted) return;
  //       Navigator.of(context).pushReplacementNamed('/home');
  //     } else {
  //       setState(() {
  //         errorMessage = "Login failed. Please try again.";
  //       });
  //     }
  //   } on AuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = "An unexpected error occurred. Please try again.";
  //     });
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _handleLogin() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (email.isEmpty || password.isEmpty) {
        throw const AuthException('Please fill in all fields');
      }

      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final String userId = response.user!.id;
        final String userEmail = response.user!.email ?? "No email available";
        final String userName =
            response.user!.userMetadata?['name'] ?? "No name available";

        print('User ID: $userId');
        print('User email: $userEmail');
        print('User name: $userName');

        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (mounted) {
        setState(() {
          errorMessage = "Login failed. Please try again.";
        });
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.message;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "An unexpected error occurred. Please try again.";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {
      // Initialize the sign-in process
      final response = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback/',
        scopes: 'email profile',
        queryParams: {
          'access_type': 'offline',
          'prompt': 'consent',
        },
      );

      if (!mounted) return;

      // Check if the sign-in was initiated successfully
      if (response) {
        // Listen for auth state changes
        Supabase.instance.client.auth.onAuthStateChange.listen((data) {
          final AuthChangeEvent event = data.event;
          final Session? session = data.session;

          if (event == AuthChangeEvent.signedIn && session != null) {
            // Successfully signed in, navigate to home
            Navigator.of(context).pushReplacementNamed('/home');
          }
        });
      } else {
        setState(() {
          errorMessage =
              "Google sign-in was cancelled or failed. Please try again.";
        });
      }
    } on AuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage =
            "An unexpected error occurred during Google sign-in. Please try again.";
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  InputDecoration _getInputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
    );
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
                'Expensy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              if (errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: _getInputDecoration(
                  label: 'Email',
                  icon: Icons.email,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _getInputDecoration(
                  label: 'Password',
                  icon: Icons.lock,
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
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
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
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white70),
                          ),
                        )
                      : const Icon(
                          Icons.login,
                          color: Colors.white70,
                        ),
                  label: Text(
                    _isLoading ? 'Signing in...' : 'Continue with Google',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
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
