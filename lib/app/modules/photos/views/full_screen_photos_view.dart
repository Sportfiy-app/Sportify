import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/full_screen_photos_controller.dart';

class FullScreenPhotosView extends GetView<FullScreenPhotosController> {
  const FullScreenPhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.85, 1.15);
          final mediaPadding = MediaQuery.of(context).padding;

          return Stack(
            children: [
              _HeroSection(scale: scale, controller: controller, topPadding: mediaPadding.top),
              _BottomPanel(scale: scale, controller: controller, bottomPadding: mediaPadding.bottom),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.scale, required this.controller, required this.topPadding});

  final double scale;
  final FullScreenPhotosController controller;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.photos.length,
              itemBuilder: (context, index) {
                final photo = controller.photos[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(photo.imageUrl, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.black.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: topPadding + 16 * scale,
              left: 16 * scale,
              right: 16 * scale,
              child: Row(
                children: [
                  _CircleButton(
                    scale: scale,
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: Get.back,
                  ),
                  const Spacer(),
                  _CircleButton(
                    scale: scale,
                    icon: Icons.ios_share_rounded,
                    onTap: controller.share,
                  ),
                  SizedBox(width: 12 * scale),
                  _CircleButton(
                    scale: scale,
                    icon: controller.isMultiSelectEnabled.value ? Icons.close_rounded : Icons.checklist_rtl_rounded,
                    onTap: controller.toggleSelectionMode,
                  ),
                ],
              ),
            ),
            Positioned(
              top: topPadding + 72 * scale,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Obx(
                    () => Text(
                      '${controller.currentIndex.value + 1} / ${controller.photos.length}',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24 * scale,
              right: 24 * scale,
              bottom: 200 * scale,
              child: _HeroOverlay(scale: scale, controller: controller),
            ),
            Positioned(
              bottom: 150 * scale,
              left: 24 * scale,
              right: 24 * scale,
              child: _HeroActions(scale: scale, controller: controller),
            ),
            Positioned(
              bottom: 120 * scale,
              left: 0,
              right: 0,
              child: _PageIndicators(scale: scale, controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroOverlay extends StatelessWidget {
  const _HeroOverlay({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    final details = controller.details;
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(24 * scale),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 24 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            details.name,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6 * scale),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.white.withValues(alpha: 0.7), size: 16 * scale),
              SizedBox(width: 6 * scale),
              Expanded(
                child: Text(
                  details.address,
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13.5 * scale),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              _ChipLabel(
                scale: scale,
                icon: Icons.star_rounded,
                label: details.rating.toStringAsFixed(1),
                color: Colors.white,
                background: const Color(0xFFFFB800).withValues(alpha: 0.25),
              ),
              SizedBox(width: 10 * scale),
              _ChipLabel(
                scale: scale,
                icon: Icons.schedule_rounded,
                label: details.openLabel,
                color: Colors.white.withValues(alpha: 0.85),
                background: Colors.white.withValues(alpha: 0.15),
              ),
            ],
          ),
          SizedBox(height: 14 * scale),
          Wrap(
            spacing: 8 * scale,
            runSpacing: 8 * scale,
            children: controller.featureChips
                .map(
                  (chip) => _FeaturePill(
                    scale: scale,
                    chip: chip,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _HeroActions extends StatelessWidget {
  const _HeroActions({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    final details = controller.details;

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: controller.openVenueBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              shadowColor: const Color(0xFF176BFF).withValues(alpha: 0.4),
              elevation: 12,
            ),
            child: Text(
              details.primaryButtonLabel,
              style: GoogleFonts.inter(fontSize: 15.5 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          flex: 2,
          child: OutlinedButton(
            onPressed: controller.download,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            child: Text(
              details.secondaryButtonLabel,
              style: GoogleFonts.inter(fontSize: 15 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _PageIndicators extends StatelessWidget {
  const _PageIndicators({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    const visibleDots = 8;
    return Obx(
      () {
        final total = controller.photos.length;
        final current = controller.currentIndex.value;
        final start = (current - visibleDots ~/ 2).clamp(0, (total - visibleDots).clamp(0, total));
        final end = (start + visibleDots).clamp(visibleDots, total);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(end - start, (index) {
            final dotIndex = start + index;
            final isActive = dotIndex == current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: EdgeInsets.symmetric(horizontal: 3 * scale),
              height: 8 * scale,
              width: isActive ? 32 * scale : 8 * scale,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF176BFF) : Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        );
      },
    );
  }
}

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.scale,
    required this.controller,
    required this.bottomPadding,
  });

  final double scale;
  final FullScreenPhotosController controller;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 520 * scale + bottomPadding,
        padding: EdgeInsets.fromLTRB(16 * scale, 24 * scale, 16 * scale, bottomPadding + 16 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32 * scale)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 40 * scale, offset: Offset(0, -16 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PanelHeader(scale: scale, controller: controller),
            SizedBox(height: 20 * scale),
            _CategorySelector(scale: scale, controller: controller),
            SizedBox(height: 20 * scale),
            _ShareRow(scale: scale, controller: controller),
            SizedBox(height: 20 * scale),
            Expanded(
              child: _PhotoGrid(scale: scale, controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.grid_on_rounded,
          background: const Color(0xFF1F2937),
          onTap: () {},
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Toutes les photos',
                style: GoogleFonts.poppins(color: const Color(0xFFE5EAF1), fontSize: 18 * scale, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2 * scale),
              Obx(
                () => Text(
                  controller.isMultiSelectEnabled.value
                      ? '${controller.selectedPhotoIds.length} sélectionnée(s)'
                      : '${controller.photos.length} photos disponibles',
                  style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5 * scale),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: controller.toggleSelectionMode,
          child: Obx(
            () => Text(
              controller.isMultiSelectEnabled.value ? 'Annuler' : 'Sélectionner',
              style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: Obx(
        () => Row(
          children: controller.categories.map((category) {
            final isActive = controller.activeCategory.value == category.name;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectCategory(category.name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF176BFF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category.name,
                        style: GoogleFonts.inter(
                          color: isActive ? Colors.white : const Color(0xFF94A3B8),
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        '(${category.count})',
                        style: GoogleFonts.inter(
                          color: isActive ? Colors.white.withValues(alpha: 0.75) : const Color(0xFF64748B),
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ShareRow extends StatelessWidget {
  const _ShareRow({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    final options = [
      _ShareOption(icon: Icons.facebook_rounded, label: 'Facebook', color: const Color(0xFF3B82F6)),
      _ShareOption(icon: Icons.alternate_email_rounded, label: 'Twitter', color: const Color(0xFF60A5FA)),
      _ShareOption(icon: Icons.camera_alt_rounded, label: 'Instagram', color: const Color(0xFFEC4899)),
      _ShareOption(icon: Icons.chat_bubble_rounded, label: 'WhatsApp', color: const Color(0xFF22C55E)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80 * scale,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final option = options[index];
              return _ShareButton(scale: scale, option: option, onTap: controller.share);
            },
            separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
            itemCount: options.length,
          ),
        ),
        SizedBox(height: 16 * scale),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'sportify.app/venue/tennis-club-premium',
                            style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11.5 * scale),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    OutlinedButton(
                      onPressed: controller.copyLink,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: const Color(0xFF176BFF)),
                        padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 10 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                      ),
                      child: Text('Copier', style: GoogleFonts.inter(fontSize: 12.5 * scale, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            ElevatedButton(
              onPressed: controller.openQrGenerator,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.qr_code_rounded, size: 18 * scale),
                  SizedBox(width: 8 * scale),
                  Text('QR Code', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({required this.scale, required this.controller});

  final double scale;
  final FullScreenPhotosController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final photos = controller.filteredPhotos;
        return GridView.builder(
          itemCount: photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8 * scale,
            mainAxisSpacing: 8 * scale,
          ),
          itemBuilder: (context, index) {
            final photo = photos[index];
            final isSelected = controller.selectedPhotoIds.contains(photo.id);
            final isActive = controller.photos[controller.currentIndex.value].id == photo.id;

            return GestureDetector(
              onTap: () {
                if (controller.isMultiSelectEnabled.value) {
                  controller.togglePhotoSelection(photo);
                } else {
                  controller.onThumbnailTap(photo);
                }
              },
              onLongPress: controller.toggleSelectionMode,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(
                    color: isActive ? const Color(0xFF176BFF) : Colors.white.withValues(alpha: 0.05),
                    width: isActive ? 2 : 1,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(0xFF176BFF).withValues(alpha: 0.35),
                            blurRadius: 16 * scale,
                            offset: Offset(0, 8 * scale),
                          )
                        ]
                      : null,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10 * scale),
                      child: Image.network(photo.imageUrl, fit: BoxFit.cover),
                    ),
                    if (controller.isMultiSelectEnabled.value)
                      Positioned(
                        top: 8 * scale,
                        right: 8 * scale,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF176BFF) : Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5 * scale),
                          ),
                          padding: EdgeInsets.all(4 * scale),
                          child: Icon(Icons.check_rounded, size: 14 * scale, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.scale,
    required this.icon,
    required this.onTap,
    this.background,
  });

  final double scale;
  final IconData icon;
  final VoidCallback onTap;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final bg = background ?? Colors.black.withValues(alpha: 0.45);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44 * scale,
        height: 44 * scale,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 18 * scale),
      ),
    );
  }
}

class _ChipLabel extends StatelessWidget {
  const _ChipLabel({
    required this.scale,
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  final double scale;
  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14 * scale),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({required this.scale, required this.chip});

  final double scale;
  final VenueFeatureChip chip;

  @override
  Widget build(BuildContext context) {
    final isLight = chip.color == Colors.white;
    final textColor = isLight ? Colors.white : chip.color;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: chip.color.withValues(alpha: isLight ? 0.2 : 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: chip.color.withValues(alpha: 0.3)),
      ),
      child: Text(
        chip.label,
        style: GoogleFonts.inter(color: textColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ShareOption {
  const _ShareOption({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.scale, required this.option, required this.onTap});

  final double scale;
  final _ShareOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60 * scale,
            height: 60 * scale,
            decoration: BoxDecoration(
              color: option.color,
              borderRadius: BorderRadius.circular(18 * scale),
              boxShadow: [
                BoxShadow(color: option.color.withValues(alpha: 0.35), blurRadius: 16 * scale, offset: Offset(0, 10 * scale)),
              ],
            ),
            child: Icon(option.icon, color: Colors.white, size: 24 * scale),
          ),
          SizedBox(height: 8 * scale),
          Text(
            option.label,
            style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale),
          ),
        ],
      ),
    );
  }
}

