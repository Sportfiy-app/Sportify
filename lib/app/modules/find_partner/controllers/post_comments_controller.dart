import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'post_detail_controller.dart';

class PostCommentsController extends GetxController {
  final filters = const ['Tous', 'Amis', 'Organisateur', 'Les plus utiles'];
  final RxInt selectedFilterIndex = 0.obs;
  final Rx<CommentSort> currentSort = CommentSort.recent.obs;
  final searchController = TextEditingController();
  final commentController = TextEditingController();

  late final PostDetail detail;
  late final RxList<CommentThread> threads;

  @override
  void onInit() {
    super.onInit();
    detail = Get.arguments is PostDetail ? Get.arguments as PostDetail : _defaultDetail;
    threads = <CommentThread>[..._defaultThreads].obs;
  }

  @override
  void onClose() {
    searchController.dispose();
    commentController.dispose();
    super.onClose();
  }

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
    Get.snackbar('Filtre', 'Filtre ${filters[index]} prochainement.');
  }

  void setSort(CommentSort sort) {
    if (currentSort.value == sort) return;
    currentSort.value = sort;
    Get.snackbar('Tri', 'Tri ${sort.label} appliqué bientôt.');
  }

  void toggleLike(Comment comment) {
    Get.snackbar('Réaction', 'Réaction sur ${comment.author} à venir.');
  }

  void toggleHelpful(Comment comment) {
    Get.snackbar('Utile', 'Fonctionnalité prochainement.');
  }

  void reply(Comment comment) {
    Get.snackbar('Réponse', 'Répondre à ${comment.author}.');
  }

  void openThread(CommentThread thread) {
    Get.snackbar('Thread', 'Ouverture du fil de ${thread.parent.author}.');
  }

  void submitSearch() {
    Get.snackbar('Recherche', 'Recherche de "${searchController.text}" sous peu.');
  }

  void submitComment() {
    final value = commentController.text.trim();
    if (value.isEmpty) return;
    threads.insert(
      0,
      CommentThread(
        parent: Comment(
          author: 'Vous',
          avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=100&q=60',
          messageLines: value.split('\n'),
          timeAgo: 'À l’instant',
          likes: 0,
        ),
        replies: const [],
      ),
    );
    commentController.clear();
    Get.snackbar('Commentaire', 'Votre commentaire a été ajouté.');
  }

  final PostDetail _defaultDetail = const PostDetail(
    images: [
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1400&q=60',
      'https://images.unsplash.com/photo-1518081461904-9c3261b51f77?auto=format&fit=crop&w=1400&q=60',
      'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=1400&q=60',
    ],
    author: Author(
      name: 'Alexandre M.',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
      location: '4 km • Nice, France',
      timeAgo: 'Il y a 2h',
      isUrgent: true,
    ),
    title: 'Qui est chaud pour un foot ce soir ? ⚽',
    sportTag: 'Football',
    likes: 12,
    commentsCount: 25,
    shares: 3,
    views: 20,
    description: [
      'Salut tout le monde ! On cherche des joueurs pour un foot assez régulièrement sur Nice. Niveau intermédiaire, ambiance décontractée mais on aime bien jouer sérieusement.',
      'Ce soir c\'est prévu à 19h au stade des Baumettes. On est déjà 6, il nous manque 4-5 joueurs pour faire deux équipes équilibrées. Qui est motivé ? 🔥',
    ],
    session: SessionDetail(
      dateLabel: "Aujourd'hui, 19h00",
      duration: 'Durée: 2h environ',
      location: 'Stade des Baumettes',
      address: 'Avenue des Baumettes, Nice',
      attendeesLabel: '6/11 joueurs confirmés',
      levelInfo: 'Niveau intermédiaire requis',
    ),
    participants: [
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=100&q=60',
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
    ],
    participantsSummary: 'Thomas, Kevin, Lisa et 3 autres sont intéressés',
    participantsFootnote: '2 personnes ont déjà confirmé leur présence',
  );

  List<CommentThread> get _defaultThreads => const [
        CommentThread(
          parent: Comment(
            author: 'Marine L.',
            avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=100&q=60',
            messageLines: ['Super ! Je peux venir avec mon copain,', 'ça fait 2 de plus 👍'],
            timeAgo: 'Il y a 1h',
            likes: 12,
            isHelpful: true,
          ),
          replies: [
            Comment(
              author: 'Alexandre (organisateur)',
              avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=100&q=60',
              messageLines: ['Génial ! On vous attend à 19h, merci 🙌'],
              timeAgo: 'Il y a 35min',
              likes: 3,
              isPinned: true,
            ),
          ],
        ),
        CommentThread(
          parent: Comment(
            author: 'Julien P.',
            avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=100&q=60',
            messageLines: ['Quel niveau exactement ? Moi ça fait longtemps que j\'ai pas joué 😅'],
            timeAgo: 'Il y a 45min',
            likes: 4,
          ),
          replies: [
            Comment(
              author: 'Sarah',
              avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=100&q=60',
              messageLines: ['Niveau intermédiaire mais très bonne ambiance !'],
              timeAgo: 'Il y a 30min',
              likes: 2,
            ),
          ],
        ),
        CommentThread(
          parent: Comment(
            author: 'Kevin R.',
            avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=60',
            messageLines: ['Je ramène des dossards et un ballon supplémentaire 🏆'],
            timeAgo: 'Il y a 10min',
            likes: 6,
          ),
          replies: [],
        ),
      ];
}

enum CommentSort { recent, top, organizer }

class CommentThread {
  const CommentThread({required this.parent, required this.replies});

  final Comment parent;
  final List<Comment> replies;
}

class Comment {
  const Comment({
    required this.author,
    required this.avatarUrl,
    required this.messageLines,
    required this.timeAgo,
    this.likes = 0,
    this.isPinned = false,
    this.isHelpful = false,
  });

  final String author;
  final String avatarUrl;
  final List<String> messageLines;
  final String timeAgo;
  final int likes;
  final bool isPinned;
  final bool isHelpful;
}

extension on CommentSort {
  String get label {
    switch (this) {
      case CommentSort.recent:
        return 'Plus récents';
      case CommentSort.top:
        return 'Les mieux notés';
      case CommentSort.organizer:
        return 'Messages organisateur';
    }
  }
}
