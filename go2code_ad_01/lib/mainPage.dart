import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_02/adminmainpage.dart';
import 'package:go2code_ad_02/welcome.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context , AsyncSnapshot<User?> snapshot){
        if(snapshot.hasData){
          return const Adminmainpage();
        }else{
          return const Welcome();
        }
      }
      ),
    );
  }
}