import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
   const MyApp ({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
title: 'Flutter Demo',
    theme: ThemeData(
        primarySwatch: Colors.blueGrey
    ),
    home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget{
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input='';
  String _result='';
  void _onButtonPressed(String buttonText){
    setState(() {
      if(buttonText == '='){
_calculateResult();
      }else if(buttonText=='C'){
        _input='';
        _result='';

      }else{
        _input+=buttonText;
      }
    });
  }
  void _calculateResult(){
    try{
      final result=_evaluateExpression(_input);
      _result=result.toString();
    }
    catch(e){
      _result='Error';
    }
  }
  double _evaluateExpression(String expression){
    Parser parser=Parser();
    ContextModel contextModel=ContextModel();
    Expression exp=parser.parse(expression);
    return exp.evaluate(EvaluationType.REAL,contextModel);
  }
  void deleteLastDigit(){
    if(_input.isNotEmpty){
      setState(() {
        _input=_input.substring(0,_input.length-1);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*1,
              width: MediaQuery.of(context).size.width*1,
             child: Container(
               child: Container(
                 decoration: const BoxDecoration(
                   gradient: LinearGradient(colors: [Color(0xfffffbd5),Color(0xffb20a2c)],begin: Alignment.topLeft,
                     end: Alignment.bottomRight,tileMode: TileMode.repeated,stops: [0.1,0.9]

                   )
                 ),
                 child: Column(
                   children: [
                     SizedBox(height: 20,),
                     Expanded(child: Container(
                       padding: EdgeInsets.all(16.0),
                       alignment:Alignment.bottomRight,
                       child: SelectableText(
                         _input,style: TextStyle(fontSize: 26.0,color: Colors.blueGrey),
                       ),
                     )),
                     Expanded(child: Container(
                       padding: EdgeInsets.all(16.0),
                       alignment:Alignment.bottomRight,
                       child: SelectableText(
                         _result,style: TextStyle(fontSize: 30.0,color: Colors.blueGrey),
                       ),
                     )),
                     Divider(height: 1.0,),
                     Container(
                       child: Row(
                         children: [
                           SizedBox(width: MediaQuery.of(context).size.width*0.8,),
                           Container(
                             decoration: BoxDecoration(color: Colors.white.withOpacity(0.3),borderRadius: BorderRadius.circular(13)),
                             child: TextButton(
                               onPressed: (){
deleteLastDigit();
                               },
                               child: Text('Edit',style: TextStyle(fontSize: 15.0),
                               ),
                             ))
                             ],

                           )
               ),
                           GridView.builder(
                               shrinkWrap:true,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 4,
                           ),
                             itemBuilder: (BuildContext context,int index){
                                final buttonText=_buttonLabels[index];
                                  return Container(
                                      margin: EdgeInsets.all(10),
  decoration: BoxDecoration(color: Colors.white.withOpacity(0.3),borderRadius: BorderRadius.circular(30)
  )
  ,
  child: TextButton(
    onPressed: (){
_onButtonPressed(buttonText);
    },
    child: Text(buttonText,style: TextStyle(fontSize: 35.0),),
  ),
);
                           },
                             itemCount: _buttonLabels.length,
                           )



                   ],
                 ),
               ),
             ),
              ),

          ],

        )



      ),
    );
  }
  final List<String> _buttonLabels=["7","8","9","/","4","5","6","*","1","2","3","-","C","0","=","+"];
}