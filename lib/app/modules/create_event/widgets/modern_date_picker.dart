import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Locale locale;

  const ModernDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.locale = const Locale('fr', 'FR'),
  });

  @override
  State<ModernDatePicker> createState() => _ModernDatePickerState();
}

class _ModernDatePickerState extends State<ModernDatePicker> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  String _getMonthName(int month) {
    const months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return months[month - 1];
  }

  String _getFullDayName(DateTime date) {
    const days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return days[date.weekday - 1];
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDay = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final days = <DateTime>[];
    
    // Add days from previous month to fill the week
    final firstWeekday = firstDay.weekday;
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDay.subtract(Duration(days: i)));
    }
    
    // Add days of current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month, i));
    }
    
    // Add days from next month to fill the week
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month + 1, i));
    }
    
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final days = _getDaysInMonth();
    final today = DateTime.now();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20 * scale),
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sélectionner une date',
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
                  SizedBox(height: 20 * scale),
                  // Selected date display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFF176BFF).withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(
                        color: const Color(0xFF176BFF).withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_getFullDayName(_selectedDate).substring(0, 3)}. ${_selectedDate.day} ${_getMonthName(_selectedDate.month).substring(0, 3)}.',
                          style: GoogleFonts.poppins(
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF176BFF),
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Icon(Icons.edit_rounded, size: 18 * scale, color: const Color(0xFF176BFF)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Month selector
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 20 * scale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousMonth,
                    icon: Icon(Icons.chevron_left_rounded, size: 28 * scale, color: const Color(0xFF0B1220)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9),
                      padding: EdgeInsets.all(8 * scale),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Could show month/year picker here
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}',
                          style: GoogleFonts.poppins(
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1220),
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 20 * scale, color: const Color(0xFF64748B)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: Icon(Icons.chevron_right_rounded, size: 28 * scale, color: const Color(0xFF0B1220)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9),
                      padding: EdgeInsets.all(8 * scale),
                    ),
                  ),
                ],
              ),
            ),
            // Calendar grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale),
              child: Column(
                children: [
                  // Day headers
                  Row(
                    children: ['L', 'M', 'M', 'J', 'V', 'S', 'D'].map((day) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: GoogleFonts.inter(
                              fontSize: 13 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12 * scale),
                  // Calendar days
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8 * scale,
                      crossAxisSpacing: 8 * scale,
                    ),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final date = days[index];
                      final isCurrentMonthDay = date.month == _displayedMonth.month;
                      final isSelected = date.year == _selectedDate.year &&
                          date.month == _selectedDate.month &&
                          date.day == _selectedDate.day;
                      final isToday = date.year == today.year &&
                          date.month == today.month &&
                          date.day == today.day;
                      final isPast = date.isBefore(DateTime(today.year, today.month, today.day));

                      return GestureDetector(
                        onTap: isCurrentMonthDay && !isPast ? () => _selectDate(date) : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF176BFF)
                                : isToday && isCurrentMonthDay
                                    ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isToday && isCurrentMonthDay && !isSelected
                                ? Border.all(color: const Color(0xFF176BFF), width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : !isCurrentMonthDay || isPast
                                        ? const Color(0xFFCBD5E1)
                                        : const Color(0xFF0B1220),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
                      onPressed: () => Navigator.of(context).pop(_selectedDate),
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
}

