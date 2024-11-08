import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_02/adminpage.dart';
import 'package:go2code_ad_02/adminpanel_login.dart';


class Adminmainpage extends StatefulWidget {
  const Adminmainpage({super.key});

  @override
  State<Adminmainpage> createState() => _AdminmainpageState();
}

class _AdminmainpageState extends State<Adminmainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context , AsyncSnapshot<User?> snapshot){
        if(snapshot.hasData){
          return const Adminpage();
        }else{
          return const AdminLogin();
        }
      }
      ),
    );
  }
}