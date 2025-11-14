import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_info_controller.dart';

class ProfileInfoView extends GetView<ProfileInfoController> {
  const ProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.12);

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 220 * scale,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                      begin: Alignment(0.35, 0.35),
                      end: Alignment(1.06, -0.35),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                      child: _Header(scale: scale),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale)
                            .copyWith(bottom: MediaQuery.of(context).padding.bottom + 140 * scale),
                        child: Column(
                          children: [
                            _AvatarCard(scale: scale),
                            SizedBox(height: 18 * scale),
                            _FormCard(scale: scale),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _SuccessBanner(scale: scale),
              _BottomActions(scale: scale),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18 * scale),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Informations profil',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.help_outline_rounded, color: Colors.white, size: 20 * scale),
        ),
      ],
    );
  }
}

class _AvatarCard extends GetView<ProfileInfoController> {
  const _AvatarCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20 * scale),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 104 * scale,
                height: 104 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4 * scale),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 24 * scale, offset: Offset(0, 12 * scale)),
                  ],
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=600&q=60'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -10 * scale,
                right: 10 * scale,
                child: Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white, width: 3 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18 * scale),
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Modifier la photo',
            style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14 * scale, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends GetView<ProfileInfoController> {
  const _FormCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FormFieldLabel(scale: scale, label: 'Nom', required: true),
          SizedBox(height: 8 * scale),
          _TextField(
            controller: controller.lastNameController,
            scale: scale,
            hint: 'Dupont',
            textInputAction: TextInputAction.next,
            onChanged: (_) => controller.touchedFields.add('lastName'),
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Prénom', required: true),
          SizedBox(height: 8 * scale),
          _TextField(
            controller: controller.firstNameController,
            scale: scale,
            hint: 'Marie',
            textInputAction: TextInputAction.next,
            onChanged: (_) => controller.touchedFields.add('firstName'),
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Email', helper: 'Non modifiable'),
          SizedBox(height: 8 * scale),
          _TextField(
            controller: controller.emailController,
            scale: scale,
            readOnly: true,
            hint: 'Adresse email',
            fillColor: const Color(0xFFF8FAFC),
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Téléphone'),
          SizedBox(height: 8 * scale),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _TextField(
                  controller: controller.countryCodeController,
                  scale: scale,
                  hint: '+33',
                  readOnly: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(width: 8 * scale),
              Expanded(
                flex: 7,
                child: _TextField(
                  controller: controller.phoneController,
                  scale: scale,
                  hint: '6 12 34 56 78',
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => controller.touchedFields.add('phone'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Date de naissance'),
          SizedBox(height: 8 * scale),
          GestureDetector(
            onTap: () => controller.pickDate(context),
            child: Obx(
              () => _InputShell(
                scale: scale,
                child: Row(
                  children: [
                    Icon(Icons.cake_outlined, color: const Color(0xFF6366F1), size: 20 * scale),
                    SizedBox(width: 12 * scale),
                    Text(
                      controller.formattedDate,
                      style: GoogleFonts.inter(
                        color: controller.selectedDate.value == null ? const Color(0xFF9CA3AF) : const Color(0xFF111827),
                        fontSize: 15 * scale,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_today_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Sexe', required: true),
          SizedBox(height: 8 * scale),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedGender.value,
              items: controller.genders
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender, style: GoogleFonts.inter(fontSize: 15 * scale, color: const Color(0xFF111827))),
                    ),
                  )
                  .toList(),
              onChanged: controller.onGenderChanged,
              decoration: _inputDecoration(scale),
              icon: Icon(Icons.expand_more_rounded, size: 20 * scale, color: const Color(0xFF94A3B8)),
            ),
          ),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Ville de résidence'),
          SizedBox(height: 8 * scale),
          _CityAutocomplete(scale: scale),
          SizedBox(height: 16 * scale),
          _FormFieldLabel(scale: scale, label: 'Fuseau horaire'),
          SizedBox(height: 8 * scale),
          Obx(
            () => GestureDetector(
              onTap: controller.onTimezoneTapped,
              child: _InputShell(
                scale: scale,
                child: Row(
                  children: [
                    Icon(Icons.public_rounded, color: const Color(0xFF2563EB), size: 20 * scale),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        controller.timezone.value,
                        style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 15 * scale),
                      ),
                    ),
                    Icon(Icons.auto_mode_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20 * scale),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('*', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale)),
              SizedBox(width: 6 * scale),
              Expanded(
                child: Text(
                  'Les champs marqués sont obligatoires',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12 * scale),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CityAutocomplete extends GetView<ProfileInfoController> {
  const _CityAutocomplete({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controller.cityController.text),
      displayStringForOption: (option) => option,
      optionsBuilder: (TextEditingValue value) => controller.getCitySuggestions(value.text),
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        textEditingController.selection = controller.cityController.selection;
        textEditingController.value = textEditingController.value.copyWith(
          text: textEditingController.text,
          selection: TextSelection.collapsed(offset: textEditingController.text.length),
        );
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (value) {
            controller.cityController.text = value;
            controller.cityController.selection = TextSelection.collapsed(offset: value.length);
            controller.touchedFields.add('city');
          },
          decoration: _inputDecoration(scale).copyWith(
            prefixIcon: Icon(Icons.location_on_outlined, color: const Color(0xFF6366F1), size: 20 * scale),
          ),
          textInputAction: TextInputAction.next,
        );
      },
      onSelected: (value) => controller.onCitySelected(value),
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(14 * scale),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320 * scale),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8 * scale),
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => Divider(height: 1, color: const Color(0xFFE2E8F0)),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    dense: true,
                    title: Text(option, style: GoogleFonts.inter(color: const Color(0xFF111827))),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FormFieldLabel extends StatelessWidget {
  const _FormFieldLabel({required this.scale, required this.label, this.required = false, this.helper});

  final double scale;
  final String label;
  final bool required;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: const Color(0xFF1F2937), fontSize: 14 * scale, fontWeight: FontWeight.w600),
        ),
        if (required) ...[
          SizedBox(width: 4 * scale),
          Text('*', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 13 * scale)),
        ],
        if (helper != null) ...[
          SizedBox(width: 8 * scale),
          Text(helper!, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
        ],
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.scale,
    this.hint,
    this.textInputAction,
    this.keyboardType,
    this.readOnly = false,
    this.fillColor = Colors.white,
    this.onChanged,
  });

  final TextEditingController controller;
  final double scale;
  final String? hint;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Color fillColor;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: _inputDecoration(scale).copyWith(
        hintText: hint,
        fillColor: fillColor,
      ),
    );
  }
}

class _InputShell extends StatelessWidget {
  const _InputShell({required this.scale, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}

InputDecoration _inputDecoration(double scale) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 14 * scale),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12 * scale),
      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12 * scale),
      borderSide: const BorderSide(color: Color(0xFF2563EB)),
    ),
    hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 15 * scale),
  );
}

class _SuccessBanner extends GetView<ProfileInfoController> {
  const _SuccessBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
        left: 16 * scale,
        right: 16 * scale,
        top: controller.showSuccessBanner.value ? MediaQuery.of(context).padding.top + 12 * scale : -120 * scale,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              borderRadius: BorderRadius.circular(16 * scale),
              boxShadow: [
                BoxShadow(color: const Color(0x3F22C55E), blurRadius: 24 * scale, offset: Offset(0, 12 * scale)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.check_rounded, color: Colors.white, size: 22 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profil mis à jour', style: GoogleFonts.inter(color: Colors.white, fontSize: 14.5 * scale, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4 * scale),
                      Text(
                        'Vos informations ont été enregistrées avec succès.',
                        style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 12.5 * scale),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomActions extends GetView<ProfileInfoController> {
  const _BottomActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 12 * scale + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 16 * scale, offset: Offset(0, -8 * scale)),
          ],
        ),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.cancel,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: Text('Annuler', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.isSaving.value ? null : controller.saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF2563EB)]),
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      child: controller.isSaving.value
                          ? SizedBox(
                              width: 18 * scale,
                              height: 18 * scale,
                              child: const CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Text(
                              'Enregistrer',
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w700),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

