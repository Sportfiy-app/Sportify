import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ReportConfirmationArgs {
  const ReportConfirmationArgs({
    this.title,
    this.message,
    this.reference,
    this.emailNotice,
    this.steps = const [],
    this.actions = const [],
    this.countdownSeconds = 5,
    this.enableCountdown = true,
    this.redirectRoute,
  });

  final String? title;
  final String? message;
  final String? reference;
  final String? emailNotice;
  final List<ConfirmationStep> steps;
  final List<ConfirmationAction> actions;
  final int countdownSeconds;
  final bool enableCountdown;
  final String? redirectRoute;
}

class ConfirmationStep {
  const ConfirmationStep({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color = const Color(0xFF176BFF),
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
}

class ConfirmationAction {
  const ConfirmationAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? route;
}

class ReportConfirmationController extends GetxController {
  final RxInt countdown = 5.obs;
  final RxBool isAnimating = false.obs;

  late final String title;
  late final String message;
  late final bool autoRedirect;
  late final int countdownSeconds;
  late final String? reference;
  late final String? emailNotice;
  late final String? redirectRoute;
  late final List<ConfirmationStep> steps;
  late final List<ConfirmationAction> actions;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadArgs();
    _startAnimation();
    if (autoRedirect && countdownSeconds > 0) {
      _startCountdown();
    }
  }

  void _loadArgs() {
    final args = Get.arguments as ReportConfirmationArgs?;
    title = args?.title ?? 'Envoyé';
    message = args?.message ?? 'Votre signalement a bien été envoyé ! Il sera traité dans les plus brefs délais.';
    reference = args?.reference;
    emailNotice = args?.emailNotice;
    steps = args?.steps ?? const [];
    actions = args?.actions ?? const [];
    countdownSeconds = args?.countdownSeconds ?? 5;
    countdown.value = countdownSeconds;
    autoRedirect = args?.enableCountdown ?? true;
    redirectRoute = args?.redirectRoute;
  }

  void _startAnimation() {
    isAnimating.value = true;
    Future.delayed(const Duration(milliseconds: 1200), () {
      isAnimating.value = false;
    });
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        closeConfirmation();
      }
    });
  }

  void closeConfirmation() {
    _timer?.cancel();
    if (redirectRoute != null) {
      Get.offAllNamed(redirectRoute!);
      return;
    }
    if (Get.isOverlaysOpen) {
      Get.back();
    }
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    } else {
      Get.offAllNamed(Routes.profileBookings);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

