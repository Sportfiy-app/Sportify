import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_event_controller.dart';

class CreateEventView extends GetView<CreateEventController> {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: const Color(0xFF0B1220), size: 24 * scale),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Créer un événement',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1 * scale),
          child: Container(
            height: 1 * scale,
            color: const Color(0xFFE2E8F0),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Enhanced Progress indicator
            _ProgressIndicator(scale: scale),
            SizedBox(height: 20 * scale),
            // Step content with animation
            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: _buildStepContent(scale),
                ),
              ),
            ),
            // Enhanced Navigation buttons
            _NavigationButtons(scale: scale),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(double scale) {
    switch (controller.currentStep.value) {
      case 0:
        return _SportSelectionStep(key: const ValueKey(0), scale: scale);
      case 1:
        return _DetailsStep(key: const ValueKey(1), scale: scale);
      case 2:
        return _DateTimeStep(key: const ValueKey(2), scale: scale);
      case 3:
        return _LocationStep(key: const ValueKey(3), scale: scale);
      case 4:
        return _ParticipantsStep(key: const ValueKey(4), scale: scale);
      default:
        return const SizedBox();
    }
  }
}

// Enhanced Progress Indicator
class _ProgressIndicator extends GetView<CreateEventController> {
  const _ProgressIndicator({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              controller.totalSteps,
              (index) => Expanded(
                child: Obx(
                  () {
                    final isActive = index <= controller.currentStep.value;
                    final isCurrent = index == controller.currentStep.value;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      height: 4 * scale,
                      margin: EdgeInsets.only(right: index < controller.totalSteps - 1 ? 6 * scale : 0),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF176BFF)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2 * scale),
                        boxShadow: isCurrent
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF176BFF).withValues(alpha: 0.3),
                                  blurRadius: 4 * scale,
                                  offset: Offset(0, 2 * scale),
                                ),
                              ]
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Étape ${controller.currentStep.value + 1} sur ${controller.totalSteps}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8 * scale),
                  ),
                  child: Text(
                    '${((controller.currentStep.value + 1) / controller.totalSteps * 100).toInt()}%',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                    ),
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

