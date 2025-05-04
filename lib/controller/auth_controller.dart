import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kfc_app/view/auth/login_screen.dart';
import 'package:kfc_app/view/auth/otp_screen.dart';
import 'package:kfc_app/view/home/home_page.dart';
import 'package:kfc_app/view/home/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;
  late String _phoneNumber; // For resend

  // 📌 Getters (optional)
  String get phoneNumber => _phoneNumber;

  /// ✅ Send OTP
  Future<void> sendOTP(String phoneNumber) async {
    _phoneNumber = phoneNumber; // Save for resend

    await verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onVerificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        await _setLoginStatus(true);
        Get.offAll(() => HomePage());
      },
      onVerificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", e.message ?? "Verification Failed");
      },
      onCodeSent: (String verId) {
        _verificationId = verId;
        Get.to(() => OTPScreen());
      },
      onCodeAutoRetrievalTimeout: (String verId) {
        _verificationId = verId;
      },
    );
  }

  /// 📲 Reusable Firebase phone verification
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        log('Phone verification error: ${e.message}');
        onVerificationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  /// 🔒 Verify 6-digit OTP
  Future<void> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      await _setLoginStatus(true);
      Get.offAll(() => const MainScreen());
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  /// 🔁 Resend OTP
  Future<void> resendOTP() async {
    await sendOTP(_phoneNumber);
  }

  /// 🚪 Logout and go to login screen
  Future<void> logout() async {
    await _auth.signOut();
    await _setLoginStatus(false);
    Get.offAll(() => LoginScreen());
  }

  /// 💾 Set login status
  Future<void> _setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  /// ✅ Check login status
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
