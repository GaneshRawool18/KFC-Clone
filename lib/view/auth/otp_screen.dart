import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kfc_app/controller/auth_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthController authController = Get.find();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
        _startTimer();
      } else {
        setState(() => _canResend = true);
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
      authController.sendOTP(authController.phoneNumber); // 📩 Resend OTP
    }
  }

  void _submitOtp() {
    String otp = _otpControllers.map((c) => c.text.trim()).join();
    if (otp.length == 6) {
      authController.verifyOTP(otp);
    } else {
      Get.snackbar("Error", "Please enter the complete 6-digit OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h * 0.03),
              const Text(
                "WE JUST TEXTED YOU",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h * 0.01),
              const Text("Enter the verification code sent to your phone"),
              SizedBox(height: h * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: w * 0.12,
                    height: h * 0.07,
                    child: TextField(
                      controller: _otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(counterText: ''),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: h * 0.03),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: w * 0.04, color: Colors.grey[600]),
                  children: [
                    const TextSpan(text: 'Your code will expire in '),
                    TextSpan(
                      text: '$_secondsRemaining sec',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _canResend ? _resendCode : null,
                child: Text(
                  'Resend the Code',
                  style: TextStyle(
                    fontSize: w * 0.035,
                    color: _canResend ? Colors.redAccent : Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: h * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: w * 0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
