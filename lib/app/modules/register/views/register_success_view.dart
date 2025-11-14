import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/register_controller.dart';

class RegisterSuccessView extends GetView<RegisterController> {
  const RegisterSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF176BFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const baseWidth = 375.0;
          final screenSize = MediaQuery.of(context).size;
          final maxWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : screenSize.width;
          final scale = (maxWidth / baseWidth).clamp(0.85, 1.15);

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 60 * scale),
                          // Success Icon
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  width: 120 * scale,
                                  height: 120 * scale,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 30 * scale,
                                        offset: Offset(0, 15 * scale),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 80 * scale,
                                    color: const Color(0xFF176BFF),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 40 * scale),
                          // Title
                          Text(
                            'Félicitations !',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 32 * scale,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16 * scale),
                          // Subtitle
                          Text(
                            'Votre compte Sportify a été créé avec succès',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 18 * scale,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 48 * scale),
                          // Welcome Card
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24 * scale),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20 * scale),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 20 * scale,
                                  offset: Offset(0, 10 * scale),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Bienvenue dans la communauté Sportify !',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 20 * scale,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16 * scale),
                                Text(
                                  'Vous pouvez maintenant découvrir tous les événements sportifs près de chez vous, créer vos propres événements et rencontrer d\'autres passionnés de sport.',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 15 * scale,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32 * scale),
                        ],
                      ),
                    ),
                  ),
                ),
                // Continue Button
                Padding(
                  padding: EdgeInsets.all(24 * scale),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.home);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20 * scale),
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF176BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Commencer',
                        style: GoogleFonts.inter(
                          fontSize: 17 * scale,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

