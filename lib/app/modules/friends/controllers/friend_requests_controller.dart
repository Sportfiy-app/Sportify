import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/friends/friends_repository.dart';
import '../../../data/friends/models/friend_model.dart';

class FriendRequestsController extends GetxController {
  FriendRequestsController(this._friendsRepository);

  final FriendsRepository _friendsRepository;

  final RxList<FriendRequestModel> receivedRequests = <FriendRequestModel>[].obs;
  final RxList<FriendRequestModel> sentRequests = <FriendRequestModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString? errorMessage = RxString(null);
  final RxString activeTab = 'received'.obs; // 'received' or 'sent'

  @override
  void onInit() {
    super.onInit();
    loadRequests();
  }

  Future<void> loadRequests() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final [received, sent] = await Future.wait([
        _friendsRepository.getFriendRequests(type: 'received'),
        _friendsRepository.getFriendRequests(type: 'sent'),
      ]);
      receivedRequests.assignAll(received);
      sentRequests.assignAll(sent);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      if (kDebugMode) {
        debugPrint('Error loading friend requests: ${e.message}');
      }
    } catch (e) {
      errorMessage.value = 'Une erreur inattendue est survenue';
      if (kDebugMode) {
        debugPrint('Error loading friend requests: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptRequest(FriendRequestModel request) async {
    try {
      await _friendsRepository.respondToFriendRequest(
        friendshipId: request.id,
        action: 'accept',
      );
      receivedRequests.removeWhere((r) => r.id == request.id);
      Get.snackbar('Demande acceptée', 'Vous êtes maintenant amis avec ${request.requester.fullName}');
      await loadRequests(); // Reload to update counts
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error accepting request: $e');
      }
      Get.snackbar('Erreur', 'Impossible d\'accepter la demande');
    }
  }

  Future<void> rejectRequest(FriendRequestModel request) async {
    try {
      await _friendsRepository.respondToFriendRequest(
        friendshipId: request.id,
        action: 'reject',
      );
      receivedRequests.removeWhere((r) => r.id == request.id);
      Get.snackbar('Demande refusée', 'La demande a été refusée');
      await loadRequests(); // Reload to update counts
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error rejecting request: $e');
      }
      Get.snackbar('Erreur', 'Impossible de refuser la demande');
    }
  }

  Future<void> cancelSentRequest(FriendRequestModel request) async {
    try {
      await _friendsRepository.respondToFriendRequest(
        friendshipId: request.id,
        action: 'reject', // Use reject to cancel sent request
      );
      sentRequests.removeWhere((r) => r.id == request.id);
      Get.snackbar('Demande annulée', 'La demande a été annulée');
      await loadRequests(); // Reload to update counts
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error canceling request: $e');
      }
      Get.snackbar('Erreur', 'Impossible d\'annuler la demande');
    }
  }

  void switchTab(String tab) {
    activeTab.value = tab;
  }
}

