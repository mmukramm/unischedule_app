// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:unischedule_app/features/data/models/participant.dart';

class ActivityParticipant {
  final String? id;
  final String? title;
  final String? content;
  final String? organizer;
  final String? eventDate;
  final String? picture;
  final bool? isEvent;
  final List<Participant?>? participants;
  ActivityParticipant({
    this.id,
    this.title,
    this.content,
    this.organizer,
    this.eventDate,
    this.picture,
    this.isEvent,
    this.participants,
  });

  ActivityParticipant copyWith({
    String? id,
    String? title,
    String? content,
    String? organizer,
    String? eventDate,
    String? picture,
    bool? isEvent,
    List<Participant?>? participants,
  }) {
    return ActivityParticipant(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      organizer: organizer ?? this.organizer,
      eventDate: eventDate ?? this.eventDate,
      picture: picture ?? this.picture,
      isEvent: isEvent ?? this.isEvent,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'organizer': organizer,
      'eventDate': eventDate,
      'picture': picture,
      'is_event': isEvent,
      'participants': participants?.map((x) => x?.toMap()).toList(),
    };
  }

  factory ActivityParticipant.fromMap(Map<String, dynamic> map) {
    return ActivityParticipant(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      organizer: map['organizer'] != null ? map['organizer'] as String : null,
      eventDate: map['eventDate'] != null ? map['eventDate'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      isEvent: map['is_event'] != null ? map['is_event'] as bool : null,
      participants: map['participants'] != null
          ? List<Participant?>.from(
              (map['participants'] as List<dynamic>).map<Participant?>(
                (x) => Participant?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityParticipant.fromJson(String source) =>
      ActivityParticipant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActivityParticipant(id: $id, title: $title, content: $content, organizer: $organizer, eventDate: $eventDate, picture: $picture, isEvent: $isEvent, participants: $participants)';
  }

  @override
  bool operator ==(covariant ActivityParticipant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.organizer == organizer &&
        other.eventDate == eventDate &&
        other.picture == picture &&
        other.isEvent == isEvent &&
        listEquals(other.participants, participants);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        organizer.hashCode ^
        eventDate.hashCode ^
        picture.hashCode ^
        isEvent.hashCode ^
        participants.hashCode;
  }
}
