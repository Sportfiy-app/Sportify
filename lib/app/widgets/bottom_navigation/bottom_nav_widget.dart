import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottom_nav_controller.dart';

class BottomNavWidget extends GetView<BottomNavController> {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16 * scale),
            topRight: Radius.circular(16 * scale),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12 * scale,
              offset: Offset(0, -2 * scale),
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 12 * scale,
          top: 6 * scale,
          right: 12 * scale,
          bottom: (6 * scale) + (bottomInset > 0 ? bottomInset * 0.5 : 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              scale: scale,
              icon: Icons.home_filled,
              activeIcon: Icons.home_filled,
              label: 'À la une',
              tab: BottomNavTab.home,
              isActive: controller.currentTab.value == BottomNavTab.home,
              onTap: () => controller.changeTab(BottomNavTab.home),
            ),
            _NavItem(
              scale: scale,
              icon: Icons.search_rounded,
              activeIcon: Icons.search_rounded,
              label: 'Trouver',
              tab: BottomNavTab.find,
              isActive: controller.currentTab.value == BottomNavTab.find,
              onTap: () => controller.changeTab(BottomNavTab.find),
            ),
            _NavItem(
              scale: scale,
              icon: Icons.calendar_month_outlined,
              activeIcon: Icons.calendar_month_rounded,
              label: 'Réserver',
              tab: BottomNavTab.booking,
              isActive: controller.currentTab.value == BottomNavTab.booking,
              onTap: () => controller.changeTab(BottomNavTab.booking),
            ),
            _NavItem(
              scale: scale,
              icon: Icons.chat_bubble_outline_rounded,
              activeIcon: Icons.chat_bubble_rounded,
              label: 'Messages',
              tab: BottomNavTab.messages,
              isActive: controller.currentTab.value == BottomNavTab.messages,
              onTap: () => controller.changeTab(BottomNavTab.messages),
            ),
            _NavItem(
              scale: scale,
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profil',
              tab: BottomNavTab.profile,
              isActive: controller.currentTab.value == BottomNavTab.profile,
              onTap: () => controller.changeTab(BottomNavTab.profile),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.scale,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final BottomNavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF176BFF) : const Color(0xFF64748B);
    
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12 * scale),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(horizontal: 2 * scale, vertical: 4 * scale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    isActive ? activeIcon : icon,
                    key: ValueKey('${isActive ? 'active' : 'inactive'}_$tab'),
                    color: color,
                    size: isActive ? 22 * scale : 20 * scale,
                  ),
                ),
                SizedBox(height: 3 * scale),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  style: GoogleFonts.inter(
                    color: color,
                    fontSize: 11 * scale,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    height: 1.0,
                    letterSpacing: -0.1,
                  ),
                  textAlign: TextAlign.center,
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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

