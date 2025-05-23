// ignore_for_file: unused_import, non_constant_identifier_names, use_super_parameters

import 'package:fitopia2/services/firebase_service.dart';
import 'package:fitopia2/utils/hesaplama.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/deneme_screen.dart';
import 'package:fitopia2/features/meals/presentations/Ogle_screen.dart';
import 'package:fitopia2/screens/porsiyon_analizi_page.dart';
import 'package:flutter/material.dart';
import '../../../../../widgets/profile_widget.dart';
import 'goal_card.dart';
import '../../../../../widgets/action_card.dart';
import '../../../../meals/presentations/widgets/action_card.dart'
    show ActionCard;
import 'diyetplani.dart';
import 'porsiyon_sayfasi.dart';
import 'egzersiz_planim.dart';
import 'motivasyon_page.dart';
import 'package:fitopia2/widgets/profile_widget.dart' show ProfileWidget;

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Firebase service ve kullanıcı hedefleri için değişkenler
  final FirebaseService _firebaseService = FirebaseService();
  String su = '';
  String kalori = '';
  String adim = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
    _loadUserGoals();
  }

  Future<void> _loadUserGoals() async {
    try {
      final userId = _firebaseService.auth.currentUser?.uid;
      if (userId == null) return;

      final data = await _firebaseService.getUserPreferences(userId);
      if (data != null && mounted) {
        final boy = (data['boy'] as num?)?.toDouble() ?? 0.0;
        final kilo = (data['kilo'] as num?)?.toDouble() ?? 0.0;
        final yas = (data['yas'] as num?)?.toInt() ?? 0;

        if (boy > 0 && kilo > 0 && yas > 0) {
          setState(() {
            su = gunlukSuIhtiyaci(kilo);
            kalori = gunlukKaloriIhtiyaci(kilo);
            adim = gunlukAdimHedefi(yas);
          });
        }
      }
    } catch (e) {
      // Hata durumunda sessizce devam et
      print('Hedefler yüklenemedi: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFf8fafc), Color(0xFFe2e8f0), Color(0xFFcbd5e1)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Modern Header
                    _buildHeader(),
                    const SizedBox(height: 32),

                    // Goal Cards
                    _buildGoalCards(),
                    const SizedBox(height: 32),

                    // Firebase'den gelen hedefler (varsa göster)
                    if (su.isNotEmpty && kalori.isNotEmpty && adim.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Günlük Hedefleriniz',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1e293b),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildGoalCard('💧 Su Hedefi', su),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildGoalCard(
                                    '🔥 Kalori Hedefi',
                                    kalori,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildGoalCard('👟 Adım Hedefi', adim),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    // Action Buttons
                    Expanded(child: _buildActionButtons()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748b),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1e293b),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DenemeScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF64748b), Color(0xFF475569)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF64748b).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.account_circle,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hoş geldin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748b),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1e293b),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCards() {
    return Row(
      children: [
        Expanded(
          child: MinimalGoalCard(
            title: 'Su İçme',
            value: '2.5L',
            progress: 0.6,
            icon: Icons.water_drop,
            gradient: const LinearGradient(
              colors: [Color(0xFFe0f2fe), Color(0xFFb3e5fc)],
            ),
            textColor: const Color(0xFF0277bd),
            progressColor: const Color(0xFF0277bd),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MinimalGoalCard(
            title: 'Kalori',
            value: '2000',
            progress: 0.75,
            icon: Icons.local_fire_department,
            gradient: const LinearGradient(
              colors: [Color(0xFFfff3e0), Color(0xFFffcc02)],
            ),
            textColor: const Color(0xFFe65100),
            progressColor: const Color(0xFFe65100),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MinimalGoalCard(
            title: 'Adım',
            value: '10K',
            progress: 0.4,
            icon: Icons.directions_walk,
            gradient: const LinearGradient(
              colors: [Color(0xFFe8f5e8), Color(0xFFc8e6c9)],
            ),
            textColor: const Color(0xFF2e7d32),
            progressColor: const Color(0xFF2e7d32),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Expanded(
          child: MinimalActionButton(
            title: 'Beslenme Planı',
            subtitle: 'Günlük besin takibi',
            icon: Icons.restaurant_menu,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Diyetplani()),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: MinimalActionButton(
            title: 'Egzersiz Planı',
            subtitle: 'Kişisel antrenman programı',
            icon: Icons.fitness_center,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FigmaToCodeApp()),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: MinimalActionButton(
            title: 'Porsiyon Analizi',
            subtitle: 'Yapay zeka ile porsiyon ölçümü',
            icon: Icons.camera_alt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FigmaToCodeApp2()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MinimalGoalCard extends StatelessWidget {
  final String title;
  final String value;
  final double progress;
  final IconData icon;
  final Gradient gradient;
  final Color textColor;
  final Color progressColor;

  const MinimalGoalCard({
    super.key,
    required this.title,
    required this.value,
    required this.progress,
    required this.icon,
    required this.gradient,
    required this.textColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: textColor),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.6),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class MinimalActionButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const MinimalActionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  State<MinimalActionButton> createState() => _MinimalActionButtonState();
}

class _MinimalActionButtonState extends State<MinimalActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.black.withOpacity(0.06),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFf1f5f9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 32,
                      color: const Color(0xFF64748b),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1e293b),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748b),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF94a3b8),
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
