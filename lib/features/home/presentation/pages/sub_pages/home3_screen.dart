// 📄 home3_screen.dart (Güncellenmiş)

import 'package:fitopia2/screens/porsiyon_analizi_page.dart';
import 'package:fitopia2/screens/screens/ayarlar_screen.dart';
import 'package:fitopia2/services/firebase_service.dart';
import 'package:fitopia2/utils/hesaplama.dart';
import 'package:flutter/material.dart';
import 'diyetplani.dart';
import 'egzersiz_planim.dart';

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

  final FirebaseService _firebaseService = FirebaseService();

  double personalizedSu = 2.5;
  int personalizedKalori = 2000;
  int personalizedAdim = 10000;

  bool isLoading = true;
  bool hasUserData = false;

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
      setState(() {
        isLoading = true;
      });

      final userId = _firebaseService.auth.currentUser?.uid;
      if (userId == null) {
        setState(() {
          isLoading = false;
          hasUserData = false;
        });
        return;
      }

      final data = await _firebaseService.getUserPreferences(userId);

      if (data != null) {
        final boy = (data['boy'] as num?)?.toDouble() ?? 0.0;
        final kilo = (data['kilo'] as num?)?.toDouble() ?? 0.0;
        final yas = (data['yas'] as num?)?.toInt() ?? 0;
        final cinsiyet = data['cinsiyet'] as String? ?? 'erkek';
        final aktiviteSeviyesi = data['aktiviteSeviyesi'] as String? ?? 'orta';

        if (boy > 0 && kilo > 0 && yas > 0) {
          final su = gunlukSuIhtiyaci(kilo);
          final kalori = gunlukKaloriIhtiyaci(
            kilo,
            boy: boy,
            yas: yas,
            cinsiyet: cinsiyet,
            aktiviteSeviyesi: aktiviteSeviyesi,
          );
          final adim = gunlukAdimHedefi(yas);

          setState(() {
            personalizedSu = su as double;
            personalizedKalori = kalori as int;
            personalizedAdim = adim as int;
            hasUserData = true;
            isLoading = false;
          });
        } else {
          setState(() {
            hasUserData = false;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasUserData = false;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasUserData = false;
      });
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

                    // Yükleme durumu veya hedef kartları
                    if (isLoading)
                      _buildLoadingCards()
                    else if (!hasUserData)
                      _buildNoDataMessage()
                    else
                      _buildGoalCards(),

                    const SizedBox(height: 32),

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

  Widget _buildLoadingCards() {
    return Row(
      children: [
        Expanded(child: _buildLoadingCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildLoadingCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildLoadingCard()),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
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
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF64748b).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Yükleniyor...',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF64748b).withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            size: 48,
            color: Colors.orange.withOpacity(0.8),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kişiselleştirilmiş Hedefler',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1e293b),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kişisel hedeflerinizi görmek için profil bilgilerinizi (yaş, kilo, boy, cinsiyet) tamamlayın.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF64748b)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AyarlarScreen()),
              ).then((_) {
                // Sayfa geri döndüğünde hedefleri yeniden yükle
                _loadUserGoals();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Profili Tamamla'),
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
                MaterialPageRoute(builder: (context) => const AyarlarScreen()),
              ).then((_) {
                // Sayfa geri döndüğünde hedefleri yeniden yükle
                _loadUserGoals();
              });
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
          if (!isLoading)
            GestureDetector(
              onTap: _loadUserGoals,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFf1f5f9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.refresh,
                  size: 20,
                  color: Color(0xFF64748b),
                ),
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
          child: PersonalizedGoalCard(
            title: 'Su İçme',
            value: '${personalizedSu.toStringAsFixed(1)}L',
            progress: 0.4, // Bu değeri gerçek verilerle güncelleyebilirsiniz
            icon: Icons.water_drop,
            gradient: const LinearGradient(
              colors: [Color(0xFFe0f7fa), Color(0xFF80deea)],
            ),
            textColor: const Color(0xFF00838f),
            progressColor: const Color(0xFF00acc1),
            subtitle: 'Günlük hedef',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PersonalizedGoalCard(
            title: 'Kalori',
            value: '${personalizedKalori.toString()}',
            progress: 0.6, // Bu değeri gerçek verilerle güncelleyebilirsiniz
            icon: Icons.local_fire_department,
            gradient: const LinearGradient(
              colors: [Color(0xFFfff3e0), Color(0xFFffcc02)],
            ),
            textColor: const Color(0xFFe65100),
            progressColor: const Color(0xFFff9800),
            subtitle: 'kcal/gün',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PersonalizedGoalCard(
            title: 'Adım',
            value: '${(personalizedAdim / 1000).toStringAsFixed(0)}K',
            progress: 0.3, // Bu değeri gerçek verilerle güncelleyebilirsiniz
            icon: Icons.directions_walk,
            gradient: const LinearGradient(
              colors: [Color(0xFFe8f5e8), Color(0xFFa5d6a7)],
            ),
            textColor: const Color(0xFF2e7d32),
            progressColor: const Color(0xFF4caf50),
            subtitle: 'Günlük hedef',
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

// Kişiselleştirilmiş Hedef Kartı Widget'ı
class PersonalizedGoalCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final double progress;
  final IconData icon;
  final Gradient gradient;
  final Color textColor;
  final Color progressColor;

  const PersonalizedGoalCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
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
        border: Border.all(color: textColor.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: textColor.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 24, color: textColor),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor.withOpacity(0.8),
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
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.4),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 3,
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
