import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/new_post_models.dart';

class MediaPickerModal extends StatelessWidget {
  const MediaPickerModal({super.key, required this.option});

  final MediaOption option;

  bool get isPhoto => option.title.toLowerCase().contains('photo');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(maxHeight: media.size.height * 0.78),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: option.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(option.icon, color: option.accent, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isPhoto ? 'Ajouter une photo' : 'Ajouter une vidéo',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isPhoto
                                    ? 'Importez jusqu\'à 5 photos pour mettre en avant votre annonce.'
                                    : 'Ajoutez une courte vidéo pour présenter votre événement ou votre équipe.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _QuickActionTile(
                      icon: Icons.photo_library_outlined,
                      title: isPhoto ? 'Depuis la pellicule' : 'Depuis la galerie',
                      subtitle: isPhoto
                          ? 'Choisissez une photo existante sur votre appareil.'
                          : 'Sélectionnez une vidéo déjà enregistrée.',
                      accent: option.accent,
                      onTap: () => Get.snackbar('Import', 'Sélection depuis la galerie à venir.'),
                    ),
                    const SizedBox(height: 12),
                    _QuickActionTile(
                      icon: isPhoto ? Icons.camera_alt_outlined : Icons.videocam_outlined,
                      title: isPhoto ? 'Prendre une photo' : 'Enregistrer une vidéo',
                      subtitle: 'Ouvrez l\'appareil pour capturer un moment instantanément.',
                      accent: const Color(0xFF16A34A),
                      onTap: () => Get.snackbar('Caméra', 'Accès caméra disponible prochainement.'),
                    ),
                    const SizedBox(height: 12),
                    _QuickActionTile(
                      icon: Icons.insert_drive_file_outlined,
                      title: 'Parcourir les fichiers',
                      subtitle: 'Importez un fichier depuis iCloud, Drive ou autres services.',
                      accent: const Color(0xFF0EA5E9),
                      onTap: () => Get.snackbar('Fichiers', 'Explorateur de fichiers en préparation.'),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Formats acceptés',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _FormatRow(
                      icon: Icons.image_outlined,
                      label: 'Photos',
                      description: 'JPG, PNG (taille max 10 Mo)',
                    ),
                    const SizedBox(height: 8),
                    _FormatRow(
                      icon: Icons.movie_creation_outlined,
                      label: 'Vidéos',
                      description: 'MP4, MOV (durée max 90 sec)',
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: option.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.info_outline, size: 16, color: option.accent),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Conseil : privilégiez les images lumineuses et cadrées et limitez la taille pour un chargement rapide.',
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Aperçu rapide',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=800&q=60'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black.withValues(alpha: 0.05), Colors.black.withValues(alpha: 0.35)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            isPhoto ? 'Exemple de photo' : 'Exemple de clip',
                            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: Get.back,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: theme.colorScheme.outlineVariant),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Annuler',
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.snackbar('Import', 'Sélection de média enregistrée.');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: option.accent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: Text(
                              'Continuer',
                              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}

class _FormatRow extends StatelessWidget {
  const _FormatRow({required this.icon, required this.label, required this.description});

  final IconData icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
