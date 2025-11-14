import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/bottom_navigation/bottom_nav_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final mediaQuery = MediaQuery.of(context);
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : mediaQuery.size.width;
          final scale = (width / designWidth).clamp(0.9, 1.15);
          final topInset = mediaQuery.padding.top;

          return SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => RefreshIndicator(
                      onRefresh: controller.fetchHome,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 24 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _HeaderSection(scale: scale, topInset: topInset),
                            if (controller.isLoading.value)
                              Padding(
                                padding: EdgeInsets.only(top: 8 * scale),
                                child: const LinearProgressIndicator(),
                              ),
                            if (controller.errorMessage.value != null)
                              Padding(
                                padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 12 * scale),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF1F2),
                                    borderRadius: BorderRadius.circular(12 * scale),
                                    border: Border.all(color: const Color(0xFFFECACA)),
                                  ),
                                  child: Text(
                                    controller.errorMessage.value!,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFB91C1C),
                                      fontSize: 13 * scale,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 12 * scale),
                            _StoriesSection(scale: scale),
                            SizedBox(height: 20 * scale),
                            _TabSwitcher(scale: scale, controller: controller),
                            SizedBox(height: 12 * scale),
                            _SportFilterBar(scale: scale),
                            SizedBox(height: 16 * scale),
                            _ShortcutRow(scale: scale),
                            SizedBox(height: 20 * scale),
                            Obx(
                              () {
                                final filteredPosts = controller.filteredFeedPosts;
                                if (filteredPosts.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.all(32 * scale),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.inbox_outlined,
                                          size: 64 * scale,
                                          color: const Color(0xFF94A3B8),
                                        ),
                                        SizedBox(height: 16 * scale),
                                        Text(
                                          'Aucune publication',
                                          style: GoogleFonts.inter(
                                            color: const Color(0xFF64748B),
                                            fontSize: 16 * scale,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8 * scale),
                                        Text(
                                          'Aucune publication disponible pour cette catégorie',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            color: const Color(0xFF94A3B8),
                                            fontSize: 14 * scale,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Column(
                                  children: filteredPosts
                                      .map(
                                        (post) => Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16 * scale)
                                              .copyWith(bottom: 16 * scale),
                                          child: _FeedCard(scale: scale, post: post),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _EventHighlightCard(scale: scale),
                            ),
                            SizedBox(height: 20 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _VenueRecommendationCard(scale: scale),
                            ),
                            SizedBox(height: 20 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _CommunityHighlightCard(scale: scale),
                            ),
                            SizedBox(height: 20 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _LoadMoreButton(scale: scale),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const BottomNavWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderSection extends GetView<HomeController> {
  const _HeaderSection({required this.scale, required this.topInset});

  final double scale;
  final double topInset;

  @override
  Widget build(BuildContext context) {
    final headerHeight = topInset + 120 * scale;
    return Container(
      height: headerHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment(0.35, 0.35),
          end: Alignment(1.06, -0.35),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16 * scale,
            left: 32 * scale,
            child: _FloatingDot(scale: scale, color: Colors.white.withValues(alpha: 0.15), size: 32 * scale),
          ),
          Positioned(
            top: 32 * scale,
            right: 52 * scale,
            child: _FloatingDot(scale: scale, color: const Color(0xFFFFB800).withValues(alpha: 0.4), size: 24 * scale),
          ),
          Positioned(
            bottom: 24 * scale,
            left: 56 * scale,
            child: _FloatingDot(scale: scale, color: Colors.white.withValues(alpha: 0.15), size: 32 * scale),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16 * scale, topInset + 12 * scale, 16 * scale, 12 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2 * scale),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white.withValues(alpha: 0.2),
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: Colors.white,
                                size: 20 * scale,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, Esam ! 👋',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18 * scale,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 2 * scale),
                          Text(
                            'Prête pour une session ?',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13 * scale,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _CircleIconButton(
                      scale: scale,
                      icon: Icons.notifications_none_rounded,
                      onTap: controller.onNotificationsTap,
                      showBadge: true,
                      badgeLabel: '3',
                    ),
                    SizedBox(width: 10 * scale),
                    _CircleIconButton(
                      scale: scale,
                      icon: Icons.chat_bubble_outline_rounded,
                      onTap: controller.onNewMessageTap,
                    ),
                  ],
                ),
                SizedBox(height: 10 * scale),
                GestureDetector(
                  onTap: controller.onSearchTap,
                  child: Container(
                    height: 44 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(14 * scale),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8 * scale,
                          offset: Offset(0, 2 * scale),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: const Color(0xFF64748B), size: 16 * scale),
                        SizedBox(width: 10 * scale),
                        Expanded(
                          child: Text(
                            'Partenaires ou salle de sport...',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF94A3B8),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6 * scale),
                          decoration: BoxDecoration(
                            color: const Color(0xFF176BFF),
                            borderRadius: BorderRadius.circular(8 * scale),
                          ),
                          child: Icon(Icons.tune_rounded, color: Colors.white, size: 16 * scale),
                        ),
                      ],
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

class _StoriesSection extends GetView<HomeController> {
  const _StoriesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final bubbleSize = 66 * scale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stories Sportives',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              TextButton(
                onPressed: () => Get.snackbar('Stories', 'Voir toutes les stories prochainement'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: const Color(0xFF176BFF),
                ),
                child: Text(
                  'Voir tout',
                  style: GoogleFonts.inter(
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16 * scale),
        SizedBox(
          height: bubbleSize + 32 * scale,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16 * scale),
            child: Row(
              children: controller.stories
                  .map(
                    (story) => Padding(
                      padding: EdgeInsets.only(right: 16 * scale),
                      child: _StoryBubble(scale: scale, story: story),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabSwitcher extends StatefulWidget {
  const _TabSwitcher({required this.scale, required this.controller});

  final double scale;
  final HomeController controller;

  @override
  State<_TabSwitcher> createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<_TabSwitcher> {
  final ScrollController _scrollController = ScrollController();
  final Map<HomeFeedTab, GlobalKey> _tabKeys = {};

  @override
  void initState() {
    super.initState();
    final tabs = const [
      HomeFeedTab.recommended,
      HomeFeedTab.friends,
      HomeFeedTab.nearby,
      HomeFeedTab.live,
    ];
    for (final tab in tabs) {
      _tabKeys[tab] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTab(HomeFeedTab tab) {
    final key = _tabKeys[tab];
    if (key?.currentContext != null && _scrollController.hasClients) {
      final RenderBox? renderBox = key?.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final screenWidth = MediaQuery.of(context).size.width;
        // Get the position of the tab relative to its parent (the Row)
        final position = renderBox.localToGlobal(Offset.zero);
        // Calculate the scroll position to center the tab
        final tabCenter = position.dx + (renderBox.size.width / 2);
        final screenCenter = screenWidth / 2;
        final targetOffset = _scrollController.offset + (tabCenter - screenCenter);
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      HomeFeedTab.recommended,
      HomeFeedTab.friends,
      HomeFeedTab.nearby,
      HomeFeedTab.live,
    ];

    final tabLabels = {
      HomeFeedTab.recommended: 'Recommandés',
      HomeFeedTab.friends: 'Entre amis',
      HomeFeedTab.nearby: 'Proximité',
      HomeFeedTab.live: 'En direct',
    };

    return Obx(
      () {
        // Auto-scroll to active tab when it changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToTab(widget.controller.currentTab.value);
        });

        return SizedBox(
          height: 40 * widget.scale,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16 * widget.scale),
            child: Row(
              children: tabs
                  .asMap()
                  .entries
                  .map(
                    (entry) {
                      final index = entry.key;
                      final tab = entry.value;
                      final isActive = widget.controller.currentTab.value == tab;

                      return Padding(
                        key: _tabKeys[tab],
                        padding: EdgeInsets.only(
                          right: index == tabs.length - 1 ? 0 : 12 * widget.scale,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.controller.changeTab(tab);
                              Future.delayed(const Duration(milliseconds: 100), () {
                                _scrollToTab(tab);
                              });
                            },
                            borderRadius: BorderRadius.circular(12 * widget.scale),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16 * widget.scale,
                                vertical: 8 * widget.scale,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFF176BFF)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12 * widget.scale),
                              ),
                              alignment: Alignment.center,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOutCubic,
                                style: GoogleFonts.inter(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                  fontSize: 13 * widget.scale,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  height: 1.2,
                                  letterSpacing: -0.1,
                                ),
                                child: Text(
                                  tabLabels[tab]!,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

class _SportFilterBar extends GetView<HomeController> {
  const _SportFilterBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () {
                final selectedSport = controller.sportFilter.value;
                final sportIcon = controller.getSportIcon(selectedSport);
                final sportColor = controller.getSportColor(selectedSport);
                final isAllSports = selectedSport == 'Tous les sports';
                
                return GestureDetector(
                  onTap: () => _showSportFilterSheet(context),
                  child: Container(
                    height: 40 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14 * scale),
                      border: Border.all(
                        color: isAllSports 
                            ? const Color(0xFFE2E8F0) 
                            : sportColor.withValues(alpha: 0.3),
                        width: isAllSports ? 1 : 1.5,
                      ),
                      color: Colors.white,
                      boxShadow: isAllSports
                          ? []
                          : [
                              BoxShadow(
                                color: sportColor.withValues(alpha: 0.1),
                                blurRadius: 8 * scale,
                                offset: Offset(0, 2 * scale),
                              ),
                            ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                    child: Row(
                      children: [
                        Container(
                          width: 28 * scale,
                          height: 28 * scale,
                          decoration: BoxDecoration(
                            color: isAllSports
                                ? sportColor.withValues(alpha: 0.1)
                                : sportColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8 * scale),
                          ),
                          child: Icon(
                            sportIcon,
                            size: 16 * scale,
                            color: sportColor,
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Text(
                            selectedSport,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0B1220),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.expand_more_rounded,
                          size: 20 * scale,
                          color: const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12 * scale),
          GestureDetector(
            onTap: controller.onCreateEventTap,
            child: Container(
              height: 40 * scale,
              width: 40 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                gradient: const LinearGradient(
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF176BFF).withValues(alpha: 0.3),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(Icons.add_rounded, color: Colors.white, size: 20 * scale),
            ),
          ),
        ],
      ),
    );
  }

  void _showSportFilterSheet(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;
    final maxHeight = MediaQuery.of(context).size.height * 0.7;
    
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24 * scale),
          ),
        ),
        child: SafeArea(
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
              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                child: Row(
                  children: [
                    Text(
                      'Filtrer par sport',
                      style: GoogleFonts.poppins(
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1220),
                      ),
                    ),
                  ],
                ),
              ),
              // Sport options
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                  itemCount: controller.availableSportFilters.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8 * scale),
                  itemBuilder: (context, index) {
                    final sport = controller.availableSportFilters[index];
                    // Use Obx for each item to track sportFilter changes
                    return Obx(
                      () {
                        final isSelected = controller.sportFilter.value == sport;
                        final sportIcon = controller.getSportIcon(sport);
                        final sportColor = controller.getSportColor(sport);
                      
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.selectSportFilter(sport);
                              Navigator.of(ctx).pop();
                            },
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16 * scale,
                                vertical: 14 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? sportColor.withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12 * scale),
                                border: isSelected
                                    ? Border.all(
                                        color: sportColor.withValues(alpha: 0.3),
                                        width: 1.5,
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40 * scale,
                                    height: 40 * scale,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? sportColor.withValues(alpha: 0.15)
                                          : sportColor.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(10 * scale),
                                    ),
                                    child: Icon(
                                      sportIcon,
                                      size: 20 * scale,
                                      color: sportColor,
                                    ),
                                  ),
                                  SizedBox(width: 16 * scale),
                                  Expanded(
                                    child: Text(
                                      sport,
                                      style: GoogleFonts.inter(
                                        fontSize: 16 * scale,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: const Color(0xFF0B1220),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 24 * scale,
                                      height: 24 * scale,
                                      decoration: BoxDecoration(
                                        color: sportColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check_rounded,
                                        size: 16 * scale,
                                        color: Colors.white,
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
              ),
              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShortcutRow extends GetView<HomeController> {
  const _ShortcutRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.shortcuts
            .map(
              (shortcut) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: shortcut == controller.shortcuts.last ? 0 : 12 * scale),
                  child: _ShortcutCard(scale: scale, shortcut: shortcut),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FeedCard extends GetView<HomeController> {
  const _FeedCard({required this.scale, required this.post});

  final double scale;
  final HomeFeedPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8 * scale,
            offset: Offset(0, 4 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  post.avatarUrl,
                  width: 42 * scale,
                  height: 42 * scale,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 42 * scale,
                      height: 42 * scale,
                      color: const Color(0xFFE2E8F0),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: const Color(0xFF94A3B8),
                        size: 24 * scale,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.author,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 15 * scale,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 3 * scale),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF64748B),
                                    fontSize: 11 * scale,
                                    height: 1.4,
                                  ),
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(Icons.place_outlined, size: 14, color: Color(0xFF475569)),
                                    ),
                                    TextSpan(text: ' ${post.location} • ${post.distance}\n'),
                                    TextSpan(text: post.timeAgo),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
                          decoration: BoxDecoration(
                            color: post.sportColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            post.sportLabel,
                            style: GoogleFonts.inter(
                              color: post.sportColor,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(
            post.message,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 14 * scale,
              height: 1.5,
              letterSpacing: -0.1,
            ),
          ),
          if (post.imageUrl != null) ...[
            SizedBox(height: 12 * scale),
            ClipRRect(
              borderRadius: BorderRadius.circular(12 * scale),
              child: AspectRatio(
                aspectRatio: 327 / 192,
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF1F5F9),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: const Color(0xFF94A3B8),
                        size: 40 * scale,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFFF1F5F9),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2 * scale,
                          color: const Color(0xFF176BFF),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          SizedBox(height: 14 * scale),
          Row(
            children: [
              _StatPill(scale: scale, icon: Icons.favorite_border_rounded, value: post.stats.likes.toString()),
              SizedBox(width: 10 * scale),
              _StatPill(scale: scale, icon: Icons.mode_comment_outlined, value: post.stats.comments.toString()),
              SizedBox(width: 10 * scale),
              _StatPill(scale: scale, icon: Icons.share_outlined, value: post.stats.shares.toString()),
              SizedBox(width: 10 * scale),
              _StatPill(scale: scale, icon: Icons.people_outline_rounded, value: post.stats.participants.toString()),
            ],
          ),
          if (post.hasDirectMessageCta) ...[
            SizedBox(height: 12 * scale),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => controller.onFeedPostAction(post),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF176BFF),
                  side: const BorderSide(color: Color(0xFF176BFF)),
                  padding: EdgeInsets.symmetric(vertical: 12 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message_outlined, size: 18 * scale),
                    SizedBox(width: 8 * scale),
                    Text(
                      'Message',
                      style: GoogleFonts.inter(
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EventHighlightCard extends GetView<HomeController> {
  const _EventHighlightCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final event = controller.upcomingEvent;
    
    // Don't show card if no event
    if (event == null) {
      return const SizedBox.shrink();
    }
    
    return GestureDetector(
      onTap: () {
        if (event.id != null && event.id!.isNotEmpty) {
          Get.toNamed('/event/detail', arguments: event.id);
        } else {
          Get.snackbar(
            'Information',
            'ID d\'événement non disponible',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x33176BFF),
              blurRadius: 20 * scale,
              offset: Offset(0, 16 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48 * scale,
                height: 48 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(Icons.emoji_events_rounded, color: Colors.white, size: 24 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Événement à venir',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 3 * scale),
                    Text(
                      'Organisé par ${event.organizer}',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12 * scale,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB800),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  event.badge,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            event.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16 * scale,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            event.subtitle,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13 * scale,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              _EventStatPill(
                scale: scale,
                icon: Icons.people_alt_outlined,
                label: event.capacityLabel,
              ),
              SizedBox(width: 12 * scale),
              _EventStatPill(
                scale: scale,
                icon: Icons.euro_symbol_rounded,
                label: event.priceLabel,
              ),
              SizedBox(width: 12 * scale),
              Flexible(
                child: OutlinedButton(
                  onPressed: () {
                    if (event.id != null && event.id!.isNotEmpty) {
                      Get.toNamed('/event/detail', arguments: event.id);
                    } else {
                      Get.snackbar(
                        'Information',
                        'ID d\'événement non disponible',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                    padding: EdgeInsets.symmetric(vertical: 10 * scale),
                  ),
                  child: Text(
                    "S'inscrire",
                    style: GoogleFonts.inter(
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

class _VenueRecommendationCard extends GetView<HomeController> {
  const _VenueRecommendationCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final venue = controller.venueHighlight;
    
    // Don't show card if no venue
    if (venue == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x3316A34A), width: 3 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10 * scale,
            offset: Offset(0, 6 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12 * scale),
            child: Image.network(
              venue.imageUrl,
              width: 56 * scale,
              height: 56 * scale,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 56 * scale,
                  height: 56 * scale,
                  color: const Color(0xFFE2E8F0),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: const Color(0xFF94A3B8),
                    size: 28 * scale,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue.name,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Row(
                  children: [
                    Icon(Icons.star_rate_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(
                      venue.rating,
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                    ),
                    SizedBox(width: 12 * scale),
                    Text('•', style: GoogleFonts.inter(color: const Color(0xFF475569))),
                    SizedBox(width: 12 * scale),
                    Icon(Icons.location_on_outlined, color: const Color(0xFF475569), size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(venue.distance, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                    SizedBox(width: 12 * scale),
                    Text('•', style: GoogleFonts.inter(color: const Color(0xFF475569))),
                    SizedBox(width: 12 * scale),
                    Text(venue.price, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ),
                SizedBox(height: 16 * scale),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: controller.onVenueAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                      ),
                      child:                       Text(
                        'Réserver',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(width: 10 * scale),
                    OutlinedButton(
                      onPressed: controller.onVenueAction,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        foregroundColor: const Color(0xFF64748B),
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                      ),
                      child: Text(
                        'Voir plus',
                        style: GoogleFonts.inter(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityHighlightCard extends GetView<HomeController> {
  const _CommunityHighlightCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final community = controller.communityHighlight;
    
    // Don't show card if no community data
    if (community == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44 * scale,
                height: 44 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(Icons.groups_3_rounded, color: Colors.white, size: 22 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 3 * scale),
                    Text(
                      community.subtitle,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12 * scale,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            community.headline,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16 * scale,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            community.message,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13 * scale,
              height: 1.5,
            ),
          ),
          SizedBox(height: 14 * scale),
          Row(
            children: [
              _CommunityStatChip(
                scale: scale,
                icon: Icons.people_alt_outlined,
                label: community.membersLabel,
              ),
              SizedBox(width: 12 * scale),
              _CommunityStatChip(
                scale: scale,
                icon: Icons.sports_soccer_rounded,
                label: community.matchesLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoadMoreButton extends GetView<HomeController> {
  const _LoadMoreButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: controller.onLoadMore,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF176BFF), width: 2),
        foregroundColor: const Color(0xFF176BFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
        padding: EdgeInsets.symmetric(vertical: 14 * scale),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh_rounded, size: 16 * scale),
          SizedBox(width: 8 * scale),
          Text(
            'Charger plus de publications',
            style: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingDot extends StatelessWidget {
  const _FloatingDot({required this.scale, required this.color, required this.size});

  final double scale;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.2 * scale),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.scale,
    required this.icon,
    required this.onTap,
    this.showBadge = false,
    this.badgeLabel,
  });

  final double scale;
  final IconData icon;
  final VoidCallback onTap;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Icon(icon, color: Colors.white, size: 20 * scale),
          ),
          if (showBadge)
            Positioned(
              right: -4 * scale,
              top: -4 * scale,
              child: Container(
                width: 20 * scale,
                height: 20 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  badgeLabel ?? '',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StoryBubble extends GetView<HomeController> {
  const _StoryBubble({required this.scale, required this.story});

  final double scale;
  final HomeStory story;

  @override
  Widget build(BuildContext context) {
    if (story.isAddButton) {
      final bubbleSize = 56 * scale;
      return Column(
        children: [
          Container(
            width: bubbleSize,
            height: bubbleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF475569), width: 2 * scale),
              color: Colors.white,
            ),
            child: Icon(Icons.add_rounded, color: const Color(0xFF64748B), size: 24 * scale),
          ),
          SizedBox(height: 6 * scale),
          Text(
            'Ajouter',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 11 * scale,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      );
    }

    final bubbleSize = 66 * scale;
    return Column(
      children: [
        Container(
          width: bubbleSize,
          height: bubbleSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFFFFB800), Color(0xFF16A34A), Color(0xFFEF4444)],
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(3 * scale),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(4 * scale),
                child: ClipOval(
                  child: Image.network(
                    story.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFE2E8F0),
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: const Color(0xFF94A3B8),
                          size: 24 * scale,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6 * scale),
        SizedBox(
          width: bubbleSize,
          child: Text(
            story.name ?? '',
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 11 * scale,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ShortcutCard extends GetView<HomeController> {
  const _ShortcutCard({required this.scale, required this.shortcut});

  final double scale;
  final HomeQuickShortcut shortcut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onQuickShortcutTap(shortcut),
      child: Column(
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: shortcut.background,
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            child: Icon(shortcut.icon, color: shortcut.iconColor, size: 20 * scale),
          ),
          SizedBox(height: 6 * scale),
          Text(
            shortcut.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF0B1220),
              fontSize: 11 * scale,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.scale, required this.icon, required this.value});

  final double scale;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 14 * scale),
          SizedBox(width: 5 * scale),
          Text(
            value,
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 11 * scale,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventStatPill extends StatelessWidget {
  const _EventStatPill({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14 * scale),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11 * scale,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityStatChip extends StatelessWidget {
  const _CommunityStatChip({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14 * scale),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11 * scale,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
