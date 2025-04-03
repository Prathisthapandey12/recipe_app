import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:random_string/random_string.dart';
import 'package:recipe_app/views/app_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String _generatedOTP = ""; // Stores OTP for verification

  /// Send OTP via SMTP Email
  Future<void> sendOTP() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showMessage("Please enter an email.");
      return;
    }

    // Generate a random 6-digit OTP
    _generatedOTP = randomNumeric(6);
    print("Generated OTP: $_generatedOTP"); // Debugging

    // SMTP Email Configuration
    String username = "prathisthapandey10@gmail.com"; // Replace with your email
    String password = "xapq bndk sjmq cxgz"; // Use App Password if using Gmail

    final smtpServer = gmail(username, password); // SMTP for Gmail

    final message = Message()
      ..from = Address(username, "Recipe App")
      ..recipients.add(email)
      ..subject = "Your OTP for Login"
      ..text = "Your OTP is: $_generatedOTP\n\nPlease enter this in the app to verify.";

    try {
      await send(message, smtpServer);
      showMessage("OTP sent to $email");
    } catch (e) {
      showMessage("Failed to send OTP. Check your email settings.");
      print("SMTP Error: $e");
    }
  }

  /// Verify OTP
  void verifyOTP() {
    if (_otpController.text.trim() == _generatedOTP) {
      showMessage("✅ OTP Verified Successfully!");
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AppMainScreen()),
    );
    } else {
      showMessage("❌ Invalid OTP. Please try again!");
    }
  }

  /// Show Snackbar Message
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height : 80),
          Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/cheff.png'), // Local image
            fit: BoxFit.cover, // Adjust as needed
            ),
          ),
        ),
        SizedBox(height : 20),
        Container(
          alignment: Alignment.center,
          child : Text('Enter your email to login to your account',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
        ),
        SizedBox(height : 20),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              onPressed: () => sendOTP(),
              style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 12, 96, 15),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12,horizontal : 12,),
              ),
              child: Text(
                'Send OTP',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              ),
            ),
            SizedBox(height : 20),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ElevatedButton(
            onPressed: () => verifyOTP(),
              style: ElevatedButton.styleFrom(
              backgroundColor:Color.fromARGB(255, 12, 96, 15),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              ),
              child: Text(
                'Verify OTP',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              ),
        ),
            ]
          )
          
        ],
      ),
    );
  }
}