// Enhanced Navigation Buttons
class _NavigationButtons extends GetView<CreateEventController> {
  const _NavigationButtons({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10 * scale,
            offset: Offset(0, -2 * scale),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Obx(
              () => controller.currentStep.value > 0
                  ? Expanded(
                      child: OutlinedButton(
                        onPressed: controller.previousStep,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16 * scale),
                          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14 * scale),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_rounded, size: 18 * scale),
                            SizedBox(width: 8 * scale),
                            Text(
                              'Précédent',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF64748B),
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            SizedBox(width: controller.currentStep.value > 0 ? 12 * scale : 0),
            Expanded(
              flex: controller.currentStep.value > 0 ? 1 : 2,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : controller.currentStep.value == controller.totalSteps - 1
                          ? controller.submitEvent
                          : () {
                              if (!controller.isValid) {
                                _showValidationError(context);
                              } else {
                                controller.nextStep();
                              }
                            },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176BFF),
                    disabledBackgroundColor: const Color(0xFFE2E8F0),
                    padding: EdgeInsets.symmetric(vertical: 16 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: controller.isSubmitting.value
                      ? SizedBox(
                          height: 20 * scale,
                          width: 20 * scale,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.currentStep.value == controller.totalSteps - 1
                                  ? 'Créer l\'événement'
                                  : 'Suivant',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (controller.currentStep.value < controller.totalSteps - 1) ...[
                              SizedBox(width: 8 * scale),
                              Icon(Icons.arrow_forward_rounded, size: 18 * scale),
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showValidationError(BuildContext context) {
    Get.snackbar(
      'Champ requis',
      'Veuillez remplir tous les champs obligatoires',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFFF1F2),
      colorText: const Color(0xFFB91C1C),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(Icons.error_outline_rounded, color: const Color(0xFFB91C1C)),
    );
  }
}

// Enhanced Step 1: Sport Selection
class _SportSelectionStep extends StatelessWidget {
  const _SportSelectionStep({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quel sport ?',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Sélectionnez le sport pour votre événement',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 15 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 32 * scale),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14 * scale,
              mainAxisSpacing: 14 * scale,
              childAspectRatio: 1.05,
            ),
            itemCount: controller.availableSports.length,
            itemBuilder: (context, index) {
              final sport = controller.availableSports[index];
              return Obx(
                () {
                  final isSelected = controller.selectedSport.value == sport;
                  final sportIcon = controller.getSportIcon(sport);
                  final sportColor = controller.getSportColor(sport);

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.selectSport(sport);
                        HapticFeedback.selectionClick();
                      },
                      borderRadius: BorderRadius.circular(18 * scale),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? sportColor.withValues(alpha: 0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18 * scale),
                          border: Border.all(
                            color: isSelected
                                ? sportColor
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: sportColor.withValues(alpha: 0.2),
                                    blurRadius: 12 * scale,
                                    offset: Offset(0, 4 * scale),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 4 * scale,
                                    offset: Offset(0, 2 * scale),
                                  ),
                                ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 56 * scale,
                              height: 56 * scale,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? sportColor.withValues(alpha: 0.2)
                                    : sportColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                sportIcon,
                                size: 26 * scale,
                                color: sportColor,
                              ),
                            ),
                            SizedBox(height: 14 * scale),
                            Text(
                              sport,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0B1220),
                                fontSize: 15 * scale,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Enhanced Step 2: Details
class _DetailsStep extends StatelessWidget {
  const _DetailsStep({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails de l\'événement',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Donnez un titre et une description à votre événement',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 15 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 28 * scale),
          // Title
          _FormLabel(scale: scale, label: 'Titre *'),
          SizedBox(height: 10 * scale),
          TextField(
            controller: controller.titleController,
            decoration: InputDecoration(
              hintText: 'Ex: Match de foot amical',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 15 * scale,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFF176BFF), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
            ),
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 15 * scale,
            ),
            maxLength: 100,
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
          ),
          SizedBox(height: 24 * scale),
          // Description
          _FormLabel(scale: scale, label: 'Description *'),
          SizedBox(height: 10 * scale),
          TextField(
            controller: controller.descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Décrivez votre événement...',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 15 * scale,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: const BorderSide(color: Color(0xFF176BFF), width: 2),
              ),
              contentPadding: EdgeInsets.all(18 * scale),
            ),
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 15 * scale,
              height: 1.5,
            ),
            maxLength: 500,
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
              return Padding(
                padding: EdgeInsets.only(top: 8 * scale),
                child: Text(
                  '$currentLength / $maxLength',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 12 * scale,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 28 * scale),
          // Difficulty Level
          _FormLabel(scale: scale, label: 'Niveau de difficulté'),
          SizedBox(height: 12 * scale),
          Obx(
            () => Wrap(
              spacing: 10 * scale,
              runSpacing: 10 * scale,
              children: controller.difficultyLevels.map((level) {
                final isSelected = controller.difficultyLevel.value == level;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.difficultyLevel.value = level;
                      HapticFeedback.selectionClick();
                    },
                    borderRadius: BorderRadius.circular(12 * scale),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF176BFF)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1.5,
                        ),
                      ),
                      child: Text(
                        level,
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF64748B),
                          fontSize: 14 * scale,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 28 * scale),
          // Tags
          _FormLabel(scale: scale, label: 'Tags (optionnel)'),
          SizedBox(height: 12 * scale),
          Obx(
            () => Wrap(
              spacing: 10 * scale,
              runSpacing: 10 * scale,
              children: controller.availableTags.map((tag) {
                final isSelected = controller.selectedTags.contains(tag);
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.toggleTag(tag);
                      HapticFeedback.selectionClick();
                    },
                    borderRadius: BorderRadius.circular(12 * scale),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF16A34A).withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16 * scale,
                              color: const Color(0xFF16A34A),
                            ),
                            SizedBox(width: 6 * scale),
                          ],
                          Text(
                            tag,
                            style: GoogleFonts.inter(
                              color: isSelected
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF64748B),
                              fontSize: 14 * scale,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
        ],
      ),
    );
  }
}

