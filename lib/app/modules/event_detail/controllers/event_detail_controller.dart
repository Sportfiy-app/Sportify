import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/events/events_repository.dart';
import '../../../data/events/models/event_model.dart';
import '../models/event_detail_model.dart';

class EventDetailController extends GetxController {
  final EventsRepository _eventsRepository = Get.find<EventsRepository>();
  
  final Rx<EventDetailModel?> event = Rx<EventDetailModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isJoining = false.obs;
  final RxBool isLeaving = false.obs;
  final RxnString errorMessage = RxnString();
  String? _eventId;

  @override
  void onInit() {
    super.onInit();
    // Get eventId from arguments
    final args = Get.arguments;
    if (args is String && args.isNotEmpty) {
      _eventId = args;
      loadEvent(_eventId!);
    } else {
      errorMessage.value = 'ID d\'événement manquant';
    }
  }

  // Convert EventModel to EventDetailModel
  EventDetailModel _convertToEventDetailModel(EventModel eventModel) {
    final timeParts = eventModel.time.split(':');
    final time = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    final organizerName = eventModel.organizerFirstName != null && eventModel.organizerLastName != null
        ? '${eventModel.organizerFirstName} ${eventModel.organizerLastName}'
        : 'Organisateur';

    return EventDetailModel(
      id: eventModel.id,
      title: eventModel.title,
      description: eventModel.description,
      sport: eventModel.sport,
      location: eventModel.location,
      date: eventModel.date,
      time: time,
      organizerId: eventModel.organizerId,
      organizerName: organizerName,
      organizerAvatar: eventModel.organizerAvatarUrl ?? '',
      minParticipants: eventModel.minParticipants,
      maxParticipants: eventModel.maxParticipants,
      currentParticipants: eventModel.currentParticipants,
      participants: eventModel.participants?.map((p) => EventParticipant(
        id: p.id,
        userId: p.userId,
        userName: p.userName ?? 'Utilisateur',
        userAvatar: p.userAvatar ?? '',
        joinedAt: p.joinedAt ?? DateTime.now(),
        isOrganizer: p.isOrganizer ?? false,
      )).toList() ?? [],
      waitingList: eventModel.waitingList?.map((p) => EventParticipant(
        id: p.id,
        userId: p.userId,
        userName: p.userName ?? 'Utilisateur',
        userAvatar: p.userAvatar ?? '',
        joinedAt: p.joinedAt ?? DateTime.now(),
        isOrganizer: false,
      )).toList() ?? [],
      isPublic: eventModel.isPublic,
      difficultyLevel: eventModel.difficultyLevel,
      tags: eventModel.tags,
      price: eventModel.price != null ? '${eventModel.price} ${eventModel.priceCurrency ?? 'EUR'}' : null,
      imageUrl: eventModel.imageUrl,
      isUserJoined: eventModel.isUserJoined ?? false,
      isUserInWaitingList: eventModel.isUserInWaitingList ?? false,
      userParticipationId: eventModel.userParticipationId,
      createdAt: eventModel.createdAt,
      updatedAt: eventModel.updatedAt,
    );
  }

  // Load event details
  Future<void> loadEvent(String eventId) async {
    isLoading.value = true;
    errorMessage.value = null;
    
    try {
      final eventModel = await _eventsRepository.getEventById(eventId);
      event.value = _convertToEventDetailModel(eventModel);
    } catch (e) {
      errorMessage.value = 'Impossible de charger les détails de l\'événement';
      Get.snackbar(
        'Erreur',
        'Impossible de charger les détails de l\'événement',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check if user can join
  bool canUserJoin() {
    if (event.value == null) return false;
    final evt = event.value!;
    
    // Check if already joined
    if (evt.isUserJoined) return false;
    
    // Check if already in waiting list
    if (evt.isUserInWaitingList) return false;
    
    // Check if event is full
    if (evt.isFull) return false;
    
    // Check if event date hasn't passed
    final eventDateTime = DateTime(
      evt.date.year,
      evt.date.month,
      evt.date.day,
      evt.time.hour,
      evt.time.minute,
    );
    if (eventDateTime.isBefore(DateTime.now())) return false;
    
    return true;
  }

  // Join event
  Future<bool> joinEvent() async {
    if (!canUserJoin()) {
      errorMessage.value = 'Impossible de rejoindre cet événement';
      return false;
    }

    isJoining.value = true;
    errorMessage.value = null;

    try {
      await _eventsRepository.joinEvent(event.value!.id);
      
      // Reload event to get updated data
      await loadEvent(event.value!.id);

      Get.snackbar(
        'Succès',
        'Vous avez rejoint l\'événement avec succès !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF16A34A).withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      errorMessage.value = 'Erreur lors de la participation à l\'événement';
      Get.snackbar(
        'Erreur',
        'Impossible de rejoindre l\'événement. ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
      );
      return false;
    } finally {
      isJoining.value = false;
    }
  }

  // Join waiting list
  Future<bool> joinWaitingList() async {
    if (event.value == null) return false;
    final evt = event.value!;

    if (evt.isUserJoined || evt.isUserInWaitingList) {
      errorMessage.value = 'Vous êtes déjà inscrit à cet événement';
      return false;
    }

    isJoining.value = true;
    errorMessage.value = null;

    try {
      // Join event - backend will automatically add to waiting list if full
      await _eventsRepository.joinEvent(event.value!.id);
      
      // Reload event to get updated data
      await loadEvent(event.value!.id);

      final evt = event.value!;
      if (evt.isUserInWaitingList) {
        Get.snackbar(
          'Liste d\'attente',
          'Vous avez été ajouté à la liste d\'attente. Vous serez notifié si une place se libère.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFFB800).withValues(alpha: 0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.access_time_rounded, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Succès',
          'Vous avez rejoint l\'événement avec succès !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF16A34A).withValues(alpha: 0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
      }

      return true;
    } catch (e) {
      errorMessage.value = 'Erreur lors de l\'ajout à la liste d\'attente';
      Get.snackbar(
        'Erreur',
        'Impossible de rejoindre l\'événement. ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
      );
      return false;
    } finally {
      isJoining.value = false;
    }
  }

  // Leave event
  Future<bool> leaveEvent() async {
    if (event.value == null) return false;
    final evt = event.value!;

    if (!evt.isUserJoined && !evt.isUserInWaitingList) {
      errorMessage.value = 'Vous n\'êtes pas inscrit à cet événement';
      return false;
    }

    isLeaving.value = true;
    errorMessage.value = null;

    try {
      await _eventsRepository.leaveEvent(event.value!.id);
      
      // Reload event to get updated data (including any waiting list promotions)
      await loadEvent(event.value!.id);

      Get.snackbar(
        'Succès',
        'Vous avez quitté l\'événement',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF64748B).withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      errorMessage.value = 'Erreur lors de la sortie de l\'événement';
      Get.snackbar(
        'Erreur',
        'Impossible de quitter l\'événement. ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
      );
      return false;
    } finally {
      isLeaving.value = false;
    }
  }
}

