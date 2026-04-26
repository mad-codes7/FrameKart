import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/favorites_service.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  final FavoritesService favoritesService;
  const SignupScreen({super.key, required this.favoritesService});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  final _authService = AuthService();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final error = await _authService.signUp(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ));
    } else {
      // OTP sent by Supabase — navigate to OTP screen
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => OtpScreen(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          favoritesService: widget.favoritesService,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFEDE5DC))),
                    child: const Icon(Icons.arrow_back_rounded, color: Color(0xFF3D2B1F), size: 20),
                  ),
                ),
                const SizedBox(height: 28),
                const Text('Create Account', style: TextStyle(color: Color(0xFF2C1810), fontSize: 30, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                const Text('Join FrameKart and place furniture in your space', style: TextStyle(color: Color(0xFF9E8678), fontSize: 15, height: 1.4)),
                const SizedBox(height: 36),

                _buildLabel('Full Name'),
                const SizedBox(height: 8),
                _buildField(controller: _nameCtrl, hint: 'John Doe', icon: Icons.person_outline_rounded,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter your name';
                    if (v.trim().length < 2) return 'Name too short';
                    return null;
                  }),
                const SizedBox(height: 20),

                _buildLabel('Email Address'),
                const SizedBox(height: 8),
                _buildField(controller: _emailCtrl, hint: 'you@example.com', icon: Icons.email_outlined, keyboard: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter your email';
                    if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                    return null;
                  }),
                const SizedBox(height: 20),

                _buildLabel('Password'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _passCtrl, hint: 'Min. 6 characters', icon: Icons.lock_outline_rounded,
                  obscure: _obscure,
                  suffix: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF9E8678), size: 20),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter a password';
                    if (v.length < 6) return 'Minimum 6 characters';
                    return null;
                  }),
                const SizedBox(height: 36),

                // Send OTP button
                GestureDetector(
                  onTap: _loading ? null : _sendOtp,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC97B4B),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: const Color(0xFFC97B4B).withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6))],
                    ),
                    child: Center(
                      child: _loading
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                          : const Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(Icons.send_rounded, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Send OTP to Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                            ]),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Color(0xFF7D6B5E), fontSize: 14),
                      children: [TextSpan(text: 'Login', style: TextStyle(color: Color(0xFFC97B4B), fontWeight: FontWeight.w700))],
                    )),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(color: Color(0xFF3D2B1F), fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.3));

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: controller, keyboardType: keyboard, obscureText: obscure,
    style: const TextStyle(color: Color(0xFF3D2B1F), fontSize: 15),
    validator: validator,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFC4B5AA)),
      prefixIcon: Icon(icon, color: const Color(0xFF9E8678), size: 20),
      suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.only(right: 12), child: suffix) : null,
      filled: true, fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFEDE5DC))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFEDE5DC))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFC97B4B), width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFEF4444))),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2)),
    ),
  );
}
