import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/new_post_models.dart';
import '../views/media_picker_modal.dart';
import '../views/post_success_toast.dart';

class NewPostController extends GetxController {
  final TextEditingController contentController = TextEditingController();
  final RxInt characterCount = 0.obs;
  final RxString visibility = 'Public'.obs;
  final RxString selectedSport = ''.obs;
  final RxBool includePhoto = false.obs;
  final RxBool includeVideo = false.obs;
  final RxBool showAdvancedOptions = false.obs;

  final List<String> textSuggestions = const [
    'Recherche partenaire pour...',
    'Match organisé ce...',
    'Qui est disponible pour...',
  ];

  final List<String> popularSports = const [
    'Football',
    'Basketball',
    'Tennis',
    'Running',
    'Padel',
    'Yoga',
  ];

  final List<MediaOption> mediaOptions = const [
    MediaOption(
      icon: Icons.photo_outlined,
      title: 'Photo',
      subtitle: 'JPG, PNG',
      accent: Color(0xFF176BFF),
    ),
    MediaOption(
      icon: Icons.videocam_outlined,
      title: 'Vidéo',
      subtitle: 'MP4, MOV',
      accent: Color(0xFFFFB800),
    ),
  ];

  final List<CommunityTip> communityTips = const [
    CommunityTip('Précisez votre niveau et vos attentes'),
    CommunityTip('Mentionnez le lieu et l\'horaire souhaité'),
    CommunityTip('Ajoutez une photo pour plus de visibilité'),
  ];

  final List<PreviousPost> previousPosts = const [
    PreviousPost(
      title: 'Recherche 2 joueurs pour match amical',
      timeAgo: 'Il y a 2 jours • Football',
    ),
    PreviousPost(
      title: 'Qui veut jouer au basket ce weekend ?',
      timeAgo: 'Il y a 5 jours • Basketball',
    ),
  ];

  final List<EngagementStat> engagementStats = const [
    EngagementStat(value: '85%', label: 'Taux de réponse', accent: Color(0xFF176BFF)),
    EngagementStat(value: '12', label: 'Vues moyennes', accent: Color(0xFF16A34A)),
    EngagementStat(value: '3.2', label: 'Interactions', accent: Color(0xFFFFB800)),
  ];

  @override
  void onInit() {
    super.onInit();
    contentController.addListener(_onContentChanged);
  }

  @override
  void onClose() {
    contentController.removeListener(_onContentChanged);
    contentController.dispose();
    super.onClose();
  }

  void _onContentChanged() {
    characterCount.value = contentController.text.characters.length;
  }

  void togglePhoto() => includePhoto.toggle();

  void toggleVideo() => includeVideo.toggle();

  void toggleAdvancedOptions() => showAdvancedOptions.toggle();

  void selectSport(String value) {
    selectedSport.value = value;
  }

  void setVisibility(String value) {
    visibility.value = value;
  }

  void applySuggestion(String suggestion) {
    final currentText = contentController.text.trim();
    contentController.text =
        currentText.isEmpty ? suggestion : '$currentText\n$suggestion';
    contentController.selection = TextSelection.fromPosition(
      TextPosition(offset: contentController.text.characters.length),
    );
  }

  void openMediaPicker(MediaOption option) {
    if (option.title == 'Photo') {
      includePhoto.value = true;
      includeVideo.value = false;
    } else {
      includePhoto.value = false;
      includeVideo.value = true;
    }

    Get.bottomSheet(
      MediaPickerModal(option: option),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void saveDraft() {
    Get.snackbar('Brouillon', 'Votre brouillon a été enregistré.');
  }

  void previewPost() {
    Get.snackbar('Aperçu', 'Prévisualisation à venir.');
  }

  void publishPost() {
    if (contentController.text.trim().isEmpty) {
      Get.snackbar('Contenu requis', 'Veuillez rédiger votre annonce avant de publier.');
      return;
    }
    Get.back();
    Future.delayed(const Duration(milliseconds: 200), PostSuccessToast.show);
  }
}
