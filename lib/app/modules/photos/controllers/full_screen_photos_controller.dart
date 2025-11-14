import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class FullScreenPhotosController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  final RxString activeCategory = 'Toutes'.obs;
  final RxBool isMultiSelectEnabled = false.obs;
  final RxSet<String> selectedPhotoIds = <String>{}.obs;

  final VenuePhotoDetails details = const VenuePhotoDetails(
    name: 'Tennis Club Premium',
    address: '15 Avenue des Sports, Paris 16e',
    rating: 4.8,
    openLabel: 'Ouvert 24h/24',
    primaryButtonLabel: 'Réserver maintenant',
    secondaryButtonLabel: '+9',
  );

  final List<VenueFeatureChip> featureChips = const [
    VenueFeatureChip(label: 'Court Principal', color: Color(0xFF176BFF)),
    VenueFeatureChip(label: 'Éclairage LED', color: Color(0xFF16A34A)),
    VenueFeatureChip(label: 'Surface Terre Battue', color: Color(0xFFFFB800)),
    VenueFeatureChip(label: 'Vestiaires', color: Colors.white),
  ];

  final List<PhotoCategory> categories = const [
    PhotoCategory(name: 'Toutes', count: 24),
    PhotoCategory(name: 'Courts', count: 18),
    PhotoCategory(name: 'Équipements', count: 6),
  ];

  late final List<PhotoItem> photos;

  @override
  void onInit() {
    super.onInit();
    photos = _generatePhotos();
    pageController.addListener(_handlePageChange);
  }

  @override
  void onClose() {
    pageController.removeListener(_handlePageChange);
    pageController.dispose();
    super.onClose();
  }

  List<PhotoItem> get filteredPhotos {
    if (activeCategory.value == 'Toutes') {
      return photos;
    }
    return photos.where((photo) => photo.category == activeCategory.value).toList();
  }

  void _handlePageChange() {
    final index = pageController.page?.round() ?? 0;
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  void goTo(index) {
    if (index < 0 || index >= photos.length) {
      return;
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  void onThumbnailTap(PhotoItem photo) {
    final index = photos.indexWhere((element) => element.id == photo.id);
    if (index != -1) {
      goTo(index);
    }
  }

  void selectCategory(String category) {
    activeCategory.value = category;
  }

  void toggleSelectionMode() {
    isMultiSelectEnabled.value = !isMultiSelectEnabled.value;
    if (!isMultiSelectEnabled.value) {
      selectedPhotoIds.clear();
    }
  }

  void togglePhotoSelection(PhotoItem photo) {
    if (!isMultiSelectEnabled.value) {
      return;
    }
    if (selectedPhotoIds.contains(photo.id)) {
      selectedPhotoIds.remove(photo.id);
    } else {
      selectedPhotoIds.add(photo.id);
    }
  }

  void share() {
    Get.snackbar('Partager', 'Options de partage à venir.');
  }

  void download() {
    Get.snackbar('Téléchargement', 'La photo est en cours de téléchargement…');
  }

  void report() {
    Get.snackbar('Signaler', 'Merci pour votre signalement.');
  }

  void copyLink() {
    Get.snackbar('Lien copié', 'Lien vers la galerie copié dans le presse-papiers.');
  }

  void openQrGenerator() {
    Get.snackbar('QR Code', 'Génération de QR Code à venir.');
  }

  void openVenueBooking() {
    Get.toNamed(Routes.bookingPlaceDetail);
  }

  List<PhotoItem> _generatePhotos() {
    final baseUrls = [
      'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=900&q=60',
      'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=900&q=60',
      'https://images.unsplash.com/photo-1546484959-f9a94e886f5c?auto=format&fit=crop&w=900&q=60',
      'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=900&q=60',
      'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=900&q=60',
      'https://images.unsplash.com/photo-1547970239-6a1e7a7a4590?auto=format&fit=crop&w=900&q=60',
    ];

    final List<PhotoItem> items = [];
    var id = 0;
    for (final url in baseUrls) {
      items.add(PhotoItem(id: 'photo_$id', imageUrl: url, category: 'Courts'));
      id++;
    }
    items.addAll([
      PhotoItem(
        id: 'photo_$id',
        imageUrl: 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=900&q=60',
        category: 'Équipements',
      ),
      PhotoItem(
        id: 'photo_${id + 1}',
        imageUrl: 'https://images.unsplash.com/photo-1508606572321-901ea443707f?auto=format&fit=crop&w=900&q=60',
        category: 'Équipements',
      ),
      PhotoItem(
        id: 'photo_${id + 2}',
        imageUrl: 'https://images.unsplash.com/photo-1502810190503-8303352d1fea?auto=format&fit=crop&w=900&q=60',
        category: 'Courts',
      ),
      PhotoItem(
        id: 'photo_${id + 3}',
        imageUrl: 'https://images.unsplash.com/photo-1528493366314-e317cd98ddc9?auto=format&fit=crop&w=900&q=60',
        category: 'Courts',
      ),
    ]);
    return items;
  }
}

class PhotoItem {
  const PhotoItem({
    required this.id,
    required this.imageUrl,
    required this.category,
  });

  final String id;
  final String imageUrl;
  final String category;
}

class PhotoCategory {
  const PhotoCategory({required this.name, required this.count});

  final String name;
  final int count;
}

class VenueFeatureChip {
  const VenueFeatureChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}

class VenuePhotoDetails {
  const VenuePhotoDetails({
    required this.name,
    required this.address,
    required this.rating,
    required this.openLabel,
    required this.primaryButtonLabel,
    required this.secondaryButtonLabel,
  });

  final String name;
  final String address;
  final double rating;
  final String openLabel;
  final String primaryButtonLabel;
  final String secondaryButtonLabel;
}

