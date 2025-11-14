import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernBirthDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Locale locale;

  const ModernBirthDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.locale = const Locale('fr', 'FR'),
  });

  @override
  State<ModernBirthDatePicker> createState() => _ModernBirthDatePickerState();
}

class _ModernBirthDatePickerState extends State<ModernBirthDatePicker> {
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

  Future<void> _showMonthYearPicker() async {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final selectedMonth = _displayedMonth.month;
    final selectedYear = _displayedMonth.year;
    
    int? pickedMonth;
    int? pickedYear;
    
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Sélectionner',
                          style: GoogleFonts.poppins(
                            fontSize: 22 * scale,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0B1220),
                            letterSpacing: -0.5,
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
                  
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Year selector
                        Padding(
                          padding: EdgeInsets.only(bottom: 4 * scale),
                          child: Text(
                            'Année',
                            style: GoogleFonts.poppins(
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        Container(
                          height: 160 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16 * scale),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 4 * scale),
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              final year = DateTime.now().year - index;
                              final isSelected = year == (pickedYear ?? selectedYear);
                              
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setDialogState(() {
                                      pickedYear = year;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(8 * scale),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 2 * scale),
                                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF176BFF) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8 * scale),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$year',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15 * scale,
                                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                            color: isSelected ? Colors.white : const Color(0xFF0B1220),
                                            letterSpacing: 0.1,
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          const Spacer(),
                                          Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 18 * scale,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        
                        SizedBox(height: 24 * scale),
                        
                        // Month selector
                        Padding(
                          padding: EdgeInsets.only(bottom: 4 * scale),
                          child: Text(
                            'Mois',
                            style: GoogleFonts.poppins(
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10 * scale,
                            crossAxisSpacing: 10 * scale,
                            childAspectRatio: 2.8,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            final month = index + 1;
                            final isSelected = month == (pickedMonth ?? selectedMonth);
                            
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setDialogState(() {
                                    pickedMonth = month;
                                  });
                                },
                                borderRadius: BorderRadius.circular(12 * scale),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF176BFF) : Colors.white,
                                    borderRadius: BorderRadius.circular(12 * scale),
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0),
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF176BFF).withValues(alpha: 0.25),
                                              blurRadius: 8 * scale,
                                              offset: Offset(0, 4 * scale),
                                            ),
                                          ]
                                        : [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.03),
                                              blurRadius: 2 * scale,
                                              offset: Offset(0, 1 * scale),
                                            ),
                                          ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getMonthName(month).substring(0, 3).toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 13 * scale,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                        color: isSelected ? Colors.white : const Color(0xFF0B1220),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8 * scale),
                      ],
                    ),
                  ),
                ),
                  
                // Action buttons
                Container(
                  padding: EdgeInsets.fromLTRB(20 * scale, 16 * scale, 20 * scale, 24 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14 * scale),
                              side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14 * scale),
                              ),
                            ),
                            child: Text(
                              'Annuler',
                              style: GoogleFonts.poppins(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              final month = pickedMonth ?? selectedMonth;
                              final year = pickedYear ?? selectedYear;
                              setState(() {
                                _displayedMonth = DateTime(year, month);
                                if (_selectedDate.year == year && _selectedDate.month == month) {
                                  // Date is still valid
                                } else {
                                  _selectedDate = DateTime(year, month, 1);
                                }
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14 * scale),
                              backgroundColor: const Color(0xFF176BFF),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14 * scale),
                              ),
                            ),
                            child: Text(
                              'Confirmer',
                              style: GoogleFonts.poppins(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  String _getMonthName(int month) {
    const months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return months[month - 1];
  }

  String _getShortDayName(int weekday) {
    const days = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    return days[weekday - 1];
  }

  String _getFullDayName(DateTime date) {
    const days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return days[date.weekday - 1];
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday;
    
    final days = <DateTime>[];
    
    // Add days from previous month
    final daysFromPreviousMonth = firstDayWeekday - 1;
    for (int i = daysFromPreviousMonth - 1; i >= 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i + 1)));
    }
    
    // Add days from current month
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month, i));
    }
    
    // Add days from next month to fill the grid
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }
    
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final days = _getDaysInMonth();
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final lastDateOnly = DateTime(widget.lastDate.year, widget.lastDate.month, widget.lastDate.day);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 40 * scale),
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 40 * scale,
              offset: Offset(0, 20 * scale),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with selected date
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 20 * scale),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getFullDayName(_selectedDate),
                          style: GoogleFonts.poppins(
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.9),
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                          style: GoogleFonts.poppins(
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 22 * scale,
                    ),
                  ),
                ],
              ),
            ),
            
            // Month selector
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 24 * scale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: IconButton(
                      onPressed: _previousMonth,
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 24 * scale,
                        color: const Color(0xFF0B1220),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showMonthYearPicker,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}',
                            style: GoogleFonts.poppins(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0B1220),
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(width: 8 * scale),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20 * scale,
                            color: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 44 * scale,
                    height: 44 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: IconButton(
                      onPressed: _nextMonth,
                      icon: Icon(
                        Icons.chevron_right_rounded,
                        size: 24 * scale,
                        color: const Color(0xFF0B1220),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            
            // Calendar grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
              child: Column(
                children: [
                  // Day headers
                  Row(
                    children: List.generate(7, (index) {
                      return Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8 * scale),
                            child: Text(
                              _getShortDayName(index + 1),
                              style: GoogleFonts.inter(
                                fontSize: 13 * scale,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  // Calendar days
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 4 * scale,
                      crossAxisSpacing: 4 * scale,
                    ),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final date = days[index];
                      final dateOnly = DateTime(date.year, date.month, date.day);
                      final isCurrentMonthDay = date.month == _displayedMonth.month;
                      final isSelected = date.year == _selectedDate.year &&
                          date.month == _selectedDate.month &&
                          date.day == _selectedDate.day;
                      final isToday = date.year == todayOnly.year &&
                          date.month == todayOnly.month &&
                          date.day == todayOnly.day;
                      final isSelectable = isCurrentMonthDay && 
                          (dateOnly.isBefore(lastDateOnly) || dateOnly.isAtSameMomentAs(lastDateOnly));

                      return GestureDetector(
                        onTap: isSelectable
                            ? () {
                                _selectDate(date);
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.all(2 * scale),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF176BFF)
                                : isToday && isCurrentMonthDay
                                    ? const Color(0xFF176BFF).withValues(alpha: 0.1)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(12 * scale),
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
                                    : !isCurrentMonthDay || !isSelectable
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
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: GoogleFonts.poppins(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_selectedDate),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        backgroundColor: const Color(0xFF176BFF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                      ),
                      child: Text(
                        'Confirmer',
                        style: GoogleFonts.poppins(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
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

