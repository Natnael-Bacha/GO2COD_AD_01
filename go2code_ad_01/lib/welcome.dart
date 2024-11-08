import 'package:flutter/material.dart';
import 'package:go2code_ad_02/adminmainpage.dart';
import 'package:go2code_ad_02/categories.dart';
import 'package:go2code_ad_02/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

 bool isAnimationLoaded = true;

   late Future<bool> _animationLoaded = _loadAnimation();

  @override
  void initState() {
    super.initState();
    _animationLoaded = _loadAnimation();
  }

  Future<bool> _loadAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: _animationLoaded,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading(); // Show loading indicator while waiting for animation to load
        } else if (snapshot.hasError) {
          return const Text('Error loading animation'); // Handle error loading animation
        } else {
    return isAnimationLoaded ? SafeArea(
      child: Scaffold( 
        backgroundColor: const Color(0xffFFFFFF), 
        
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


            Container(
           
            child: Center(
              child: Lottie.network('https://lottie.host/33c96aa5-af03-4e08-bd4c-7042e0914a23/dTp8L8R8RU.json',
              )
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: GestureDetector(
              onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryPage()));
              },
              child: Container(
               
                width: MediaQuery.of(context).size.width/1.5,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xff8AAAE5),
                
                ),
                child: Center(
                  child: Text(
                    "Let's Play",
                    style: GoogleFonts.arima(
                      fontSize: 20, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold
              
                    ),
                  ),
                ),
              ),
            ),
          ),
      const SizedBox(height: 200,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Adminmainpage()));
            },
             child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Admin' ,
              style:GoogleFonts.arima(
                        fontSize: 20, 
                        color: const Color(0xff8AAAE5),
                        fontWeight: FontWeight.bold
             
                      ),
              ),
             ),
           ),
         )

       
          
        ],)
       
      

      ),
    ): const Loading();
  }
}
    );
  }
}