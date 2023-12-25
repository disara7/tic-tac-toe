import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  bool oTurn = true; //first player plays O
  var style1 = TextStyle(color: Colors.white, fontSize: 20);
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  static var ttcFont = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 35));

  static var ttcFont2 = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 0, 92),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player O',
                            style: ttcFont2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            oScore.toString(),
                            style: ttcFont,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player X',
                            style: ttcFont2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            xScore.toString(),
                            style: ttcFont,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                padding: EdgeInsets.all(25),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: (BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 120, 120, 120)))),
                      child: Center(
                          child: Text(
                        displayXO[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes += 1;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes += 1;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //first row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      _WinDialog(displayXO[0]);
    }

    //second row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _WinDialog(displayXO[3]);
    }

    //third row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _WinDialog(displayXO[6]);
    }

    //first column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      _WinDialog(displayXO[0]);
    }

    //second column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _WinDialog(displayXO[1]);
    }

    //third column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      _WinDialog(displayXO[2]);
    }

    //check diagonal 1
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      _WinDialog(displayXO[6]);
    }

    //check diagonal 2
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _WinDialog(displayXO[0]);
    } else if (filledBoxes == 9) {
      _drawDialog();
    }
  }

  void _drawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Draw!'),
            actions: [
              ElevatedButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _WinDialog(String winner) {
    Dialogs.materialDialog(
      msg: 'Winner is: $winner',
      title: 'Congratulations!',
      // animation: Lottie.asset(
      //     'assets/your_animation.json'), // Replace 'your_animation.json' with your Lottie animation file path
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            _clearBoard();
            Navigator.of(context).pop();
          },
          text: 'Play Again',
          iconData: Icons.play_arrow,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
          color: Color.fromARGB(255, 235, 200, 2),
          //radius: BorderRadius.circular(8),
        ),
      ],
    );

    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
