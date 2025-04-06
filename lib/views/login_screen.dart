import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:random_string/random_string.dart';
import 'package:recipe_app/views/app_main_screen.dart';
import 'package:recipe_app/views/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
    String username = "prathisthapandey10@gmail.com";
    String password = "xapq bndk sjmq cxgz";

    final smtpServer = gmail(username, password);

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
  void verifyOTP() async{
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showMessage("Please enter an email.");
      return;
    }
    String otp = _otpController.text.trim();
    if (otp.isEmpty) {
      showMessage("Please enter the OTP.");
      return;
    }
    if (_otpController.text.trim() == _generatedOTP) {
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);
      final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
      if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      await prefs.setString('username', userData['username']);
    }
      showMessage("OTP Verified Successfully!");
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AppMainScreen()),
    );
    } else {
      showMessage("Invalid OTP. Please try again!");
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
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/cheff.png'), // Local image
            fit: BoxFit.cover, // Adjust as needed
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children : [
            Text("Don't have an account?",style: TextStyle(fontSize: 12)),
            TextButton(
              onPressed: () {
                // Navigate to Signup Page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  foregroundColor: const Color.fromARGB(255, 22, 52, 75), // Change text color
                  ),
              child: Text("Signup"),
            ),
            SizedBox(width : 5),
          ]
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Color.fromARGB(255, 173, 183, 176)),
                border: OutlineInputBorder( // Default border
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder( // Border when not focused
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 173, 183, 176), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder( // Border when focused
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 106, 113, 108), width: 2),
                ),
                prefixIcon: Icon(Icons.email, color :  Color.fromARGB(255, 173, 183, 176)),
                suffixIcon: TextButton(
                  onPressed: () => sendOTP(),
                  style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Change text color
                  ),
                  child: Text("Send OTP"),
                ),
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
                hintStyle: TextStyle(color: Color.fromARGB(255, 173, 183, 176)),
                prefixIcon: Icon(Icons.lock,color : Color.fromARGB(255, 173, 183, 176)),
                border: OutlineInputBorder( // Default border
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder( // Border when not focused
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 173, 183, 176), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder( // Border when focused
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromARGB(255, 106, 113, 108), width: 2),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [

          SizedBox(height : 10),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ElevatedButton(
            onPressed: () => verifyOTP(),
              style: ElevatedButton.styleFrom(
              backgroundColor:Color.fromARGB(255, 102, 106, 103),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              ),
              child: Text(
                'Login',
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