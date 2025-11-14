import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';

class BookingConfirmationView extends StatefulWidget {
  const BookingConfirmationView({super.key});

  @override
  State<BookingConfirmationView> createState() => _BookingConfirmationViewState();
}

class _BookingConfirmationViewState extends State<BookingConfirmationView> {
  static const _initialRedirectSeconds = 12;
  Timer? _redirectTimer;
  int _remainingSeconds = _initialRedirectSeconds;

  @override
  void initState() {
    super.initState();
    _startRedirectTimer();
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    super.dispose();
  }

  void _startRedirectTimer() {
    _redirectTimer?.cancel();
    _redirectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds <= 0) {
        timer.cancel();
        _goToDashboard();
      }
    });
  }

  void _cancelRedirect() {
    if (_redirectTimer?.isActive ?? false) {
      _redirectTimer?.cancel();
      setState(() {
        _remainingSeconds = 0;
      });
    }
  }

  void _viewBooking() {
    _cancelRedirect();
    Get.offAllNamed(Routes.bookingHome);
  }

  void _goToDashboard() {
    _cancelRedirect();
    Get.offAllNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.87, 1.12);

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 20 * scale),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: designWidth * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _HeaderBar(scale: scale, onClose: _goToDashboard),
                      SizedBox(height: 32 * scale),
                      _SuccessIllustration(scale: scale),
                      SizedBox(height: 24 * scale),
                      _TitleSection(scale: scale),
                      SizedBox(height: 24 * scale),
                      _BookingSummaryCard(scale: scale),
                      SizedBox(height: 20 * scale),
                      _CalendarBanner(scale: scale, onAdd: () {
                        _cancelRedirect();
                        Get.snackbar('Agenda', 'Fonctionnalité “Ajouter à mon agenda” bientôt disponible.');
                      }),
                      SizedBox(height: 20 * scale),
                      _NotificationCard(scale: scale),
                      SizedBox(height: 20 * scale),
                      _InvitePlayersCard(scale: scale),
                      SizedBox(height: 20 * scale),
                      _QuickActionsSection(scale: scale),
                      SizedBox(height: 20 * scale),
                      _EquipmentBanner(scale: scale),
                      SizedBox(height: 20 * scale),
                      _SimilarVenuesSection(scale: scale),
                      SizedBox(height: 20 * scale),
                      _SupportCard(scale: scale, onSupport: () {
                        _cancelRedirect();
                        Get.snackbar('Support', 'Notre équipe vous répond sous 15 minutes.');
                      }),
                      SizedBox(height: 32 * scale),
                      _AutoRedirectNotice(scale: scale, seconds: _remainingSeconds, onCancel: _cancelRedirect),
                      SizedBox(height: 16 * scale),
                      _ActionButtons(scale: scale, onPrimary: _viewBooking, onSecondary: _goToDashboard),
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

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.scale, required this.onClose});

  final double scale;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          scale: scale,
          icon: Icons.arrow_back_rounded,
          onTap: Navigator.of(context).maybePop,
        ),
        Expanded(
          child: Center(
            child: Text(
              'Confirmation',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        _CircleIconButton(
          scale: scale,
          icon: Icons.close_rounded,
          onTap: onClose,
        ),
      ],
    );
  }
}

