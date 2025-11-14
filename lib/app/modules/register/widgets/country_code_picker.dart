import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryCode {
  final String code;
  final String flag;
  final String name;
  final String dialCode;

  const CountryCode({
    required this.code,
    required this.flag,
    required this.name,
    required this.dialCode,
  });
}

class CountryCodePicker extends StatelessWidget {
  final String selectedCode;
  final String selectedFlag;
  final Function(String code, String flag, String name) onCountrySelected;
  final double scale;

  const CountryCodePicker({
    super.key,
    required this.selectedCode,
    required this.selectedFlag,
    required this.onCountrySelected,
    required this.scale,
  });

  static const List<CountryCode> countries = [
    CountryCode(code: 'FR', flag: '🇫🇷', name: 'France', dialCode: '+33'),
    CountryCode(code: 'BE', flag: '🇧🇪', name: 'Belgique', dialCode: '+32'),
    CountryCode(code: 'CH', flag: '🇨🇭', name: 'Suisse', dialCode: '+41'),
    CountryCode(code: 'LU', flag: '🇱🇺', name: 'Luxembourg', dialCode: '+352'),
    CountryCode(code: 'MC', flag: '🇲🇨', name: 'Monaco', dialCode: '+377'),
    CountryCode(code: 'CA', flag: '🇨🇦', name: 'Canada', dialCode: '+1'),
    CountryCode(code: 'US', flag: '🇺🇸', name: 'États-Unis', dialCode: '+1'),
    CountryCode(code: 'GB', flag: '🇬🇧', name: 'Royaume-Uni', dialCode: '+44'),
    CountryCode(code: 'IE', flag: '🇮🇪', name: 'Irlande', dialCode: '+353'),
    CountryCode(code: 'DE', flag: '🇩🇪', name: 'Allemagne', dialCode: '+49'),
    CountryCode(code: 'AT', flag: '🇦🇹', name: 'Autriche', dialCode: '+43'),
    CountryCode(code: 'ES', flag: '🇪🇸', name: 'Espagne', dialCode: '+34'),
    CountryCode(code: 'IT', flag: '🇮🇹', name: 'Italie', dialCode: '+39'),
    CountryCode(code: 'PT', flag: '🇵🇹', name: 'Portugal', dialCode: '+351'),
    CountryCode(code: 'NL', flag: '🇳🇱', name: 'Pays-Bas', dialCode: '+31'),
    CountryCode(code: 'GR', flag: '🇬🇷', name: 'Grèce', dialCode: '+30'),
    CountryCode(code: 'PL', flag: '🇵🇱', name: 'Pologne', dialCode: '+48'),
    CountryCode(code: 'CZ', flag: '🇨🇿', name: 'République tchèque', dialCode: '+420'),
    CountryCode(code: 'SE', flag: '🇸🇪', name: 'Suède', dialCode: '+46'),
    CountryCode(code: 'NO', flag: '🇳🇴', name: 'Norvège', dialCode: '+47'),
    CountryCode(code: 'DK', flag: '🇩🇰', name: 'Danemark', dialCode: '+45'),
    CountryCode(code: 'FI', flag: '🇫🇮', name: 'Finlande', dialCode: '+358'),
    CountryCode(code: 'MA', flag: '🇲🇦', name: 'Maroc', dialCode: '+212'),
    CountryCode(code: 'DZ', flag: '🇩🇿', name: 'Algérie', dialCode: '+213'),
    CountryCode(code: 'TN', flag: '🇹🇳', name: 'Tunisie', dialCode: '+216'),
    CountryCode(code: 'SN', flag: '🇸🇳', name: 'Sénégal', dialCode: '+221'),
    CountryCode(code: 'CI', flag: '🇨🇮', name: 'Côte d\'Ivoire', dialCode: '+225'),
    CountryCode(code: 'CM', flag: '🇨🇲', name: 'Cameroun', dialCode: '+237'),
    CountryCode(code: 'EG', flag: '🇪🇬', name: 'Égypte', dialCode: '+20'),
    CountryCode(code: 'ZA', flag: '🇿🇦', name: 'Afrique du Sud', dialCode: '+27'),
    CountryCode(code: 'AU', flag: '🇦🇺', name: 'Australie', dialCode: '+61'),
    CountryCode(code: 'NZ', flag: '🇳🇿', name: 'Nouvelle-Zélande', dialCode: '+64'),
    CountryCode(code: 'BR', flag: '🇧🇷', name: 'Brésil', dialCode: '+55'),
    CountryCode(code: 'MX', flag: '🇲🇽', name: 'Mexique', dialCode: '+52'),
    CountryCode(code: 'AR', flag: '🇦🇷', name: 'Argentine', dialCode: '+54'),
    CountryCode(code: 'JP', flag: '🇯🇵', name: 'Japon', dialCode: '+81'),
    CountryCode(code: 'KR', flag: '🇰🇷', name: 'Corée du Sud', dialCode: '+82'),
    CountryCode(code: 'CN', flag: '🇨🇳', name: 'Chine', dialCode: '+86'),
    CountryCode(code: 'IN', flag: '🇮🇳', name: 'Inde', dialCode: '+91'),
    CountryCode(code: 'AE', flag: '🇦🇪', name: 'Émirats arabes unis', dialCode: '+971'),
    CountryCode(code: 'SA', flag: '🇸🇦', name: 'Arabie saoudite', dialCode: '+966'),
    CountryCode(code: 'TR', flag: '🇹🇷', name: 'Turquie', dialCode: '+90'),
    CountryCode(code: 'RU', flag: '🇷🇺', name: 'Russie', dialCode: '+7'),
  ];

  @override
  Widget build(BuildContext context) {
    // Find the country by dialCode (since selectedCode is actually the dialCode)
    final country = countries.firstWhere(
      (c) => c.dialCode == selectedCode || c.code == selectedCode,
      orElse: () => countries.first,
    );
    
    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      child: Container(
        height: 60 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12 * scale),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(country.flag, style: TextStyle(fontSize: 20 * scale)),
            SizedBox(width: 6 * scale),
            Flexible(
              child: Text(
                country.dialCode,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0B1220),
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4 * scale),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18 * scale, color: const Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12 * scale, bottom: 8 * scale),
              width: 40 * scale,
              height: 4 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2 * scale),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sélectionner un pays',
                      style: GoogleFonts.poppins(
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1220),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: const Color(0xFF64748B),
                        size: 20 * scale,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Countries list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final isSelected = country.dialCode == selectedCode || country.code == selectedCode;
                  
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        onCountrySelected(country.dialCode, country.flag, country.name);
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                        margin: EdgeInsets.only(bottom: 4 * scale),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF176BFF).withValues(alpha: 0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: isSelected
                              ? Border.all(color: const Color(0xFF176BFF), width: 2)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Text(country.flag, style: TextStyle(fontSize: 24 * scale)),
                            SizedBox(width: 12 * scale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15 * scale,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      color: isSelected ? const Color(0xFF176BFF) : const Color(0xFF0B1220),
                                    letterSpacing: 0.1,
                                    ),
                                  ),
                                  SizedBox(height: 2 * scale),
                                  Text(
                                    country.dialCode,
                                    style: GoogleFonts.inter(
                                      fontSize: 13 * scale,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: const Color(0xFF176BFF),
                                size: 22 * scale,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20 * scale),
          ],
        ),
      ),
    );
  }
}

