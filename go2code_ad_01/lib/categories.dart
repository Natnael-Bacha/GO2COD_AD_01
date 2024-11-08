import 'package:flutter/material.dart';
import 'package:go2code_ad_02/question.dart';
import 'package:google_fonts/google_fonts.dart'; 

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late String category; 
  bool main = false;

  @override
  void initState() {
    super.initState();
   setState(() {
     main = true;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
         iconTheme: const IconThemeData(
          color: Color(0xff8AAAE5), 
          size: 25, 
        ),
      ),
      backgroundColor: Colors.white,
 body: Column(
  mainAxisAlignment: main ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){

      setState(() {
        category = 'Animal';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Question(category)));
          },
          child: Column(


            children:[

          AnimatedContainer(
            duration: const Duration(seconds: 1),
              width:150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/animal.png', fit: BoxFit.cover,),
            ),
            Text('Animals',
             style: GoogleFonts.arima(
                      fontSize: 20, 
                      color: const Color(0xff8AAAE5),
                      fontWeight: FontWeight.bold
              
                    ),
            )

            ] 
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: (){

      setState(() {
        category = 'Object';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Question(category)));
          },
          child: Column(
            children:[

          AnimatedContainer(
            duration: const Duration(seconds: 1),
              width:150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/object.png', fit: BoxFit.cover,),
            ),
            Text('Objects',
             style: GoogleFonts.arima(
                      fontSize: 20, 
                      color: const Color(0xff8AAAE5),
                      fontWeight: FontWeight.bold
              
                    ),
            )

            ] 
          ),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){

      setState(() {
        category = 'Sport';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Question(category)));
          },
          child: Column(
            children:[

          AnimatedContainer(
            duration: const Duration(seconds: 1),
              width:150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/sport.png', fit: BoxFit.cover,),
            ),
            Text('Sports',
             style: GoogleFonts.arima(
                      fontSize: 20, 
                      color: const Color(0xff8AAAE5),
                      fontWeight: FontWeight.bold
              
                    ),
            )

            ] 
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: (){

      setState(() {
        category = 'Place';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Question(category)));
          },
          child: Column(
            children:[

          AnimatedContainer(
            duration: const Duration(seconds: 1),
              width:150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/place.png', fit: BoxFit.cover,),
            ),
            Text('Places',
             style: GoogleFonts.arima(
                      fontSize: 20, 
                      color: const Color(0xff8AAAE5),
                      fontWeight: FontWeight.bold
              
                    ),
            )

            ] 
          ),
        )
      ],
    )
  ],
 ),
    );
  }
}