class _SuccessIllustration extends StatelessWidget {
  const _SuccessIllustration({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final size = 98.0 * scale;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size + 24 * scale,
          height: size + 24 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0x33176BFF),
          ),
        ),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0EA5E9)]),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF176BFF).withValues(alpha: 0.22),
                blurRadius: 24 * scale,
                offset: Offset(0, 14 * scale),
              ),
            ],
          ),
          child: Icon(Icons.check_rounded, color: Colors.white, size: 44 * scale),
        ),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'À vous de jouer !',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 28 * scale,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        SizedBox(height: 12 * scale),
        Text(
          'Votre réservation a bien été prise en compte, vous pouvez la gérer dans votre profil.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontSize: 16 * scale,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _BookingSummaryCard extends StatelessWidget {
  const _BookingSummaryCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                width: 54 * scale,
                height: 54 * scale,
                decoration: BoxDecoration(
                  color: const Color(0x19176BFF),
                  borderRadius: BorderRadius.circular(14 * scale),
                ),
                child: Icon(Icons.sports_tennis_rounded, color: const Color(0xFF176BFF), size: 28 * scale),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terrain de Tennis',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      'Complexe Sportif Parc Central',
                      style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 14 * scale),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '35€',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    'Payé',
                    style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          const Divider(color: Color(0xFFE2E8F0)),
          SizedBox(height: 16 * scale),
          _SummaryItem(
            scale: scale,
            icon: Icons.calendar_month_rounded,
            label: 'Samedi 2 novembre 2024',
          ),
          SizedBox(height: 14 * scale),
          _SummaryItem(
            scale: scale,
            icon: Icons.schedule_rounded,
            label: '14h00 – 16h00',
          ),
          SizedBox(height: 14 * scale),
          _SummaryItem(
            scale: scale,
            icon: Icons.location_on_rounded,
            label: 'Parc Central, 21 avenue des Sports, Nice',
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF176BFF), size: 20 * scale),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _CalendarBanner extends StatelessWidget {
  const _CalendarBanner({required this.scale, required this.onAdd});

  final double scale;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFFB923C)]),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ne ratez pas votre match !',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Ajoutez cet événement à votre agenda',
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event_available_rounded, color: Colors.white, size: 18 * scale),
                  SizedBox(width: 8 * scale),
                  Text(
                    'Ajouter',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0x0C0EA5E9),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0x330EA5E9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0EA5E9),
            ),
            child: Icon(Icons.mail_outline_rounded, color: Colors.white, size: 20 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirmation envoyée',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8 * scale),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.5),
                    children: const [
                      TextSpan(text: 'Un email et un SMS de confirmation ont été envoyés à'),
                      TextSpan(
                        text: ' alex.martin@email.com',
                        style: TextStyle(color: Color(0xFF0EA5E9), fontWeight: FontWeight.w600),
                      ),
                    ],
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

class _InvitePlayersCard extends StatelessWidget {
  const _InvitePlayersCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14 * scale,
            offset: Offset(0, 6 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Inviter des joueurs',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () => Get.snackbar('Invitation', 'Liste complète des partenaires bientôt disponible.'),
                child: Text(
                  'Tout voir',
                  style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 18 * scale),
          Row(
            children: [
              ...List.generate(3, (index) {
                final avatars = [
                  'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
                  'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
                  'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
                ];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : -12 * scale),
                  child: CircleAvatar(
                    radius: 20 * scale,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18 * scale,
                      backgroundImage: NetworkImage(avatars[index]),
                    ),
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.only(left: -12 * scale),
                child: CircleAvatar(
                  radius: 20 * scale,
                  backgroundColor: const Color(0xFFE2E8F0),
                  child: Text('+5', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  'joueurs disponibles dans votre réseau',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          GestureDetector(
            onTap: () => Get.snackbar('Invitation', 'Invitations envoyées à vos partenaires.'),
            child: Container(
              height: 48 * scale,
              decoration: BoxDecoration(
                color: const Color(0x19176BFF),
                borderRadius: BorderRadius.circular(14 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              alignment: Alignment.center,
              child: Text(
                'Inviter des partenaires',
                style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 16 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(label: 'Itinéraire', icon: Icons.navigation_rounded, background: const Color(0x19176BFF)),
      _QuickActionData(label: 'Appeler', icon: Icons.call_rounded, background: const Color(0x1916A34A)),
      _QuickActionData(label: 'Noter', icon: Icons.star_border_rounded, background: const Color(0x19FFB800)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16 * scale),
        Row(
          children: actions
              .map(
                (action) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: action == actions.last ? 0 : 12 * scale),
                    child: GestureDetector(
                      onTap: () => Get.snackbar(action.label, 'Fonctionnalité "${action.label}" bientôt disponible.'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18 * scale),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10 * scale,
                              offset: Offset(0, 6 * scale),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 44 * scale,
                              height: 44 * scale,
                              decoration: BoxDecoration(
                                color: action.background,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(action.icon, color: const Color(0xFF475569), size: 22 * scale),
                            ),
                            SizedBox(height: 10 * scale),
                            Text(
                              action.label,
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _EquipmentBanner extends StatelessWidget {
  const _EquipmentBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFA855F7), Color(0xFF7C3AED)]),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Besoin d’équipement ?',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Raquettes, balles disponibles sur place',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.92), fontSize: 14 * scale),
          ),
          SizedBox(height: 16 * scale),
          GestureDetector(
            onTap: () => Get.snackbar('Équipement', 'Options d’équipement disponibles bientôt.'),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 10 * scale),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              child: Text(
                'Voir les options',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarVenuesSection extends StatelessWidget {
  const _SimilarVenuesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final similarVenues = [
      _SimilarVenueData(
        name: 'Tennis Club Elite',
        imageUrl: 'https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?auto=format&fit=crop&w=800&q=60',
        rating: '4.8',
        price: '30€/h',
      ),
      _SimilarVenueData(
        name: 'Centre Sportif Pro',
        imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=800&q=60',
        rating: '4.6',
        price: '25€/h',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Terrains similaires',
                style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () => Get.snackbar('Terrains similaires', 'Plus d’options seront bientôt proposées.'),
              child: Text(
                'Voir plus',
                style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 226 * scale,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: similarVenues.length,
            separatorBuilder: (_, __) => SizedBox(width: 16 * scale),
            itemBuilder: (context, index) {
              final venue = similarVenues[index];
              return Container(
                width: 240 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12 * scale,
                      offset: Offset(0, 6 * scale),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
                      child: SizedBox(
                        height: 128 * scale,
                        width: double.infinity,
                        child: Image.network(venue.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16 * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venue.name,
                            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8 * scale),
                          Row(
                            children: [
                              Icon(Icons.star_rate_rounded, color: const Color(0xFFFFB800), size: 18 * scale),
                              SizedBox(width: 6 * scale),
                              Text(
                                venue.rating,
                                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
                              ),
                              const Spacer(),
                              Text(
                                venue.price,
                                style: GoogleFonts.poppins(color: const Color(0xFF176BFF), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({required this.scale, required this.onSupport});

  final double scale;
  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0EA5E9),
            ),
            child: Icon(Icons.support_agent_rounded, color: Colors.white, size: 22 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Besoin d’aide ?',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Notre équipe support est disponible 24h/7j pour vous accompagner.',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.45),
                ),
                SizedBox(height: 12 * scale),
                GestureDetector(
                  onTap: onSupport,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Contacter le support',
                        style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 6 * scale),
                      Icon(Icons.arrow_outward_rounded, color: const Color(0xFF176BFF), size: 16 * scale),
                    ],
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

class _AutoRedirectNotice extends StatelessWidget {
  const _AutoRedirectNotice({required this.scale, required this.seconds, required this.onCancel});

  final double scale;
  final int seconds;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final isActive = seconds > 0;
    return AnimatedOpacity(
      opacity: isActive ? 1 : 0.0,
      duration: const Duration(milliseconds: 280),
      child: isActive
          ? Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14 * scale),
                border: Border.all(color: const Color(0xFF176BFF).withValues(alpha: 0.18)),
              ),
              child: Row(
                children: [
                  Icon(Icons.timelapse_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
                  SizedBox(width: 10 * scale),
                  Expanded(
                    child: Text(
                      'Redirection automatique dans ${seconds}s',
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: onCancel,
                    child: Text(
                      'Annuler',
                      style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.scale, required this.onPrimary, required this.onSecondary});

  final double scale;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPrimary,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              elevation: 4,
              shadowColor: const Color(0xFF176BFF).withValues(alpha: 0.25),
            ),
            child: Text(
              'Voir la réservation',
              style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onSecondary,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              foregroundColor: const Color(0xFF0B1220),
            ),
            child: Text(
              'Terminer',
              style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44 * scale,
        height: 44 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12 * scale,
              offset: Offset(0, 6 * scale),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({required this.label, required this.icon, required this.background});

  final String label;
  final IconData icon;
  final Color background;
}

class _SimilarVenueData {
  const _SimilarVenueData({required this.name, required this.imageUrl, required this.rating, required this.price});

  final String name;
  final String imageUrl;
  final String rating;
  final String price;
}

