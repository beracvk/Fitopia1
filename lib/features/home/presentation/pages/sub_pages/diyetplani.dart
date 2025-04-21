// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, file_names

import 'package:fitopia2/features/meals/presentations/Ogle_screen.dart';
import 'package:fitopia2/features/meals/presentations/aksam_screen.dart';
import 'package:fitopia2/features/meals/presentations/ara_screen.dart';
import 'package:fitopia2/features/meals/presentations/kahvalti_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( Diyetplani());
}

class Diyetplani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 131,
                top: 7,
                child: Text(
                  'Diyet Planım',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 153,
                top: 37,
                child: Text(
                  'Cuma, 14 şubat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF196F3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 148,
                top: 57,
                child: Container(height: 30),
              ),
              Positioned(
                left: 33,
                top: 111,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '200\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Alınan',
                        style: TextStyle(
                          color: const Color(0xFF196F3D),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: 311,
                top: 106,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '100\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Yakılan',
                        style: TextStyle(
                          color: const Color(0xFF196F3D),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: 269,
                top: 200,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 137,
                  height: 128,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(side: BorderSide(width: 1)),
                  ),
                ),
              ),
              Positioned(
                left: 162,
                top: 103,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '1278\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Kalan',
                        style: TextStyle(
                          color: const Color(0xFF196F3D),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: 35,
                top: 211,
                child: Container(
                  width: 326,
                  height: 67,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 33,
                top: 214,
                child: Container(
                  width: 334,
                  height: 64,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 240,
                child: Container(
                  width: 332,
                  height: 68,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0E6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 23,
                        top: 10,
                        child: Text(
                          'Karbonhidrat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 149,
                        top: 10,
                        child: Text(
                          'Protein',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 259,
                        top: 10,
                        child: Text(
                          'Yağlar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 31,
                        child: Container(
                          width: 49,
                          height: 5,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 148,
                        top: 31,
                        child: Container(
                          width: 49,
                          height: 5,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 254,
                        top: 31,
                        child: Container(
                          width: 49,
                          height: 5,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 34,
                        top: 39,
                        child: Text(
                          '0/100g',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 155,
                        top: 39,
                        child: Text(
                          '0/91g',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 261,
                        top: 43,
                        child: Text(
                          '0/69g',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Öğle Yemeği Button
              Positioned(
                left: 211,
                top: 360,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OgleScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 169,
                    height: 186,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6DDCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 29,
                          top: 8,
                          child: Text(
                            'Öğle Yemeği',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 36,
                          top: 39,
                          child: Container(
                            width: 99,
                            height: 95,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 142,
                          child: Text(
                            'Ton balığı, salata, süzme peynir',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 169,
                          child: Text(
                            '322,2 kcal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF808080),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Kahvaltı Button
              Positioned(
                left: 17,
                top: 360,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KahvaltiScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 169,
                    height: 186,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6DDCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 47,
                          top: 7,
                          child: Text(
                            'Kahvaltı',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 36,
                          top: 37,
                          child: Container(
                            width: 99,
                            height: 95,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 134,
                          child: Text(
                            'Yulap lapası, muz, fıstık \nezmesi,tarçın',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 168,
                          child: Text(
                            '312,2 kcal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF808080),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 171,
                top: 502,
                child: SizedBox(
                  width: 15,
                  height: 4,
                  child: Text(
                    '\n',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Ara Öğün Button
              Positioned(
                left: 17,
                top: 600,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AraScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 169,
                    height: 192,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6DDCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 42,
                          top: 10,
                          child: Text(
                            'Ara Öğün',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 36,
                          top: 41,
                          child: Container(
                            width: 99,
                            height: 95,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 72,
                          top: 144,
                          child: Text(
                            'Elma',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 63,
                          top: 172,
                          child: Text(
                            '63,5 kcal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF808080),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Akşam Yemeği Button
              Positioned(
                left: 214,
                top: 600,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AksamScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 169,
                    height: 195,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6DDCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 18,
                          top: 15,
                          child: Text(
                            'Akşam Yemeği',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 36,
                          top: 45,
                          child: Container(
                            width: 99,
                            height: 95,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 27,
                          top: 146,
                          child: Text(
                            'Fırında Somon, fırında\n patates, sebze salatası',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 177,
                          child: Text(
                            '359,2 kcal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF808080),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                            ),
                          ),
                        ),
                      ],
                    ),
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