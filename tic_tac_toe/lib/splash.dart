import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:tic_tac_toe/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late TextStyle ttcFont;
  late TextStyle ttcFont2;

  @override
  void initState() {
    super.initState();
    ttcFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3),
    );

    ttcFont2 = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 78, 0, 92),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Container(
                    child: Text(
                      "TIC TAC TOE",
                      style: ttcFont2.copyWith(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: AvatarGlow(
                  // glowBorderRadius: Radius(140),
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white,
                  repeat: true,
                  // repeatPauseDuration: const Duration(seconds: 1),
                  startDelay: Duration(milliseconds: 100),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 80.0,
                    child: Container(
                      child: Image.asset(
                          'assets/your_image.png'), // Replace with your image path
                      color: Colors.white,
                      // fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    child: Text(
                      'By Disara',
                      style: ttcFont2.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(30),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Play Game',
                          style: ttcFont2,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
