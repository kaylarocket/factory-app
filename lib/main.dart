import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart'; // Import MainPage here

// Define your custom colors
const Color customBeige = Color(0xFF008080);
const Color customPink = Color(0xFF87CEEB);
const Color customLightBrown = Color(0xFFB2AC88);
const Color customBrown = Color(0xFF987070);

void main() {
  runApp(MyApp());
}

// Our main widget
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: ActivationPage(),
      routes: {
        '/main': (context) => MyHomePage(title: 'Factory App'), // Define the route for MyHomePage
      },
    );
  }
}

// Activation Page
class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  State<ActivationPage> createState() => _ActivationState();
}

class _ActivationState extends State<ActivationPage> {
  bool accountActivation = true;

  void toggleContainer() {
    setState(() {
      accountActivation = !accountActivation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Align(
              // UPM Logo
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 200,
                height: 100,
                child: Image.network(
                    'https://upm.edu.my/assets/images23/20170406143426UPM-New_FINAL.jpg'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0), // for better alignment
              child: Text(
                'Welcome !',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              // Containers
              child: SizedBox(
                width: 500,
                height: 500,
                child: accountActivation
                    ? AccountActivationContainer(toggleContainer)
                    : CodeActivationContainer(toggleContainer),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text('Disclaimer | Privacy Statement',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: Text(
                  'Copyright UPM & Kejuruteraan Minyak Sawit CCS Sdn. Bhd.',
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountActivationContainer extends StatefulWidget {
  final VoidCallback onButtonPressed;

  AccountActivationContainer(this.onButtonPressed);

  @override
  State<AccountActivationContainer> createState() =>
      _AccountActivationContainerState();
}

class _AccountActivationContainerState
    extends State<AccountActivationContainer> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: customPink,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 50), // Space btw top of container and text
          SizedBox(
            // Text
            height: 100,
            width: 300,
            child: Text(
              'Enter your mobile number to activate your account',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            // Phone Number box
            children: [
              Image.asset(
                // Flag icon
                'images/malaysia.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                // Country Code
                '+60',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10),
              SizedBox(
                // Phone no box
                height: 40,
                width: 240,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Space between
          Row(
            // Check box & terms text
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text('I agree to the terms and conditions'),
            ],
          ),
          SizedBox(height: 50), // Space between
          Center(
            // Get code Button
            child: ElevatedButton(
              onPressed: widget.onButtonPressed,
              child: Text(
                'Get Activation Code',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CodeActivationContainer extends StatelessWidget {
  final VoidCallback onButtonPressed;

  CodeActivationContainer(this.onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: customBeige,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 50), // Space btw top of container and text
          SizedBox(
            // Text
            height: 100,
            width: 300,
            child: Text(
              'Enter the activation code you received via SMS',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20), // Space btw text and otp text box
          SizedBox(
            // OTP Text box
            height: 60,
            width: 240,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  'OTP',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(height: 50), // Space btw otp text and button
          Center(
            // Activate Button
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main'); // Navigate to MainPage
              },
              child: Text(
                'Activate',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