// Enhanced Step 3: Date & Time
class _DateTimeStep extends StatelessWidget {
  const _DateTimeStep({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date et heure',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Quand se déroulera votre événement ?',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 15 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 32 * scale),
          // Date
          _FormLabel(scale: scale, label: 'Date *'),
          SizedBox(height: 10 * scale),
          Obx(
            () => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.selectDate(context),
                borderRadius: BorderRadius.circular(14 * scale),
                child: Container(
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(
                      color: controller.selectedDate.value == null
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFF176BFF),
                      width: controller.selectedDate.value == null ? 1.5 : 2,
                    ),
                    boxShadow: controller.selectedDate.value != null
                        ? [
                            BoxShadow(
                              color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                              blurRadius: 8 * scale,
                              offset: Offset(0, 2 * scale),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44 * scale,
                        height: 44 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.calendar_today_rounded,
                          size: 22 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.formattedDate,
                              style: GoogleFonts.inter(
                                color: controller.selectedDate.value == null
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF0B1220),
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (controller.selectedDate.value != null) ...[
                              SizedBox(height: 2 * scale),
                              Text(
                                _getDayName(controller.selectedDate.value!),
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF64748B),
                                  fontSize: 13 * scale,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 24 * scale,
                        color: const Color(0xFF94A3B8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24 * scale),
          // Time
          _FormLabel(scale: scale, label: 'Heure *'),
          SizedBox(height: 10 * scale),
          Obx(
            () => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.selectTime(context),
                borderRadius: BorderRadius.circular(14 * scale),
                child: Container(
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(
                      color: controller.selectedTime.value == null
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFF176BFF),
                      width: controller.selectedTime.value == null ? 1.5 : 2,
                    ),
                    boxShadow: controller.selectedTime.value != null
                        ? [
                            BoxShadow(
                              color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                              blurRadius: 8 * scale,
                              offset: Offset(0, 2 * scale),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44 * scale,
                        height: 44 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.access_time_rounded,
                          size: 22 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Text(
                          controller.formattedTime,
                          style: GoogleFonts.inter(
                            color: controller.selectedTime.value == null
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF0B1220),
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 24 * scale,
                        color: const Color(0xFF94A3B8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(DateTime date) {
    final days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return days[date.weekday - 1];
  }
}

// Enhanced Step 4: Location
class _LocationStep extends StatelessWidget {
  const _LocationStep({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lieu',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Où se déroulera votre événement ?',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 15 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 32 * scale),
          // Location type selector
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _LocationTypeButton(
                    scale: scale,
                    icon: Icons.edit_location_alt_rounded,
                    label: 'Adresse',
                    isSelected: controller.locationType.value == 'address',
                    onTap: () {
                      controller.locationType.value = 'address';
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: _LocationTypeButton(
                    scale: scale,
                    icon: Icons.sports_soccer_rounded,
                    label: 'Club',
                    isSelected: controller.locationType.value == 'club',
                    onTap: () {
                      controller.locationType.value = 'club';
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: _LocationTypeButton(
                    scale: scale,
                    icon: Icons.business_rounded,
                    label: 'Partenaire',
                    isSelected: controller.locationType.value == 'partner',
                    onTap: () {
                      controller.locationType.value = 'partner';
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24 * scale),
          // Show selected location if any
          Obx(
            () {
              if (controller.locationText.value.isNotEmpty) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20 * scale),
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(
                      color: const Color(0xFF176BFF).withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40 * scale,
                        height: 40 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10 * scale),
                        ),
                        child: Icon(
                          controller.locationType.value == 'club'
                              ? Icons.sports_soccer_rounded
                              : controller.locationType.value == 'partner'
                                  ? Icons.business_rounded
                                  : Icons.location_on_outlined,
                          size: 20 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lieu sélectionné',
                              style: GoogleFonts.inter(
                                fontSize: 12 * scale,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              controller.locationText.value,
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                color: const Color(0xFF0B1220),
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          try {
                            controller.locationController.clear();
                          } catch (e) {
                            // Controller might be disposed
                          }
                          controller.locationText.value = '';
                          controller.selectedClubId.value = '';
                          controller.selectedPartnerId.value = '';
                        },
                        icon: Icon(Icons.close_rounded, size: 20 * scale, color: const Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Dynamic content based on location type
          Obx(
            () {
              if (controller.locationType.value == 'club') {
                return _ClubSelection(scale: scale);
              } else if (controller.locationType.value == 'partner') {
                return _PartnerSelection(scale: scale);
              } else {
                return _AddressInput(scale: scale);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LocationTypeButton extends StatelessWidget {
  const _LocationTypeButton({
    required this.scale,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14 * scale),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 14 * scale, horizontal: 12 * scale),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(14 * scale),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF176BFF)
                  : const Color(0xFFE2E8F0),
              width: isSelected ? 2 : 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24 * scale,
                color: isSelected
                    ? const Color(0xFF176BFF)
                    : const Color(0xFF64748B),
              ),
              SizedBox(height: 6 * scale),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12 * scale,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF176BFF)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormLabel(scale: scale, label: 'Adresse ou lieu *'),
        SizedBox(height: 10 * scale),
        TextField(
          controller: controller.locationController,
          decoration: InputDecoration(
            hintText: 'Ex: Terrain de foot, Parc de Boulogne...',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 15 * scale,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(12 * scale),
              padding: EdgeInsets.all(8 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Icon(
                Icons.location_on_outlined,
                size: 20 * scale,
                color: const Color(0xFF176BFF),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14 * scale),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14 * scale),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14 * scale),
              borderSide: const BorderSide(color: Color(0xFF176BFF), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 16 * scale),
          ),
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 15 * scale,
          ),
        ),
        SizedBox(height: 16 * scale),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.snackbar('Localisation', 'Utilisation de votre position actuelle');
            },
            borderRadius: BorderRadius.circular(14 * scale),
            child: Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14 * scale),
                border: Border.all(color: const Color(0xFF176BFF), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40 * scale,
                    height: 40 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    child: Icon(
                      Icons.my_location_rounded,
                      size: 20 * scale,
                      color: const Color(0xFF176BFF),
                    ),
                  ),
                  SizedBox(width: 14 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Utiliser ma position',
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1220),
                          ),
                        ),
                        SizedBox(height: 2 * scale),
                        Text(
                          'Détection automatique',
                          style: GoogleFonts.inter(
                            fontSize: 13 * scale,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20 * scale,
                    color: const Color(0xFF94A3B8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ClubSelection extends StatelessWidget {
  const _ClubSelection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    // Mock clubs data - replace with actual data
    final clubs = [
      {'id': '1', 'name': 'Club de Football Paris', 'address': '123 Rue de la Sport, Paris', 'distance': '2.5 km'},
      {'id': '2', 'name': 'Tennis Club Montparnasse', 'address': '45 Avenue du Sport, Paris', 'distance': '5.1 km'},
      {'id': '3', 'name': 'Basketball Center', 'address': '78 Boulevard Sportif, Paris', 'distance': '3.8 km'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormLabel(scale: scale, label: 'Sélectionner un club *'),
        SizedBox(height: 12 * scale),
        ...clubs.map((club) {
          final isSelected = controller.selectedClubId.value == club['id'];
          return Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.selectedClubId.value = club['id']!;
                  final locationText = '${club['name']!} - ${club['address']!}';
                  try {
                    controller.locationController.text = locationText;
                  } catch (e) {
                    // Controller might be disposed
                  }
                  controller.locationText.value = locationText;
                  HapticFeedback.selectionClick();
                },
                borderRadius: BorderRadius.circular(16 * scale),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF176BFF).withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF176BFF)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 2 : 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.sports_soccer_rounded,
                          size: 24 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                      SizedBox(width: 14 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              club['name']!,
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0B1220),
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 14 * scale, color: const Color(0xFF64748B)),
                                SizedBox(width: 4 * scale),
                                Expanded(
                                  child: Text(
                                    club['address']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 13 * scale,
                                      color: const Color(0xFF64748B),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              club['distance']!,
                              style: GoogleFonts.inter(
                                fontSize: 12 * scale,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          size: 24 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _PartnerSelection extends StatelessWidget {
  const _PartnerSelection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    // Mock partner places data - replace with actual data
    final partners = [
      {'id': '1', 'name': 'Stade Partenaire Nord', 'address': '12 Avenue Partenaire, Paris', 'distance': '4.2 km', 'rating': '4.8'},
      {'id': '2', 'name': 'Complexe Sportif Pro', 'address': '89 Rue Partenaire, Paris', 'distance': '6.5 km', 'rating': '4.9'},
      {'id': '3', 'name': 'Arena Partenaire', 'address': '34 Boulevard Partenaire, Paris', 'distance': '3.1 km', 'rating': '4.7'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormLabel(scale: scale, label: 'Sélectionner un lieu partenaire *'),
        SizedBox(height: 12 * scale),
        ...partners.map((partner) {
          final isSelected = controller.selectedPartnerId.value == partner['id'];
          return Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.selectedPartnerId.value = partner['id']!;
                  final locationText = '${partner['name']!} - ${partner['address']!}';
                  try {
                    controller.locationController.text = locationText;
                  } catch (e) {
                    // Controller might be disposed
                  }
                  controller.locationText.value = locationText;
                  HapticFeedback.selectionClick();
                },
                borderRadius: BorderRadius.circular(16 * scale),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF16A34A).withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 2 : 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.business_rounded,
                          size: 24 * scale,
                          color: const Color(0xFF16A34A),
                        ),
                      ),
                      SizedBox(width: 14 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    partner['name']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 15 * scale,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0B1220),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFB800).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6 * scale),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star_rounded, size: 14 * scale, color: const Color(0xFFFFB800)),
                                      SizedBox(width: 2 * scale),
                                      Text(
                                        partner['rating']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 12 * scale,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFFFB800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4 * scale),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 14 * scale, color: const Color(0xFF64748B)),
                                SizedBox(width: 4 * scale),
                                Expanded(
                                  child: Text(
                                    partner['address']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 13 * scale,
                                      color: const Color(0xFF64748B),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              partner['distance']!,
                              style: GoogleFonts.inter(
                                fontSize: 12 * scale,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          size: 24 * scale,
                          color: const Color(0xFF16A34A),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Enhanced Step 5: Participants
class _ParticipantsStep extends StatelessWidget {
  const _ParticipantsStep({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateEventController>();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Participants',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 28 * scale,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Définissez le nombre de participants',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 15 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 32 * scale),
          // Min participants
          _FormLabel(scale: scale, label: 'Participants minimum'),
          SizedBox(height: 16 * scale),
          Obx(
            () => Container(
              padding: EdgeInsets.all(24 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.minParticipants.value > 1
                          ? () {
                              controller.updateMinParticipants(controller.minParticipants.value - 1);
                              HapticFeedback.selectionClick();
                            }
                          : null,
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: controller.minParticipants.value > 1
                              ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.remove_rounded,
                          size: 24 * scale,
                          color: controller.minParticipants.value > 1
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '${controller.minParticipants.value}',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0B1220),
                              fontSize: 42 * scale,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            'personnes',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF64748B),
                              fontSize: 13 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.minParticipants.value < controller.maxParticipants.value
                          ? () {
                              controller.updateMinParticipants(controller.minParticipants.value + 1);
                              HapticFeedback.selectionClick();
                            }
                          : null,
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: controller.minParticipants.value < controller.maxParticipants.value
                              ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          size: 24 * scale,
                          color: controller.minParticipants.value < controller.maxParticipants.value
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 28 * scale),
          // Max participants
          _FormLabel(scale: scale, label: 'Participants maximum'),
          SizedBox(height: 16 * scale),
          Obx(
            () => Container(
              padding: EdgeInsets.all(24 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.maxParticipants.value > controller.minParticipants.value
                          ? () {
                              controller.updateMaxParticipants(controller.maxParticipants.value - 1);
                              HapticFeedback.selectionClick();
                            }
                          : null,
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: controller.maxParticipants.value > controller.minParticipants.value
                              ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.remove_rounded,
                          size: 24 * scale,
                          color: controller.maxParticipants.value > controller.minParticipants.value
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '${controller.maxParticipants.value}',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0B1220),
                              fontSize: 42 * scale,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            'personnes',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF64748B),
                              fontSize: 13 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.updateMaxParticipants(controller.maxParticipants.value + 1);
                        HapticFeedback.selectionClick();
                      },
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          size: 24 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32 * scale),
          // Public/Private toggle
          Obx(
            () => Container(
              padding: EdgeInsets.all(20 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48 * scale,
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      color: controller.isPublic.value
                          ? const Color(0xFF16A34A).withValues(alpha: 0.1)
                          : const Color(0xFF64748B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: Icon(
                      controller.isPublic.value
                          ? Icons.public_rounded
                          : Icons.lock_rounded,
                      size: 24 * scale,
                      color: controller.isPublic.value
                          ? const Color(0xFF16A34A)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Événement public',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          controller.isPublic.value
                              ? 'Tout le monde peut voir et rejoindre'
                              : 'Seuls les invités peuvent voir',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF64748B),
                            fontSize: 13 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: controller.isPublic.value,
                    onChanged: (value) {
                      controller.isPublic.value = value;
                      HapticFeedback.selectionClick();
                    },
                    activeColor: const Color(0xFF176BFF),
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

// Helper widget for form labels
class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        color: const Color(0xFF0B1220),
        fontSize: 15 * scale,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
    );
  }
}
