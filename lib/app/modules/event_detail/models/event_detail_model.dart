import 'package:flutter/material.dart';

class EventDetailModel {
  final String id;
  final String title;
  final String description;
  final String sport;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final String organizerId;
  final String organizerName;
  final String organizerAvatar;
  final int minParticipants;
  final int maxParticipants;
  final int currentParticipants;
  final List<EventParticipant> participants;
  final List<EventParticipant> waitingList;
  final bool isPublic;
  final String? difficultyLevel;
  final List<String> tags;
  final String? price;
  final String? imageUrl;
  final bool isUserJoined;
  final bool isUserInWaitingList;
  final String? userParticipationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sport,
    required this.location,
    required this.date,
    required this.time,
    required this.organizerId,
    required this.organizerName,
    required this.organizerAvatar,
    required this.minParticipants,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.participants,
    required this.waitingList,
    required this.isPublic,
    this.difficultyLevel,
    required this.tags,
    this.price,
    this.imageUrl,
    required this.isUserJoined,
    required this.isUserInWaitingList,
    this.userParticipationId,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isFull => currentParticipants >= maxParticipants;
  bool get hasSpotsAvailable => currentParticipants < maxParticipants;
  int get availableSpots => maxParticipants - currentParticipants;
  bool get canJoin => hasSpotsAvailable && !isUserJoined && !isUserInWaitingList;
}

class EventParticipant {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final DateTime joinedAt;
  final bool isOrganizer;

  EventParticipant({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.joinedAt,
    this.isOrganizer = false,
  });
}

