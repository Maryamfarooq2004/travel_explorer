import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Login Screen with social login options
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedCountryCode = '+92';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFF4A90E2).withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Header Image
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Title
                  Text(
                    'Travel',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4A90E2),
                    ),
                  ),
                  
                  Text(
                    'You are looking for a trip',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Phone Number Input
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        // Country Code Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://flagcdn.com/w40/pk.png',
                                width: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.flag, size: 24);
                                },
                              ),
                              const SizedBox(width: 5),
                              Text(
                                selectedCountryCode,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Phone Number TextField
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Send OTP',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // OR Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[400])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[400])),
                    ],
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Continue with Apple
                  SocialLoginButton(
                    icon: FontAwesomeIcons.apple,
                    text: 'Continue with Apple',
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Continue with Facebook
                  SocialLoginButton(
                    icon: FontAwesomeIcons.facebook,
                    text: 'Facebook',
                    backgroundColor: const Color(0xFF1877F2),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Continue with Google
                  SocialLoginButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Google',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    borderColor: Colors.grey[300],
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Terms
                  Text.rich(
                    TextSpan(
                      text: 'By continuing, you agree to our\n',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service · Privacy Policy · Content Policy',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF4A90E2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Social Login Button Widget
class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(icon, size: 20, color: textColor),
        label: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: borderColor ?? backgroundColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
