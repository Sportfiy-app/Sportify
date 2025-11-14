import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;

  const ModernTimePicker({
    super.key,
    required this.initialTime,
  });

  @override
  State<ModernTimePicker> createState() => _ModernTimePickerState();
}

class _ModernTimePickerState extends State<ModernTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  bool _isSelectingHour = true;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
  }

  void _selectHour(int hour) {
    setState(() {
      _selectedHour = hour;
      _isSelectingHour = false;
    });
  }

  void _selectMinute(int minute) {
    setState(() {
      _selectedMinute = minute;
    });
  }

  List<int> _getHours() {
    return List.generate(24, (index) => index);
  }

  List<int> _getMinutes() {
    return List.generate(60, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final hours = _getHours();
    final minutes = _getMinutes();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20 * scale),
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 30 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24 * scale),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sélectionner une heure',
                    style: GoogleFonts.poppins(
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1220),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, size: 24 * scale, color: const Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24 * scale),
            // Time display
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24 * scale),
              padding: EdgeInsets.symmetric(vertical: 20 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFF),
                borderRadius: BorderRadius.circular(20 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isSelectingHour = true),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: _isSelectingHour
                            ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Text(
                        _selectedHour.toString().padLeft(2, '0'),
                        style: GoogleFonts.poppins(
                          fontSize: 36 * scale,
                          fontWeight: FontWeight.w700,
                          color: _isSelectingHour
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF0B1220),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' : ',
                    style: GoogleFonts.poppins(
                      fontSize: 36 * scale,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1220),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isSelectingHour = false),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: !_isSelectingHour
                            ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Text(
                        _selectedMinute.toString().padLeft(2, '0'),
                        style: GoogleFonts.poppins(
                          fontSize: 36 * scale,
                          fontWeight: FontWeight.w700,
                          color: !_isSelectingHour
                              ? const Color(0xFF176BFF)
                              : const Color(0xFF0B1220),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24 * scale),
            // Time picker wheel
            Expanded(
              child: _isSelectingHour
                  ? _buildHourPicker(hours, scale)
                  : _buildMinutePicker(minutes, scale),
            ),
            SizedBox(height: 24 * scale),
            // Action buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: GoogleFonts.inter(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(
                        TimeOfDay(hour: _selectedHour, minute: _selectedMinute),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'OK',
                        style: GoogleFonts.inter(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildHourPicker(List<int> hours, double scale) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 60 * scale,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) => _selectHour(hours[index]),
      controller: FixedExtentScrollController(initialItem: _selectedHour),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final hour = hours[index];
          final isSelected = hour == _selectedHour;
          
          return Container(
            alignment: Alignment.center,
            child: Text(
              hour.toString().padLeft(2, '0'),
              style: GoogleFonts.poppins(
                fontSize: isSelected ? 28 * scale : 20 * scale,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF176BFF)
                    : const Color(0xFF64748B),
              ),
            ),
          );
        },
        childCount: hours.length,
      ),
    );
  }

  Widget _buildMinutePicker(List<int> minutes, double scale) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 60 * scale,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) => _selectMinute(minutes[index]),
      controller: FixedExtentScrollController(initialItem: _selectedMinute),
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          final minute = minutes[index];
          final isSelected = minute == _selectedMinute;
          
          return Container(
            alignment: Alignment.center,
            child: Text(
              minute.toString().padLeft(2, '0'),
              style: GoogleFonts.poppins(
                fontSize: isSelected ? 28 * scale : 20 * scale,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF176BFF)
                    : const Color(0xFF64748B),
              ),
            ),
          );
        },
        childCount: minutes.length,
      ),
    );
  }
}

