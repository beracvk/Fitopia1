import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Porsiyon Analizim',
      home: PorsiyonAnaliziPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PorsiyonAnaliziPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Görsel alanı
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFBE8DC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/siyahekranpng.webp), // Görsel buraya eklenecek
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.deepOrange),
                    SizedBox(width: 12),
                    Icon(Icons.photo_library, color: Colors.deepOrange),
                  ],
                ),
              ],
            ),
          ),

          // Başlık
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Text(
              'Porsiyon Analizim',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),

          // Tablo alanı
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFBE8DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.orangeAccent),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.orange[100]),
                    children: [
                      tableCell('Adı', isHeader: true),
                      tableCell('Kalori', isHeader: true),
                      tableCell('Porsiyon', isHeader: true),
                    ],
                  ),
                  tableRow('Brokoli:', '39 Kalori', 'Küçük'),
                  tableRow('Domates:', '13 Kalori', 'Orta'),
                  tableRow('Omlet:', '154 Kalori', 'Orta'),
                ],
              ),
            ),
          ),

          // Alt Menü
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: '',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    );
  }

  TableRow tableRow(String ad, String kalori, String porsiyon) {
    return TableRow(
      children: [tableCell(ad), tableCell(kalori), tableCell(porsiyon)],
    );
  }

  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }
}
