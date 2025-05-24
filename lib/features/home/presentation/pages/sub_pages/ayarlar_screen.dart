// lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopia2/utils/hesaplama.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isEditing = false;
  bool isLoading = true;

  Map<String, dynamic> userInfo = {
    'name': '',
    'age': 25,
    'gender': 'Erkek',
    'height': 175,
    'currentWeight': 70,
    'dailySteps': 8000,
    'waterIntake': 2500,
    'calorieGoal': 2200,
  };

  Map<String, dynamic> editedInfo = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => isLoading = true);

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          setState(() {
            userInfo = doc.data() as Map<String, dynamic>;
            editedInfo = Map<String, dynamic>.from(userInfo);
          });
        } else {
          // İlk kez giriş yapan kullanıcı için varsayılan veriler
          userInfo['name'] = user.displayName ?? 'Kullanıcı';
          editedInfo = Map<String, dynamic>.from(userInfo);
        }
      }
    } catch (e) {
      debugPrint('Veri yükleme hatası: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veriler yüklenirken hata oluştu')),
      );
    } finally {
      setState(() => isLoading = false);
      final double boy = userInfo['height']?.toDouble() ?? 0.0;
      final double kilo = userInfo['currentWeight']?.toDouble() ?? 0.0;
      final int yas = userInfo['age']?.toInt() ?? 0;
      final String cinsiyet = userInfo['gender'] ?? 'erkek';

      // hesaplama.dart fonksiyonları
      final double su = gunlukSuIhtiyaci(kilo);
      final int kalori = gunlukKaloriIhtiyaci(
        kilo,
        boy: boy,
        yas: yas,
        cinsiyet: cinsiyet,
        aktiviteSeviyesi: 'orta',
      );
      final int adim = gunlukAdimHedefi(yas);

      // verileri güncelle
      setState(() {
        userInfo['dailySteps'] = adim;
        userInfo['waterIntake'] = su.toStringAsFixed(1); // metin olarak göster
        userInfo['calorieGoal'] = kalori;
      });
    }
  }

  Future<void> _saveUserData() async {
    setState(() => isLoading = true);

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        editedInfo['updatedAt'] = FieldValue.serverTimestamp();

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(editedInfo, SetOptions(merge: true));

        setState(() {
          userInfo = Map<String, dynamic>.from(editedInfo);
          isEditing = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgiler başarıyla kaydedildi')),
        );
      }
    } catch (e) {
      debugPrint('Kaydetme hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgiler kaydedilirken hata oluştu')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _cancelEdit() {
    setState(() {
      editedInfo = Map<String, dynamic>.from(userInfo);
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.blue[600]),
              SizedBox(height: 16),
              Text('Yükleniyor...', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Ayarlar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          if (!isEditing)
            TextButton.icon(
              onPressed: () => setState(() => isEditing = true),
              icon: Icon(Icons.edit, color: Colors.blue[600]),
              label: Text('Düzenle', style: TextStyle(color: Colors.blue[600])),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton.icon(
                  onPressed: _saveUserData,
                  icon: Icon(Icons.save, color: Colors.green[600]),
                  label: Text(
                    'Kaydet',
                    style: TextStyle(color: Colors.green[600]),
                  ),
                ),
                TextButton.icon(
                  onPressed: _cancelEdit,
                  icon: Icon(Icons.close, color: Colors.grey[600]),
                  label: Text(
                    'İptal',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Kartı
            _buildProfileCard(),
            SizedBox(height: 24),

            // Kişisel Bilgiler
            _buildSectionTitle('Kişisel Bilgiler'),
            SizedBox(height: 12),
            _buildPersonalInfoCards(),
            SizedBox(height: 24),

            // Mevcut Durum
            _buildSectionTitle('Mevcut Durum'),
            SizedBox(height: 12),
            _buildGoalCard(
              icon: Icons.monitor_weight,
              title: 'Mevcut Kilo',
              value: userInfo['currentWeight'],
              unit: 'kg',
              field: 'currentWeight',
              color: Colors.blue,
            ),
            SizedBox(height: 24),

            // Günlük Hedefler
            _buildSectionTitle('Günlük Hedefler'),
            SizedBox(height: 12),
            Column(
              children: [
                _buildGoalCard(
                  icon: Icons.directions_walk,
                  title: 'Günlük Adım',
                  value: userInfo['dailySteps'],
                  unit: 'adım',
                  field: 'dailySteps',
                  color: Colors.green,
                ),
                SizedBox(height: 12),
                _buildGoalCard(
                  icon: Icons.water_drop,
                  title: 'Su Tüketimi',
                  value: userInfo['waterIntake'],
                  unit: 'ml',
                  field: 'waterIntake',
                  color: Colors.cyan,
                ),
                SizedBox(height: 12),
                _buildGoalCard(
                  icon: Icons.local_fire_department,
                  title: 'Kalori Hedefi',
                  value: userInfo['calorieGoal'],
                  unit: 'kcal',
                  field: 'calorieGoal',
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[600],
            child: Icon(Icons.person, color: Colors.white, size: 32),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo['name'] ?? 'Kullanıcı',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Hoş geldin!',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildPersonalInfoCards() {
    return Column(
      children: [
        _buildInfoCard(
          Icons.cake,
          'Yaş',
          userInfo['age'],
          'yaşında',
          'age',
          TextInputType.number,
        ),
        SizedBox(height: 12),
        _buildGenderCard(),
        SizedBox(height: 12),
        _buildInfoCard(
          Icons.height,
          'Boy',
          userInfo['height'],
          'cm',
          'height',
          TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    dynamic value,
    String unit,
    String field,
    TextInputType inputType,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[600], size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 4),
                isEditing
                    ? Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: editedInfo[field].toString(),
                            keyboardType: inputType,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                            onChanged: (value) {
                              editedInfo[field] =
                                  inputType == TextInputType.number
                                      ? int.tryParse(value) ?? 0
                                      : value;
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(unit, style: TextStyle(color: Colors.grey[600])),
                      ],
                    )
                    : Text(
                      '$value $unit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.people, color: Colors.blue[600], size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cinsiyet',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 4),
                isEditing
                    ? DropdownButton<String>(
                      value: editedInfo['gender'],
                      isExpanded: true,
                      underline: Container(),
                      items:
                          ['Erkek', 'Kadın', 'Diğer'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          editedInfo['gender'] = newValue!;
                        });
                      },
                    )
                    : Text(
                      userInfo['gender'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required IconData icon,
    required String title,
    required dynamic value,
    required String unit,
    required String field,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          isEditing
              ? Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: editedInfo[field].toString(),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                      ),
                      onChanged: (value) {
                        editedInfo[field] = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(unit, style: TextStyle(color: Colors.white)),
                ],
              )
              : Text(
                '$value $unit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
        ],
      ),
    );
  }
}
