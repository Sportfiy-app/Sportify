import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/events/events_repository.dart';
import '../../../data/api/api_exception.dart';
import '../widgets/modern_date_picker.dart';
import '../widgets/modern_time_picker.dart';

class CreateEventController extends GetxController {
  final EventsRepository _eventsRepository = Get.find<EventsRepository>();
  // Step tracking
  final RxInt currentStep = 0.obs;
  final int totalSteps = 5;

  // Form fields
  final RxString selectedSport = 'Football'.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  final TextEditingController locationController = TextEditingController();
  final RxString locationAddress = ''.obs;
  final RxString locationText = ''.obs; // Observable for location text
  final RxnDouble selectedLatitude = RxnDouble();
  final RxnDouble selectedLongitude = RxnDouble();
  final RxString locationType = 'address'.obs; // 'address', 'club', 'partner'
  final RxString selectedClubId = ''.obs;
  final RxString selectedPartnerId = ''.obs;
  final RxInt minParticipants = 2.obs;
  final RxInt maxParticipants = 10.obs;
  final RxBool isPublic = true.obs;
  final RxnDouble price = RxnDouble();
  final RxString? priceCurrency = 'EUR'.obs;
  final RxString difficultyLevel = 'Intermédiaire'.obs;
  final RxList<String> selectedTags = <String>[].obs;

  // Loading state
  final RxBool isSubmitting = false.obs;
  final RxnString errorMessage = RxnString();

  // Available options
  final List<String> availableSports = const [
    'Football',
    'Tennis',
    'Basketball',
    'Running',
    'Fitness',
    'Yoga',
    'Natation',
    'Cyclisme',
    'Volleyball',
    'Badminton',
  ];

  final List<String> difficultyLevels = const [
    'Débutant',
    'Intermédiaire',
    'Avancé',
    'Professionnel',
  ];

  final List<String> availableTags = const [
    'Amical',
    'Compétitif',
    'Entraînement',
    'Tournoi',
    'Mixte',
    'Femmes',
    'Hommes',
  ];

  late final VoidCallback _locationListener;

  @override
  void onInit() {
    super.onInit();
    // Listen to location controller changes
    _locationListener = () {
      locationText.value = locationController.text;
    };
    locationController.addListener(_locationListener);
  }

