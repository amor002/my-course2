import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: new Home(),
    );
  }

}

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Home();


}

class _Home extends State {

  String firstNumber = "";
  String secondNumber = "";
  String operator = "";
  String answer = "";

  void insertNumber(String number) {
    if(operator == "") {
      setState(() {
        firstNumber += number;
        answer = "";
      });
    }else {
      setState(() {
        secondNumber += number;
        answer = "";
      });
    }
  }

  void insertOperator(String operator) {
    if(firstNumber == "" && answer != "") {
      setState(() {
        firstNumber = answer;
        answer = "";
        this.operator = operator;
      });
    }else if(firstNumber != "") {
      setState(() {
        this.operator = operator;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30, right: 20),
            height: MediaQuery.of(context).size.height/3,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("$firstNumber $operator $secondNumber", style: TextStyle(fontSize: 21),),
                Text("$answer", style: TextStyle(fontSize: 36))
              ],
            ),
          ),
          ButtonsRow(
            labels: ['C', '^', '%', '/'],
            lastButtonColor: Colors.deepPurple,
            listeners: [() {
              setState(() {
                firstNumber = "";
                secondNumber = "";
                operator = "";
                answer = "";
              });
            },
                (){
                  insertOperator('^');
                },
                (){
                  insertOperator('%');
                },
                (){
                  insertOperator('/');
                }],

          ),
          ButtonsRow(
            labels: ['7 ', '8', '9', 'x'],
            lastButtonColor: Colors.deepPurple,
            listeners: [() {
              insertNumber("7");
            }, (){
              insertNumber("8");
            }, (){
              insertNumber("9");
            }, (){
              insertOperator('x');
            }],

          ),
          ButtonsRow(
            labels: ['4 ', '5', '6', '-'],
            lastButtonColor: Colors.deepPurple,
            listeners: [() {
              insertNumber("4");
            }, (){
              insertNumber("5");
            }, (){
              insertNumber("6");
            }, (){
              insertOperator('-');
            }],

          ),
          ButtonsRow(
            labels: ['1 ', '2', '3', '+'],
            lastButtonColor: Colors.deepPurple,
            listeners: [() {
              insertNumber("1");
            }, (){
              insertNumber("2");
            }, (){
              insertNumber("3");
            }, (){
              insertOperator('+');
            }],

          ),
          ButtonsRow(
            labels: ['0', '.', 'del', '='],
            lastButtonColor: Colors.teal,
            listeners: [() {
              insertNumber("0");
            }, (){
              insertNumber(".");
            }, (){
              if(firstNumber != "" && operator != "" && secondNumber != "") {
                setState(() {
                  secondNumber = secondNumber.substring(0, secondNumber.length-1);
                });
              }else if(firstNumber != "" && operator != "") {
                setState(() {
                  operator = "";
                });
              }else if(firstNumber != "") {
                firstNumber = firstNumber.substring(0, firstNumber.length-1);
              }
            }, (){
              if(firstNumber != "" && operator != "" && secondNumber != "") {
                if(operator == '^') {
                  setState(() {
                    double result = pow(double.parse(firstNumber), double.parse(secondNumber));
                    answer = "$result";
                  });
                }

                if(operator == 'x') {
                  setState(() {
                    double result = double.parse(firstNumber) * double.parse(secondNumber);
                    answer = "$result";
                  });
                }
                if(operator == '+') {
                  setState(() {
                    double result = double.parse(firstNumber) + double.parse(secondNumber);
                    answer = "$result";
                  });
                }
                if(operator == '-') {
                  setState(() {
                    double result = double.parse(firstNumber) - double.parse(secondNumber);
                    answer = "$result";
                  });
                }
                if(operator == '%') {
                  setState(() {
                    double result = double.parse(firstNumber) % double.parse(secondNumber);
                    answer = "$result";
                  });
                }
                if(operator == '/') {
                  setState(() {
                    double result = double.parse(firstNumber) / double.parse(secondNumber);
                    answer = "$result";
                  });
                }
              }else if(firstNumber != "" && operator != "") {
                showDialog(context: context, builder: (c) {
                  return AlertDialog(
                    content: Text("SYNTAX ERROR"),
                  );
                });
              }else if(firstNumber != "") {
                setState(() {
                  answer = firstNumber;
                });
              }
              firstNumber = "";
              secondNumber = "";
              operator = "";
            }],

          ),
        ],
      ),
    );
  }

}

class ButtonsRow extends StatelessWidget {

  List<String> labels;
  List<Function> listeners;
  Color lastButtonColor;
  ButtonsRow({this.labels, this.listeners, this.lastButtonColor});

  Widget build(BuildContext context) {
    List<Widget> children = new List();
    for(int i=0;i<labels.length;i++) {
      children.add(
          Expanded(child: Container(

            height: double.infinity,
            child: RaisedButton(

                onPressed: listeners[i],
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius:
            BorderRadius.all(Radius.circular(0))),
            color: i == labels.length-1  ? lastButtonColor : Colors.black,
            child: Text("${labels[i]}", style: TextStyle(
                color: Colors.white,
                fontSize: 24),),
          ))));

    }
    return Expanded(
      child: Row(
            children: children,
          ),
    );
  }
}