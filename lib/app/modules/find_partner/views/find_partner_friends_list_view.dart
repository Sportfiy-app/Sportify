import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';

class FindPartnerFriendsListView extends GetView<FindPartnerController> {
  const FindPartnerFriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.85, 1.1);

          return SafeArea(
            child: Column(
              children: [
                _FriendsAppBar(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 24 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 12 * scale),
                        _SearchAndFilterSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _OnlineSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _QuickActionsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _FriendsListSection(scale: scale),
                        SizedBox(height: 12 * scale),
                        _LoadMoreFriendsButton(scale: scale),
                        SizedBox(height: 20 * scale),
                        _FriendStatsSection(scale: scale),
                        SizedBox(height: 20 * scale),
                        _FriendsActivitySection(scale: scale),
                        SizedBox(height: 20 * scale),
                        _FriendSuggestionsSection(scale: scale),
                      ],
                    ),
                  ),
                ),
                _FriendsBottomNav(scale: scale),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FriendsAppBar extends GetView<FindPartnerController> {
  const _FriendsAppBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18 * scale, color: const Color(0xFF0B1220)),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Amis',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Obx(
                    () => Text(
                      '${controller.friendsTotalCount} amis',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 12 * scale,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF),
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: Text(
              '${controller.friendsTotalCount}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchAndFilterSection extends GetView<FindPartnerController> {
  const _SearchAndFilterSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.friendSearchController,
              onChanged: controller.setFriendSearch,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12 * scale),
                prefixIcon: Icon(Icons.search_rounded, size: 20 * scale, color: const Color(0xFF94A3B8)),
                hintText: 'Rechercher un ami...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFFADAEBC),
                  fontSize: 16 * scale,
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            SizedBox(height: 16 * scale),
            SizedBox(
              height: 40 * scale,
              child: Obx(
                () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final label = controller.friendFilters[index];
                    final isSelected = controller.selectedFriendFilter.value == label;
                    return GestureDetector(
                      onTap: () {
                        controller.selectFriendFilter(label);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(999 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          label,
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : const Color(0xFF0B1220),
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
                  itemCount: controller.friendFilters.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnlineSection extends GetView<FindPartnerController> {
  const _OnlineSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'En ligne maintenant',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Text(
                    controller.onlineFriends.length.toString(),
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
            SizedBox(
              height: 88 * scale,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final friend = controller.onlineFriends[index];
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 32 * scale,
                            backgroundImage: NetworkImage(friend.avatarUrl),
                          ),
                          Positioned(
                            right: -2 * scale,
                            bottom: -2 * scale,
                            child: Container(
                              width: 18 * scale,
                              height: 18 * scale,
                              decoration: BoxDecoration(
                                color: const Color(0xFF16A34A),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3 * scale),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * scale),
                      Text(
                        friend.name,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: 16 * scale),
                itemCount: controller.onlineFriends.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsSection extends GetView<FindPartnerController> {
  const _QuickActionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Row(
          children: controller.friendQuickActions
              .map(
                (action) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6 * scale),
                    child: GestureDetector(
                      onTap: () => controller.onFriendQuickAction(action),
                      child: Container(
                        height: 84 * scale,
                        decoration: BoxDecoration(
                          color: action.background,
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(action.icon, color: action.foreground, size: 20 * scale),
                            SizedBox(height: 8 * scale),
                            Text(
                              action.label,
                              style: GoogleFonts.inter(
                                color: action.foreground,
                                fontSize: 12 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _FriendsListSection extends GetView<FindPartnerController> {
  const _FriendsListSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tous les amis',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            Obx(
              () {
                final friends = controller.filteredFriends;
                return Column(
                  children: friends
                      .map(
                        (friend) => Padding(
                          padding: EdgeInsets.only(bottom: friend == friends.last ? 0 : 12 * scale),
                          child: _FriendCard(scale: scale, friend: friend),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({required this.scale, required this.friend});

  final double scale;
  final Friend friend;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FindPartnerController>();
    return GestureDetector(
      onTap: () => controller.onFriendTap(friend),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12 * scale,
              offset: Offset(0, 6 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28 * scale,
              backgroundImage: NetworkImage(friend.avatarUrl),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          friend.name,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF0B1220),
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      _FriendTagPill(tag: friend.levelTag, scale: scale),
                    ],
                  ),
                  SizedBox(height: 6 * scale),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                      SizedBox(width: 4 * scale),
                      Text(
                        friend.distance,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 13 * scale,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Icon(Icons.access_time_rounded, size: 14 * scale, color: const Color(0xFF94A3B8)),
                      SizedBox(width: 4 * scale),
                      Text(
                        friend.statusTag.label,
                        style: GoogleFonts.inter(
                          color: friend.statusTag.color,
                          fontSize: 13 * scale,
                        ),
                      ),
                    ],
                  ),
                  if (friend.attributes.isNotEmpty) ...[
                    SizedBox(height: 10 * scale),
                    Wrap(
                      spacing: 8 * scale,
                      runSpacing: 8 * scale,
                      children: friend.attributes
                          .map(
                            (attribute) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(999 * scale),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Text(
                                attribute,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 12 * scale,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12 * scale),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
          ],
        ),
      ),
    );
  }
}

class _FriendTagPill extends StatelessWidget {
  const _FriendTagPill({required this.tag, required this.scale});

  final FriendTag tag;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: tag.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Text(
        tag.label,
        style: GoogleFonts.inter(
          color: tag.color,
          fontSize: 12 * scale,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LoadMoreFriendsButton extends GetView<FindPartnerController> {
  const _LoadMoreFriendsButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: OutlinedButton(
        onPressed: controller.loadMoreFriends,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          backgroundColor: Colors.white,
        ),
        child: Text(
          'Charger plus d\'amis',
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 15 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FriendStatsSection extends GetView<FindPartnerController> {
  const _FriendStatsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.friendStats;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques des amis',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            LayoutBuilder(
              builder: (context, boxConstraints) {
                final itemWidth = (boxConstraints.maxWidth - 2 * 12 * scale) / 3;
                return Wrap(
                  spacing: 12 * scale,
                  runSpacing: 12 * scale,
                  children: stats
                      .map(
                        (stat) => SizedBox(
                          width: itemWidth,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12 * scale),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16 * scale),
                            child: Column(
                              children: [
                                Icon(stat.icon, color: const Color(0xFF176BFF), size: 20 * scale),
                                SizedBox(height: 8 * scale),
                                Text(
                                  stat.value,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 18 * scale,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  stat.label,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 13 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendsActivitySection extends GetView<FindPartnerController> {
  const _FriendsActivitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final activity = controller.friendActivity;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activité récente',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            Column(
              children: activity
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: item == activity.last ? 0 : 12 * scale),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20 * scale,
                            backgroundImage: NetworkImage(item.avatarUrl),
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.message,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  item.timeAgo,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 12 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.more_horiz_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendSuggestionsSection extends GetView<FindPartnerController> {
  const _FriendSuggestionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final suggestions = controller.friendSuggestions;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Amis suggérés',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.viewAllSuggestedFriends,
                  child: Text(
                    'Voir tout',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Column(
              children: suggestions
                  .map(
                    (suggestion) => Padding(
                      padding: EdgeInsets.only(bottom: suggestion == suggestions.last ? 0 : 12 * scale),
                      child: _FriendSuggestionCard(scale: scale, suggestion: suggestion),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendSuggestionCard extends StatelessWidget {
  const _FriendSuggestionCard({required this.scale, required this.suggestion});

  final double scale;
  final FriendSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FindPartnerController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24 * scale,
            backgroundImage: NetworkImage(suggestion.avatarUrl),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion.name,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  suggestion.subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13 * scale,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          ElevatedButton.icon(
            onPressed: () => controller.addSuggestedFriend(suggestion),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999 * scale)),
            ),
            icon: Icon(Icons.person_add_alt_rounded, size: 18 * scale),
            label: Text(
              'Ajouter',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendsBottomNav extends StatelessWidget {
  const _FriendsBottomNav({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16 * scale,
            offset: Offset(0, -4 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _BottomNavItem(icon: Icons.home_filled, label: 'Accueil'),
          _BottomNavItem(icon: Icons.search_rounded, label: 'Recherche'),
          _BottomNavItem(icon: Icons.calendar_month_rounded, label: 'Réserver'),
          _BottomNavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
          _BottomNavItem(icon: Icons.person_outline_rounded, label: 'Profil', isActive: true),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(label, 'Navigation vers $label prochainement'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              color: isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