  @override
  void onClose() {
    locationController.removeListener(_locationListener);
    locationController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // Navigation
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      if (_validateCurrentStep()) {
        currentStep.value++;
      } else {
        errorMessage.value = 'Veuillez remplir tous les champs requis';
      }
    }
  }

  // Expose validation for external use
  bool get isValid => _validateCurrentStep();

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      currentStep.value = step;
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep.value) {
      case 0: // Sport selection
        return selectedSport.value.isNotEmpty;
      case 1: // Details
        return titleController.text.trim().isNotEmpty &&
            descriptionController.text.trim().isNotEmpty;
      case 2: // Date & Time
        return selectedDate.value != null && selectedTime.value != null;
      case 3: // Location
        return locationController.text.trim().isNotEmpty ||
            locationAddress.value.isNotEmpty;
      case 4: // Participants
        return minParticipants.value > 0 &&
            maxParticipants.value >= minParticipants.value;
      default:
        return true;
    }
  }

  // Sport selection
  void selectSport(String sport) {
    selectedSport.value = sport;
  }

  IconData getSportIcon(String sport) {
    switch (sport) {
      case 'Football':
        return Icons.sports_soccer_rounded;
      case 'Tennis':
        return Icons.sports_tennis_rounded;
      case 'Basketball':
        return Icons.sports_basketball_rounded;
      case 'Running':
        return Icons.directions_run_rounded;
      case 'Fitness':
        return Icons.fitness_center_rounded;
      case 'Yoga':
        return Icons.self_improvement_rounded;
      case 'Natation':
        return Icons.pool_rounded;
      case 'Cyclisme':
        return Icons.directions_bike_rounded;
      case 'Volleyball':
        return Icons.sports_volleyball_rounded;
      case 'Badminton':
        return Icons.sports_tennis_rounded;
      default:
        return Icons.sports_rounded;
    }
  }

  Color getSportColor(String sport) {
    switch (sport) {
      case 'Football':
        return const Color(0xFF176BFF);
      case 'Tennis':
        return const Color(0xFF16A34A);
      case 'Basketball':
        return const Color(0xFFFFB800);
      case 'Running':
        return const Color(0xFF16A34A);
      case 'Fitness':
        return const Color(0xFF0EA5E9);
      case 'Yoga':
        return const Color(0xFF8B5CF6);
      case 'Natation':
        return const Color(0xFF06B6D4);
      case 'Cyclisme':
        return const Color(0xFF16A34A);
      case 'Volleyball':
        return const Color(0xFFEF4444);
      case 'Badminton':
        return const Color(0xFF16A34A);
      default:
        return const Color(0xFF176BFF);
    }
  }

  // Date & Time
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => ModernDatePicker(
        initialDate: selectedDate.value ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        locale: const Locale('fr', 'FR'),
      ),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => ModernTimePicker(
        initialTime: selectedTime.value ?? TimeOfDay.now(),
      ),
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  // Participants
  void updateMinParticipants(int value) {
    if (value > 0 && value <= maxParticipants.value) {
      minParticipants.value = value;
    }
  }

  void updateMaxParticipants(int value) {
    if (value >= minParticipants.value) {
      maxParticipants.value = value;
    }
  }

  // Tags
  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  // Submit event
  Future<void> submitEvent() async {
    if (!_validateCurrentStep()) {
      errorMessage.value = 'Veuillez remplir tous les champs requis';
      Get.snackbar(
        'Champ requis',
        'Veuillez remplir tous les champs obligatoires',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
      );
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = null;

    // Declare eventData outside try block so it's accessible in catch
    Map<String, dynamic> eventData = {};
    
    try {
      // Prepare event data
      // Format date as ISO 8601 datetime string (required by backend schema)
      // The backend expects date in ISO 8601 format, we'll use midnight UTC for the date part
      final dateOnly = DateTime.utc(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
      );
      
      eventData = <String, dynamic>{
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'sport': selectedSport.value,
        'location': locationController.text.trim(),
        'date': dateOnly.toIso8601String(), // ISO 8601 datetime format (required by z.string().datetime())
        'time': '${selectedTime.value!.hour.toString().padLeft(2, '0')}:${selectedTime.value!.minute.toString().padLeft(2, '0')}', // HH:mm format
        'minParticipants': minParticipants.value,
        'maxParticipants': maxParticipants.value,
        'isPublic': isPublic.value,
        'tags': selectedTags.toList(),
        'priceCurrency': priceCurrency?.value ?? 'EUR', // Always include priceCurrency (has default in schema)
      };

      if (locationAddress.value.isNotEmpty) {
        eventData['address'] = locationAddress.value;
      }

      if (selectedLatitude.value != null && selectedLongitude.value != null) {
        eventData['latitude'] = selectedLatitude.value;
        eventData['longitude'] = selectedLongitude.value;
      }

      if (price.value != null && price.value! > 0) {
        eventData['price'] = price.value;
      }

      if (difficultyLevel.value.isNotEmpty) {
        eventData['difficultyLevel'] = difficultyLevel.value;
      }
      
      // Ensure all Rx values are converted to their actual values
      // This is a safety check to prevent encoding Rx objects
      eventData = eventData.map((key, value) {
        // Convert any remaining Rx objects to their values
        if (value is RxString) return MapEntry(key, value.value);
        if (value is RxInt) return MapEntry(key, value.value);
        if (value is RxBool) return MapEntry(key, value.value);
        if (value is RxDouble) return MapEntry(key, value.value);
        return MapEntry(key, value);
      });

      // Create event via API
      await _eventsRepository.createEvent(eventData);

      // Navigate to success page
      Get.offNamed('/event/create/success');
    } catch (e) {
      errorMessage.value = 'Erreur lors de la création de l\'événement';
      
      // Extract error message from ApiException
      String errorMsg = 'Une erreur est survenue lors de la création de l\'événement';
      if (e is ApiException) {
        errorMsg = e.message;
        if (e.details != null && e.details is Map) {
          final details = e.details as Map;
          if (details.containsKey('message')) {
            errorMsg = details['message'].toString();
          } else if (details.containsKey('errors')) {
            // Zod validation errors
            final errors = details['errors'];
            if (errors is List && errors.isNotEmpty) {
              final firstError = errors[0];
              if (firstError is Map && firstError.containsKey('message')) {
                errorMsg = firstError['message'].toString();
              }
            }
          }
        }
      } else {
        errorMsg = e.toString();
      }
      
      // Debug logging (remove in production or use proper logging)
      if (kDebugMode) {
        debugPrint('Event creation error: $e');
        debugPrint('Event data sent: $eventData');
      }
      
      Get.snackbar(
        'Erreur',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFF1F2),
        colorText: const Color(0xFFB91C1C),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline_rounded, color: Color(0xFFB91C1C)),
        duration: const Duration(seconds: 4),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Reset form
  void resetForm() {
    selectedSport.value = 'Football';
    try {
      titleController.clear();
    } catch (e) {
      // Controller already disposed
    }
    try {
      descriptionController.clear();
    } catch (e) {
      // Controller already disposed
    }
    selectedDate.value = null;
    selectedTime.value = null;
    try {
      locationController.clear();
    } catch (e) {
      // Controller already disposed
    }
    locationText.value = '';
    locationAddress.value = '';
    selectedLatitude.value = null;
    selectedLongitude.value = null;
    minParticipants.value = 2;
    maxParticipants.value = 10;
    isPublic.value = true;
    price.value = null;
    difficultyLevel.value = 'Intermédiaire';
    selectedTags.clear();
    currentStep.value = 0;
    errorMessage.value = null;
    locationType.value = 'address';
    selectedClubId.value = '';
    selectedPartnerId.value = '';
  }

  String get formattedDate {
    if (selectedDate.value == null) return 'Sélectionner une date';
    final date = selectedDate.value!;
    final months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String get formattedTime {
    if (selectedTime.value == null) return 'Sélectionner une heure';
    final time = selectedTime.value!;
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

