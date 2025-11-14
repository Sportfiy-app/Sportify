import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterPushNotificationsView extends GetView<RegisterController> {
  const RegisterPushNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final maxWidth = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (maxWidth / designWidth).clamp(0.85, 1.1);

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: designWidth * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderBar(scale: scale),
                      SizedBox(height: 20 * scale),
                      _HeroSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _NotificationsPitch(scale: scale),
                      SizedBox(height: 24 * scale),
                      _FeaturesList(scale: scale),
                      SizedBox(height: 24 * scale),
                      _PrivacyCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _ExamplesSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _StatsBanner(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TestimonialCard(scale: scale),
                      SizedBox(height: 24 * scale),
                      _CategoriesGrid(scale: scale),
                      SizedBox(height: 24 * scale),
                      _FaqSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _CommunityInvite(scale: scale),
                      SizedBox(height: 32 * scale),
                      _FooterActions(scale: scale),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends GetView<RegisterController> {
  const _HeaderBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
        const Spacer(),
        TextButton(
          onPressed: controller.skipNotificationsSetup,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Plus tard'),
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 240 * scale,
          height: 240 * scale,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              begin: Alignment(-0.35, 0.35),
              end: Alignment(0.35, 1.06),
            ),
            borderRadius: BorderRadius.circular(160 * scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0x33176BFF),
                blurRadius: 36 * scale,
                offset: Offset(0, 18 * scale),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200 * scale,
                height: 200 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(120 * scale),
                ),
              ),
              Positioned(
                top: 36 * scale,
                child: Icon(Icons.notifications_active_rounded, size: 72 * scale, color: const Color(0xFF176BFF)),
              ),
              Positioned(
                bottom: 40 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 18 * scale,
                        offset: Offset(0, 10 * scale),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12 * scale,
                        height: 12 * scale,
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Text(
                        'Match confirmé !',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28 * scale),
        Text(
          'Notifications Push',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 30 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Reste informé en temps réel : matchs, messages, nouveautés. Active les notifications !',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 18 * scale,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _NotificationsPitch extends StatelessWidget {
  const _NotificationsPitch({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  color: const Color(0x19176BFF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.schedule, color: const Color(0xFF176BFF), size: 22 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  'Reste à jour sur ton agenda sportif',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Nous t’alertons uniquement sur ce qui compte : rappels de matchs, nouveaux messages et événements exclusifs dans ta région.',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesList extends StatelessWidget {
  const _FeaturesList({required this.scale});

  final double scale;

  final _features = const [
    _FeatureItem(
      icon: Icons.sports_basketball_outlined,
      title: 'Rappels de matchs',
      subtitle: 'Ne rate jamais ton prochain terrain, nous t’avertissons au bon moment.',
      iconColor: Color(0xFF176BFF),
      background: Color(0x19176BFF),
    ),
    _FeatureItem(
      icon: Icons.forum_outlined,
      title: 'Messages instantanés',
      subtitle: 'Préviens ton équipe, organise tes rendez-vous sans ouvrir l’app.',
      iconColor: Color(0xFF16A34A),
      background: Color(0x1916A34A),
    ),
    _FeatureItem(
      icon: Icons.emoji_events_outlined,
      title: 'Événements exclusifs',
      subtitle: 'Tournois, nouveautés et offres dédiées aux sportifs de ta région.',
      iconColor: Color(0xFFF59E0B),
      background: Color(0x19F59E0B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _features
          .map(
            (feature) => Container(
              margin: EdgeInsets.only(bottom: 12 * scale),
              padding: EdgeInsets.all(20 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 16 * scale,
                    offset: Offset(0, 8 * scale),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(
                      color: feature.background,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    alignment: Alignment.center,
                    child: Icon(feature.icon, color: feature.iconColor, size: 22 * scale),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.title,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          feature.subtitle,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 14 * scale,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0x190EA5E9),
              borderRadius: BorderRadius.circular(9999),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.lock_outline, color: const Color(0xFF0EA5E9), size: 18 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confidentialité garantie',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Aucune publicité. Tu peux modifier ton choix à tout moment dans les paramètres.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13 * scale,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamplesSection extends StatelessWidget {
  const _ExamplesSection({required this.scale});

  final double scale;

  final _examples = const [
    _NotificationExample(
      title: 'Match dans 30 min',
      subtitle: 'Terrain de basket - Centre Sportif',
      time: '14:30',
      color: Color(0xFF176BFF),
      icon: Icons.notifications,
    ),
    _NotificationExample(
      title: 'Nouveau message de Alex',
      subtitle: '« Prêt pour le match de ce soir ? »',
      time: '12:45',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    ),
    _NotificationExample(
      title: 'Tournoi ce weekend',
      subtitle: 'Inscris-toi maintenant !',
      time: '10:15',
      color: Color(0xFFFFB800),
      icon: Icons.emoji_events_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exemples de notifications',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        Column(
          children: _examples
              .map(
                (example) => Container(
                  margin: EdgeInsets.only(bottom: 12 * scale),
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16 * scale,
                        offset: Offset(0, 8 * scale),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _NotificationAvatar(example: example, scale: scale),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              example.title,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0B1220),
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6 * scale),
                            Text(
                              example.subtitle,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13 * scale,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Text(
                        example.time,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF64748B),
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _StatsBanner extends StatelessWidget {
  const _StatsBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: Column(
        children: [
          Text(
            'Sportify en chiffres',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * scale),
          Row(
            children: [
              _StatItem(scale: scale, value: '12K+', label: 'Sportifs actifs'),
              SizedBox(width: 12 * scale),
              _StatItem(scale: scale, value: '850+', label: 'Terrains disponibles'),
              SizedBox(width: 12 * scale),
              _StatItem(scale: scale, value: '95%', label: 'Satisfaction'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?auto=format&fit=crop&w=200&q=60'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sarah M.',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star_rounded, size: 14 * scale, color: const Color(0xFFF59E0B)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            '« Grâce aux notifications, je ne rate jamais mes matchs ! Super pratique pour rester connectée avec mon équipe. »',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid({required this.scale});

  final double scale;

  final _categories = const [
    _CategoryItem('Rappels', 'Créneaux réservés', Color(0xFF176BFF)),
    _CategoryItem('Invitations', 'Nouveaux matchs', Color(0xFF16A34A)),
    _CategoryItem('Résultats', 'Scores & classements', Color(0xFFF59E0B)),
    _CategoryItem('Actualités', 'Nouveautés app', Color(0xFF0EA5E9)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toutes les notifications utiles',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: _categories
              .map(
                (category) => Container(
                  width: 160 * scale,
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 14 * scale,
                        offset: Offset(0, 8 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: category.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.notifications_active_outlined, color: category.color, size: 22 * scale),
                      ),
                      SizedBox(height: 12 * scale),
                      Text(
                        category.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        category.subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.scale});

  final double scale;

  final _faqs = const [
    'Puis-je désactiver certaines notifications ?',
    'Les notifications fonctionnent-elles hors ligne ?',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions fréquentes',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16 * scale),
        Column(
          children: _faqs
              .map(
                (question) => Container(
                  margin: EdgeInsets.only(bottom: 12 * scale),
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          question,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CommunityInvite extends StatelessWidget {
  const _CommunityInvite({required this.scale});

  final double scale;

  static const _avatars = [
    'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=200&q=60',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Text(
            'Rejoins la communauté Sportify',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._avatars.map(
                (url) => Padding(
                  padding: EdgeInsets.only(right: 8 * scale),
                  child: Container(
                    width: 32 * scale,
                    height: 32 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: Colors.white, width: 2 * scale),
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+9K',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            'Plus de 12 000 sportifs utilisent déjà les notifications pour organiser leurs matchs.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterActions extends GetView<RegisterController> {
  const _FooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressDots(scale: scale, activeIndex: 5, count: 6),
        SizedBox(height: 16 * scale),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.openPremiumOffer,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 18 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              backgroundColor: const Color(0xFF176BFF),
            ),
            child: Text(
              'Voir les abonnements',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 14 * scale),
        TextButton(
          onPressed: controller.skipNotificationsSetup,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF475569),
            textStyle: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text('Plus tard'),
        ),
        SizedBox(height: 8 * scale),
        Text(
          'Modifiable à tout moment dans Paramètres > Notifications',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 12 * scale,
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.background,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color background;
}

class _NotificationExample {
  const _NotificationExample({
    required this.title,
    required this.subtitle,
    required this.time,
    this.color,
    this.icon,
    this.avatarUrl,
  });

  final String title;
  final String subtitle;
  final String time;
  final Color? color;
  final IconData? icon;
  final String? avatarUrl;
}

class _NotificationAvatar extends StatelessWidget {
  const _NotificationAvatar({required this.example, required this.scale});

  final _NotificationExample example;
  final double scale;

  @override
  Widget build(BuildContext context) {
    if (example.avatarUrl != null) {
      return Container(
        width: 36 * scale,
        height: 36 * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          image: DecorationImage(image: NetworkImage(example.avatarUrl!), fit: BoxFit.cover),
        ),
      );
    }
    return Container(
      width: 36 * scale,
      height: 36 * scale,
      decoration: BoxDecoration(
        color: example.color!.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Icon(example.icon, color: example.color, size: 18 * scale),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.scale, required this.value, required this.label});

  final double scale;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem(this.title, this.subtitle, this.color);

  final String title;
  final String subtitle;
  final Color color;
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.scale, required this.activeIndex, required this.count});

  final double scale;
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: 8 * scale,
          height: 8 * scale,
          margin: EdgeInsets.symmetric(horizontal: 4 * scale),
          decoration: BoxDecoration(
            color: index == activeIndex ? const Color(0xFF176BFF) : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
      ),
    );
  }
}
