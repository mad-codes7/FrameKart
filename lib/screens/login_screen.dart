import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/favorites_service.dart';
import 'signup_screen.dart';
import 'app_shell.dart';

class LoginScreen extends StatefulWidget {
  final FavoritesService favoritesService;
  const LoginScreen({super.key, required this.favoritesService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  final _authService = AuthService();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await _authService.login(
      _emailCtrl.text.trim(),
      _passCtrl.text,
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
      await widget.favoritesService.loadFromSupabase();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => AppShell(favoritesService: widget.favoritesService),
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
                const SizedBox(height: 56),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildLabel('Email Address'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _emailCtrl,
                  hint: 'you@example.com',
                  icon: Icons.email_outlined,
                  keyboard: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter your email';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _passCtrl,
                  hint: 'Min. 6 characters',
                  icon: Icons.lock_outline_rounded,
                  obscure: _obscure,
                  suffix: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: const Color(0xFF9E8678), size: 20,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter your password';
                    if (v.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 36),
                _buildPrimaryButton(label: 'Login', loading: _loading, onTap: _login),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SignupScreen(favoritesService: widget.favoritesService),
                    )),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Color(0xFF7D6B5E), fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(color: Color(0xFFC97B4B), fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFC97B4B),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: const Color(0xFFC97B4B).withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: const Icon(Icons.view_in_ar_rounded, color: Colors.white, size: 28),
      ),
      const SizedBox(height: 24),
      const Text('Welcome Back', style: TextStyle(color: Color(0xFF2C1810), fontSize: 30, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      const Text('Login to explore furniture in AR', style: TextStyle(color: Color(0xFF9E8678), fontSize: 15)),
    ],
  );

  Widget _buildLabel(String text) => Text(text,
      style: const TextStyle(color: Color(0xFF3D2B1F), fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.3));

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: controller,
    keyboardType: keyboard,
    obscureText: obscure,
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

  Widget _buildPrimaryButton({required String label, required VoidCallback onTap, bool loading = false}) =>
    GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFC97B4B),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: const Color(0xFFC97B4B).withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Center(
          child: loading
              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
              : Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
        ),
      ),
    );

  Widget _buildDivider() => Row(children: [
    const Expanded(child: Divider(color: Color(0xFFEDE5DC))),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text('or', style: TextStyle(color: Colors.grey.shade400, fontSize: 13))),
    const Expanded(child: Divider(color: Color(0xFFEDE5DC))),
  ]);
}
