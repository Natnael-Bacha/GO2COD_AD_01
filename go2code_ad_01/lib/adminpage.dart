import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {

  late PageController _pageController;
  late Stream<QuerySnapshot> _quizStream;


  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

 Future signout() async{
  FirebaseAuth.instance.signOut();
 } 

final TextEditingController _questionController = TextEditingController();
final TextEditingController _optiononeController = TextEditingController();
final TextEditingController _optiontwoController = TextEditingController();
final TextEditingController _optionthreeController = TextEditingController();
final TextEditingController _optionfourController = TextEditingController();
final TextEditingController _answerController = TextEditingController();
  

  String selectedValue = 'Animal';

  final List<String> catagories = [
    'Animal',
    'Object',
    'Sport',
    'Place',
  ];

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

 Future uploadQuestion() async{ 

   String addId = randomAlphaNumeric(10);
   try{
       Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('QuizImage').child(addId);
  final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
 var downloadUrl = await (await task).ref.getDownloadURL();
   FirebaseFirestore.instance.collection('Quiz').add(
    {
      'Images': downloadUrl,
      'Category': selectedValue,
      'Question': _questionController.text,
      'Option1': _optiononeController.text,
      'Option2': _optiontwoController.text,
      'Option3': _optionthreeController.text,
      'Option4': _optionfourController.text,
      'Answer':  _answerController.text,
    }
   );
   }catch(error){
    print(error.toString());
   }

    
  }

    @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _quizStream = FirebaseFirestore.instance.collection('Quiz').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
             
              Row(
                children: [
                  ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(Colors.white)),
                              onPressed: () {
                                signout();
                              },
                              child: Text(
                                'Sign Out',
                                style: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                ],
              ), 
              
            selectedImage == null ?
               GestureDetector(
                onTap: getImage,
                child: Material(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 3,
                        color: const Color(0xff8AAAE5),
                
                      ),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(Icons.add_a_photo_outlined, 
                    size: 45,
                    color: Color(0xff8AAAE5),
                    ),
                  ),
                ),
              ):
              
              Material(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 3,
                      color: const Color(0xff8AAAE5),
              
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child:  Image.file(selectedImage!, fit: BoxFit.cover,)
                ),
              ),
              const SizedBox(height: 25,),
             DropdownButtonHideUnderline(
                          child: DropdownButton2(
                               value: selectedValue,
                                items: catagories
                                    .map(
                                      (String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 30,
                                  decoration:
                                      BoxDecoration(color: Color(0xff8AAAE5)),
                                ),
                                iconStyleData: const IconStyleData(
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.white,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xff8AAAE5),
                                  ),
                                  offset: const Offset(0, -10),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: WidgetStateProperty.all<double>(6),
                                    thumbVisibility:
                                        WidgetStateProperty.all<bool>(true),
                                  ),
                                ),
                              )),
              const SizedBox(height: 25,),
              Text('Write the Question Here',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                            
                              color: Colors.white,
                              border: Border.all(
                                width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _questionController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Question',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                          const SizedBox(height: 25,),
              Text('Option 1',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)
              ),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                               width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _optiononeController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Option 1',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                          const SizedBox(height: 25,),
              Text('Option 2',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)
              ),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                               width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _optiontwoController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Option 2',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                          const SizedBox(height: 25,),
              Text('Option 3',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                               width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _optionthreeController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Option 3',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                          const SizedBox(height: 25,),
              Text('Option 4',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)
              ),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _optionfourController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Option 4',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
              
                         Text('Answer',
                style: GoogleFonts.arima(
                        fontSize: 15, 
                        color: const Color(0xff8AAAE5),)),
              Container(
                          width: 350,
                          decoration: BoxDecoration(
                            
                              color: Colors.white,
                              border: Border.all(
                                width: 0.1,
                                color: const Color(0xff8AAAE5),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller:_answerController,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Answer',
                                hintStyle: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: const Color(0xff8AAAE5),
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                   ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(const Color(0xff8AAAE5))),
                              onPressed: uploadQuestion,
                              child: Text(
                                'Add Quiz',
                                style: GoogleFonts.arima(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),      
            ],
          ),
        ),
      ),
    
    );
  }
}