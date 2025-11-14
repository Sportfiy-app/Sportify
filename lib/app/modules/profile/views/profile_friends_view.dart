import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_friends_controller.dart';

class ProfileFriendsView extends StatefulWidget {
  const ProfileFriendsView({super.key});

  @override
  State<ProfileFriendsView> createState() => _ProfileFriendsViewState();
}

class _ProfileFriendsViewState extends State<ProfileFriendsView> {
  final ProfileFriendsController controller = Get.find<ProfileFriendsController>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      floatingActionButton: _AddFriendFab(onPressed: controller.addFriend),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.1);

          return SafeArea(
            child: Column(
              children: [
                _HeaderBar(scale: scale, controller: controller),
                Expanded(
                  child: Obx(
                    () {
                      final sections = controller.sections;
                      final initials = controller.availableInitials;
                      final total = controller.totalFriends;

                      final sectionKeys = {
                        for (final section in sections) section.letter: GlobalKey(),
                      };

                      final content = sections.isEmpty
                          ? [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: _EmptyState(scale: scale, onAddFriend: controller.addFriend),
                              ),
                            ]
                          : sections
                              .expand<Widget>(
                                (section) => [
                                  SliverToBoxAdapter(
                                    child: _SectionHeader(
                                      key: sectionKeys[section.letter],
                                      scale: scale,
                                      letter: section.letter,
                                      count: section.friends.length,
                                    ),
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final friend = section.friends[index];
                                        return _FriendTile(
                                          scale: scale,
                                          friend: friend,
                                          onOpen: () => controller.openFriend(friend),
                                          onRemove: () => controller.removeFriend(friend),
                                        );
                                      },
                                      childCount: section.friends.length,
                                    ),
                                  ),
                                ],
                              )
                              .toList();

                      return CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _SearchBar(scale: scale, controller: controller),
                                  SizedBox(height: 16 * scale),
                                  _FilterRow(scale: scale, controller: controller),
                                  SizedBox(height: 18 * scale),
                                  _StatsRow(scale: scale, controller: controller),
                                  SizedBox(height: 18 * scale),
                                  if (initials.isNotEmpty)
                                    _AlphabetScroller(
                                      scale: scale,
                                      initials: initials,
                                      controller: controller,
                                    ),
                                  SizedBox(height: 18 * scale),
                                  Text(
                                    '$total ami${total > 1 ? 's' : ''}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12.5 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8 * scale),
                                ],
                              ),
                            ),
                          ),
                          ...content,
                          SliverToBoxAdapter(child: SizedBox(height: 96 * scale)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.scale, required this.controller});

  final double scale;
  final ProfileFriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 0),
      child: Row(
        children: [
          _IconButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Mes amis',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2 * scale),
                Obx(
                  () => Text(
                    '${controller.totalFriends} amis au total',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 12 * scale,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _IconButton(
            scale: scale,
            icon: Icons.person_add_alt_1_rounded,
            onTap: controller.addFriend,
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.scale, required this.controller});

  final double scale;
  final ProfileFriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14 * scale),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.setSearchQuery,
        style: GoogleFonts.inter(fontSize: 14 * scale, color: const Color(0xFF0B1220)),
        decoration: InputDecoration(
          icon: Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
          hintText: 'Rechercher un ami par nom...',
          hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
          border: InputBorder.none,
          suffixIcon: Obx(
            () => controller.searchQuery.value.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: controller.clearSearch,
                    icon: Icon(Icons.close_rounded, size: 18 * scale, color: const Color(0xFF94A3B8)),
                  ),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.scale, required this.controller});

  final double scale;
  final ProfileFriendsController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40 * scale,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filterOptions.length,
          separatorBuilder: (_, __) => SizedBox(width: 10 * scale),
          itemBuilder: (context, index) {
            final option = controller.filterOptions[index];
            final isSelected = controller.activeFilter.value == option;
            return ChoiceChip(
              label: Text(
                option,
                style: GoogleFonts.inter(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                ),
              ),
              selected: isSelected,
              onSelected: (_) => controller.selectFilter(option),
              selectedColor: const Color(0xFF176BFF),
              backgroundColor: const Color(0xFFF3F4F6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            );
          },
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.scale, required this.controller});

  final double scale;
  final ProfileFriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatCard(
            scale: scale,
            title: 'En ligne',
            value: controller.onlineCount,
            color: const Color(0xFF16A34A),
            icon: Icons.bolt_rounded,
          ),
          _StatCard(
            scale: scale,
            title: 'Proches',
            value: controller.nearbyCount,
            color: const Color(0xFF0EA5E9),
            icon: Icons.location_on_rounded,
          ),
          _StatCard(
            scale: scale,
            title: 'Favoris',
            value: controller.favoritesCount,
            color: const Color(0xFFFFB800),
            icon: Icons.favorite_rounded,
          ),
          _StatCard(
            scale: scale,
            title: 'Actifs',
            value: controller.activeCount,
            color: const Color(0xFF6366F1),
            icon: Icons.flash_on_rounded,
          ),
        ],
      ),
    );
  }
}

class _AlphabetScroller extends StatelessWidget {
  const _AlphabetScroller({
    required this.scale,
    required this.initials,
    required this.controller,
  });

