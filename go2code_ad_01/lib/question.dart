import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go2code_ad_02/result.dart';
import 'package:go2code_ad_02/welcome.dart';
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  String category;
   Question(this.category, {super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  
 
  late PageController _pageController;
  late Stream<QuerySnapshot> _quizStream;
    int currentPageIndex = 0;

    @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _quizStream = FirebaseFirestore.instance.collection('Quiz') .where('Category', isEqualTo: widget.category) .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff8AAAE5), 
          size: 25, 
        ),
        actions: [
           
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
           
             children: [
               Text(widget.category,
               style: GoogleFonts.arima(
                    fontSize: 20,
                    color: const Color(0xff8AAAE5),
                    fontWeight: FontWeight.bold),
               ),
               const SizedBox(width: 180,),
               GestureDetector(
              onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
              },
              child: const Icon(Icons.home,
              size: 35,
              color: Color(0xff8AAAE5)
              ),
            ),
             ],
           ),
             
        ],
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: _quizStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
      
          List<QueryDocumentSnapshot> questions = snapshot.data!.docs;
      
          return PageView.builder(
            controller: _pageController,
            itemCount: questions.length,
            itemBuilder: (context, index) {
            Map<String, dynamic> questionData = questions[index].data() as Map<String, dynamic>;
                 return QuestionPage(questionData, () {
                if (currentPageIndex < questions.length - 1) {
                  currentPageIndex++;
                  _pageController.animateToPage(
                    currentPageIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              });
            },
          );
        },
      ),
    );
    
  }
}
class QuestionPage extends StatefulWidget {
  final Map<String, dynamic> questionData;
  final VoidCallback onNextPressed;


  const QuestionPage(this.questionData, this.onNextPressed, {super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {


   bool isCorrect1 = false;
   bool isCorrect2 = false;
   bool isCorrect3 = false;
   bool isCorrect4 = false;

   bool notCorrect1 = false;
   bool notCorrect2 = false;
   bool notCorrect3 = false;
   bool notCorrect4 = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                  color: Colors.black
                )
              ),
              child: Image.network(widget.questionData['Images'], fit: BoxFit.cover,),
            ),
            const SizedBox(height: 10,),
            Text(widget.questionData['Question'], 
            style: GoogleFonts.arima(
                        fontSize: 20, 
                        color: const Color(0xff8AAAE5),
                        fontWeight: FontWeight.bold
                
                      ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                      if(widget.questionData['Option1'] == widget.questionData['Answer']){
                      result = result + 1;
                    isCorrect1 = true;
                  }else{
                    isCorrect1 = false;
                    notCorrect1 = true;
                  }
                  });
                
                print(notCorrect1.toString());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                decoration: BoxDecoration(
                  
                    border: Border.all(
                      width: 2,
                      color: isCorrect1 ? Colors.green : ( notCorrect1 == true ? Colors.red : const Color(0xff8AAAE5)),
                    )
                  ),
                  child: Text(widget.questionData['Option1'],
                   style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
                  ),
                ),
              ),
            ),
        const SizedBox(height: 20,),
        
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                      if(widget.questionData['Option2'] == widget.questionData['Answer']){
                        result = result + 1;
                    isCorrect2 = true;
                  }else{
                    isCorrect2 = false;
                    notCorrect2 = true;
                  }
                  });
                
                print(notCorrect2.toString());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                decoration: BoxDecoration(
                  
                    border: Border.all(
                      width: 2,
                      color: isCorrect2 ? Colors.green : ( notCorrect2 == true ? Colors.red : const Color(0xff8AAAE5)),
                    )
                  ),
                  child: Text(widget.questionData['Option2'],
                   style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                      if(widget.questionData['Option3'] == widget.questionData['Answer']){
                        result = result + 1;
                    isCorrect3 = true;
                  }else{
                    isCorrect3 = false;
                    notCorrect3 = true;
                  }
                  });
                
                print(notCorrect3.toString());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                decoration: BoxDecoration(
                  
                    border: Border.all(
                      width: 2,
                      color: isCorrect3 ? Colors.green : ( notCorrect3 == true ? Colors.red : const Color(0xff8AAAE5)),
                    )
                  ),
                  child: Text(widget.questionData['Option3'],
                   style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                      if(widget.questionData['Option4'] == widget.questionData['Answer']){
                        result = result + 1;
                        isCorrect4 = true;
                  }else{  
                    isCorrect4 = false;
                    notCorrect4 = true;
                  }
                  });
                
                print(notCorrect4.toString());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                decoration: BoxDecoration(
                  
                    border: Border.all(
                      width: 2,
                      color: isCorrect4 ? Colors.green : ( notCorrect4 == true ? Colors.red : const Color(0xff8AAAE5)),
                    )
                  ),
                  child: Text(widget.questionData['Option4'],
                   style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: 
                widget.onNextPressed,
              
              child: Text('Next',
              style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
              ),
            ), 
            Text(' Score: $result',
             style:  GoogleFonts.arima(
                          fontSize: 19, 
                          color: const Color(0xff8AAAE5),
                          fontWeight: FontWeight.bold
                  
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

