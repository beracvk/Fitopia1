// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp2());
}

class FigmaToCodeApp2 extends StatelessWidget {
  const FigmaToCodeApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(body: ListView(children: [FigmaToCodeApp2()])),
    );
  }
}

class FigmaToCodeApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 25,
                top: 39,
                child: Container(
                  width: 274,
                  height: 183,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6DDCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -218,
                        top: -330,
                        child: Container(width: 736, height: 831),
                      ),
                      Positioned(
                        left: 15,
                        top: 15,
                        child: Container(
                          width: 240,
                          height: 151,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://placehold.co/240x151",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 316,
                top: 52,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEB5A3C),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 128,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEB5A3C),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 68,
                child: Container(
                  width: 31,
                  height: 31,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0),
                  ),
                ),
              ),
              Positioned(
                left: 334,
                top: 145,
                child: Container(
                  width: 33,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0),
                  ),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 25,
                top: 250,
                child: Container(
                  width: 343,
                  height: 471,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6DDCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 63,
                        top: 12,
                        child: SizedBox(
                          width: 203,
                          height: 23,
                          child: Text(
                            'Porsiyon Analizim',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFEB5A3C),
                              fontSize: 21,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -20,
                        top: 85,
                        child: SizedBox(
                          width: 136,
                          height: 49,
                          child: Text(
                            'Brokoli:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -15,
                        top: 140,
                        child: SizedBox(
                          width: 136,
                          height: 49,
                          child: Text(
                            'Domates:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -27,
                        top: 195,
                        child: SizedBox(
                          width: 136,
                          height: 49,
                          child: Text(
                            'Omlet:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 116,
                        top: 83,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            '39 Kalori',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 116,
                        top: 138,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            '13 Kalori',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 240,
                        top: 138,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            'Orta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 240,
                        top: 83,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            'Küçük',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 44,
                        child: Container(
                          width: 343,
                          height: 22,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEB5A3C),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 5,
                                top: 2,
                                child: SizedBox(
                                  width: 76,
                                  height: 23,
                                  child: Text(
                                    ' Adı',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Source Serif Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 127,
                                top: 0,
                                child: SizedBox(
                                  width: 76,
                                  height: 23,
                                  child: Text(
                                    'Kalori',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Source Serif Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 248,
                                top: 0,
                                child: SizedBox(
                                  width: 76,
                                  height: 23,
                                  child: Text(
                                    ' Porsiyon',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Source Serif Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 116,
                        top: 195,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            '154 Kalori',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 242,
                        top: 195,
                        child: SizedBox(
                          width: 92,
                          height: 27,
                          child: Text(
                            'Orta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Source Serif Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 294,
                child: Container(
                  width: 343,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEB5A3C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 372,
                child: Container(
                  width: 343,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEB5A3C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 316,
                child: Container(
                  width: 343,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEB5A3C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 549,
                child: Container(
                  width: 343,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEB5A3C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 662,
                child: Container(
                  width: 343,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEB5A3C),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
