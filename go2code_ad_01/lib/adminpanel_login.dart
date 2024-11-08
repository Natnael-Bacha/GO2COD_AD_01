import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_02/welcome.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signIn() {
    try{
FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    }catch(error){
      print(error.toString());
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
              },
              child: const Icon(Icons.home,
              size: 35,
              color: Color(0xff8AAAE5)
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 90, 0, 0),
              child: Text(
                'Welcome, Please Insert Admin Credentials',
                style: GoogleFonts.arima(
                    fontSize: 20,
                    color: const Color(0xff8AAAE5),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 55,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(35, 35),
                  topRight: Radius.elliptical(35, 35),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: const BoxDecoration(
                      color: Color(0xff8AAAE5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(35, 35),
                        topRight: Radius.elliptical(35, 35),
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.arima(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.arima(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.arima(
                                  fontSize: 20,
                                  color: const Color(0xff8AAAE5),
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelStyle: GoogleFonts.arima(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.arima(
                                  fontSize: 20,
                                  color: const Color(0xff8AAAE5),
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          signIn();
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.arima(
                              fontSize: 20,
                              color: const Color(0xff8AAAE5),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
