import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

class AuthService {
  // ── Sign Up — sends real OTP to email ──────────────────────
  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (res.user == null) return 'Sign up failed. Please try again.';
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Something went wrong. Check your connection.';
    }
  }

  // ── Verify OTP ─────────────────────────────────────────────
  Future<String?> verifyOtp({
    required String email,
    required String token,
    required String name,
  }) async {
    try {
      final res = await _supabase.auth.verifyOTP(
        email: email,
        token: token,
        type: OtpType.signup,
      );
      if (res.user == null) return 'Invalid or expired OTP.';
      // Insert profile record
      await _supabase.from('profiles').upsert({
        'id': res.user!.id,
        'name': name,
        'location': '',
      });
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Verification failed. Please try again.';
    }
  }

  // ── Login ────────────────────────────────────────────────────
  Future<String?> login(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) return 'Login failed. Please try again.';
      return null;
    } on AuthException catch (e) {
      if (e.message.contains('Invalid login')) return 'Incorrect email or password.';
      if (e.message.contains('Email not confirmed')) return 'Please verify your email OTP first.';
      return e.message;
    } catch (_) {
      return 'Something went wrong. Check your connection.';
    }
  }

  // ── Logout ──────────────────────────────────────────────────
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // ── Get current user data ───────────────────────────────────
  Future<Map<String, String>> getUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return {};
      final profile = await _supabase
          .from('profiles')
          .select('name, location')
          .eq('id', user.id)
          .maybeSingle();
      return {
        'name': profile?['name'] ?? user.userMetadata?['name'] ?? '',
        'email': user.email ?? '',
        'location': profile?['location'] ?? '',
        'joinedDate': user.createdAt,
      };
    } catch (_) {
      return {};
    }
  }

  // ── Update location ─────────────────────────────────────────
  Future<void> updateLocation(String location) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    await _supabase
        .from('profiles')
        .update({'location': location})
        .eq('id', user.id);
  }

  // ── Is logged in ────────────────────────────────────────────
  bool isLoggedIn() => _supabase.auth.currentUser != null;

  // ── Resend OTP ──────────────────────────────────────────────
  Future<String?> resendOtp(String email) async {
    try {
      await _supabase.auth.resend(type: OtpType.signup, email: email);
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Could not resend OTP.';
    }
  }
}
