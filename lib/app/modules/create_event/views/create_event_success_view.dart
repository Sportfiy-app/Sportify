import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_event_controller.dart';

class CreateEventSuccessView extends GetView<CreateEventController> {
  const CreateEventSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40 * scale),
              // Animated Success icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 140 * scale,
                      height: 140 * scale,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF16A34A).withValues(alpha: 0.2),
                            const Color(0xFF16A34A).withValues(alpha: 0.05),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(20 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF16A34A).withValues(alpha: 0.3),
                              blurRadius: 20 * scale,
                              spreadRadius: 5 * scale,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 70 * scale,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40 * scale),
              // Title
              Text(
                'Événement créé !',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 32 * scale,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12 * scale),
              // Message
              Text(
                'Votre événement a été créé avec succès et sera visible par tous les utilisateurs.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF64748B),
                  fontSize: 16 * scale,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60 * scale),
              // Event preview card
              Obx(
                () => Container(
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20 * scale,
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
                              color: controller.getSportColor(controller.selectedSport.value).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12 * scale),
                            ),
                            child: Icon(
                              controller.getSportIcon(controller.selectedSport.value),
                              size: 24 * scale,
                              color: controller.getSportColor(controller.selectedSport.value),
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.titleController.text.isNotEmpty
                                      ? controller.titleController.text
                                      : 'Nouvel événement',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  controller.selectedSport.value,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF64748B),
                                    fontSize: 13 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * scale),
                      Wrap(
                        spacing: 12 * scale,
                        runSpacing: 8 * scale,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today_rounded, size: 16 * scale, color: const Color(0xFF64748B)),
                              SizedBox(width: 6 * scale),
                              Flexible(
                                child: Text(
                                  controller.formattedDate,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF64748B),
                                    fontSize: 13 * scale,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time_rounded, size: 16 * scale, color: const Color(0xFF64748B)),
                              SizedBox(width: 6 * scale),
                              Flexible(
                                child: Text(
                                  controller.formattedTime,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF64748B),
                                    fontSize: 13 * scale,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40 * scale),
              // Action buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176BFF),
                    padding: EdgeInsets.symmetric(vertical: 18 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_rounded, size: 20 * scale),
                      SizedBox(width: 8 * scale),
                      Text(
                        'Retour à l\'accueil',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12 * scale),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.offAllNamed('/event/create');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF176BFF),
                    side: const BorderSide(color: Color(0xFF176BFF), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 18 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline_rounded, size: 20 * scale),
                      SizedBox(width: 8 * scale),
                      Text(
                        'Créer un autre événement',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF176BFF),
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40 * scale),
            ],
          ),
        ),
      ),
    );
  }
}


