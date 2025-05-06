// ignore_for_file: deprecated_member_use, file_names, camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OgleScreen(),
    );
  }
}

class OgleScreen extends StatelessWidget {
  const OgleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0.01,
                top: 7,
                child: SizedBox(
                  width: 300,
                  height: 101,
                  child: Text(
                    'Öğle Yemeği',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 65, 117, 38),
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 70,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 80,
                child: Text(
                  ' Fırında Somon, fırında\n patates, sebze salatası\n(brokoli, karnıbahar, ka-\n bak, patlıcan).',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 252,
                child: Container(
                  width: 65,
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF1EA5EF),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 114,
                top: 252,
                child: Container(
                  width: 65,
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF974D0),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 133,
                top: 274,
                child: Text(
                  '50gr',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 252,
                child: Container(
                  width: 65,
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF8DB50),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 315,
                top: 252,
                child: Container(
                  width: 65,
                  height: 62,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF97FC65),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 324,
                top: 274,
                child: Text(
                  '700kcal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 318,
                child: Text(
                  'Protein',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 318,
                child: Text(
                  'Karbonhidrat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 235,
                top: 318,
                child: Text(
                  'Yağ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 328,
                top: 318,
                child: Text(
                  'Kalori',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 365,
                child: Container(
                  width: 366,
                  height: 74,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 67,
                        top: 44,
                        child: Text(
                          'Sebze salatası',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 78,
                        top: 17,
                        child: Text(
                          '150 gr',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 295,
                        top: 28,
                        child: Text(
                          '200 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 10,
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 467,
                child: Container(
                  width: 366,
                  height: 74,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 77,
                        top: 45,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Fırında Somon',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 86,
                        top: 22,
                        child: Text(
                          '200 gr',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 294,
                        top: 29,
                        child: Text(
                          '400 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        top: 7,
                        child: Container(
                          width: 60,
                          height: 61,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 568,
                child: Container(
                  width: 366,
                  height: 74,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 80,
                        top: 44,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Fırında Patates',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 90,
                        top: 22,
                        child: Text(
                          '60 gr',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 293,
                        top: 28,
                        child: Text(
                          '100 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 578,
                child: Container(
                  width: 60,
                  height: 54,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 192,
                top: 670,
                child: Text(
                  '.\n.\n.\n.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 274,
                child: Text(
                  '10gr',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 235,
                top: 274,
                child: Text(
                  '30gr',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}