  final double scale;
  final List<String> initials;
  final ProfileFriendsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: initials
              .map(
                (letter) => Padding(
                  padding: EdgeInsets.only(right: 8 * scale),
                  child: ChoiceChip(
                    label: Text(
                      letter,
                      style: GoogleFonts.inter(
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w600,
                        color: controller.selectedInitial.value == letter ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    selected: controller.selectedInitial.value == letter,
                    onSelected: (_) => controller.selectInitial(letter),
                    selectedColor: const Color(0xFF176BFF),
                    backgroundColor: const Color(0xFFE2E8F0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                ),
              )
              .toList()
            ..insert(
              0,
              Padding(
                padding: EdgeInsets.only(right: 8 * scale),
                child: ChoiceChip(
                  label: Text(
                    'Tous',
                    style: GoogleFonts.inter(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w600,
                      color: controller.selectedInitial.value == null ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                  selected: controller.selectedInitial.value == null,
                  onSelected: (_) => controller.selectInitial(null),
                  selectedColor: const Color(0xFF176BFF),
                  backgroundColor: const Color(0xFFE2E8F0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
              ),
            ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({super.key, required this.scale, required this.letter, required this.count});

  final double scale;
  final String letter;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 8 * scale),
      child: Row(
        children: [
          Text(
            letter,
            style: GoogleFonts.poppins(color: const Color(0xFF475569), fontSize: 16 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8 * scale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$count',
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendTile extends StatelessWidget {
  const _FriendTile({
    required this.scale,
    required this.friend,
    required this.onOpen,
    required this.onRemove,
  });

  final double scale;
  final FriendItem friend;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 6 * scale),
      child: Dismissible(
        key: ValueKey(friend.id),
        direction: DismissDirection.endToStart,
        background: _DismissBackground(scale: scale),
        onDismissed: (_) => onRemove(),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(18 * scale),
            onTap: onOpen,
            child: Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Row(
                children: [
                  _Avatar(scale: scale, friend: friend),
                  SizedBox(width: 16 * scale),
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
                            if (friend.favoriteSports.isNotEmpty)
                              Icon(Icons.sports_soccer_rounded, size: 16 * scale, color: const Color(0xFF94A3B8)),
                          ],
                        ),
                        SizedBox(height: 4 * scale),
                        Row(
                          children: [
                            Icon(Icons.place_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                            SizedBox(width: 4 * scale),
                            Text(
                              friend.distanceLabel,
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                            ),
                          ],
                        ),
                        SizedBox(height: 6 * scale),
                        Wrap(
                          spacing: 8 * scale,
                          runSpacing: 4 * scale,
                          children: [
                            _Tag(
                              scale: scale,
                              label: friend.presenceLabel,
                              color: friend.isOnline ? const Color(0xFFDCFCE7) : const Color(0xFFE2E8F0),
                              textColor: friend.isOnline ? const Color(0xFF15803D) : const Color(0xFF64748B),
                            ),
                            _Tag(
                              scale: scale,
                              label: friend.availabilityTag,
                              color: const Color(0xFFF8FAFC),
                              textColor: const Color(0xFF475569),
                            ),
                            ...friend.favoriteSports.take(2).map(
                                  (sport) => _Tag(
                                    scale: scale,
                                    label: sport,
                                    color: const Color(0xFFEFF6FF),
                                    textColor: const Color(0xFF176BFF),
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 24 * scale),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.scale, required this.friend});

  final double scale;
  final FriendItem friend;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56 * scale,
          height: 56 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white, width: 2 * scale),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(friend.avatarUrl, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -2 * scale,
          right: -2 * scale,
          child: Container(
            width: 14 * scale,
            height: 14 * scale,
            decoration: BoxDecoration(
              color: friend.isOnline ? const Color(0xFF22C55E) : const Color(0xFFCbd5F5),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white, width: 2 * scale),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.scale, required this.label, required this.color, required this.textColor});

  final double scale;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: textColor, fontSize: 11.5 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.scale,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final double scale;
  final String title;
  final int value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90 * scale,
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32 * scale,
              height: 32 * scale,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10 * scale)),
              alignment: Alignment.center,
              child: Icon(icon, size: 18 * scale, color: color),
            ),
            SizedBox(height: 10 * scale),
            Text(
              '$value',
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700),
            ),
            Text(
              title,
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444),
        borderRadius: BorderRadius.circular(18 * scale),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
      alignment: Alignment.centerRight,
      child: Icon(Icons.delete_forever_rounded, color: Colors.white, size: 24 * scale),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.scale, required this.onAddFriend});

  final double scale;
  final VoidCallback onAddFriend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * scale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120 * scale,
            height: 120 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(30 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.group_add_rounded, size: 48 * scale, color: const Color(0xFF0EA5E9)),
          ),
          SizedBox(height: 24 * scale),
          Text(
            'Aucun ami pour le moment',
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Invitez vos partenaires ou cherchez de nouveaux amis sportifs pour enrichir votre réseau.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.4),
          ),
          SizedBox(height: 24 * scale),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddFriend,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Text(
                'Ajouter un ami',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddFriendFab extends StatelessWidget {
  const _AddFriendFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF176BFF),
      icon: const Icon(Icons.person_add_alt_1_rounded),
      label: const Text('Ajouter'),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

