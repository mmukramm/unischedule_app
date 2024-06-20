import 'dart:convert';

class PostByUser {
  final String? id;
  final String? title;
  final String? content;
  final String? organizer;
  final String? eventDate;
  final String? picture;
  final bool? isEvent;
  final bool? isRegistered;
  PostByUser({
    this.id,
    this.title,
    this.content,
    this.organizer,
    this.eventDate,
    this.isEvent,
    this.picture,
    this.isRegistered,
  });

  PostByUser copyWith({
    String? id,
    String? title,
    String? content,
    String? organizer,
    String? eventDate,
    bool? isEvent,
    String? picture,
    bool? isRegistered,
  }) {
    return PostByUser(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      organizer: organizer ?? this.organizer,
      eventDate: eventDate ?? this.eventDate,
      isEvent: isEvent ?? this.isEvent,
      picture: picture ?? this.picture,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'organizer': organizer,
      'eventDate': eventDate,
      'is_event': isEvent,
      'picture': picture,
      'is_registered': isRegistered,
    };
  }

  factory PostByUser.fromMap(Map<String, dynamic> map) {
    return PostByUser(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      organizer: map['organizer'] != null ? map['organizer'] as String : null,
      eventDate: map['eventDate'] != null ? map['eventDate'] as String : null,
      isEvent: map['is_event'] != null ? map['is_event'] as bool : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      isRegistered:
          map['is_registered'] != null ? map['is_registered'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostByUser.fromJson(String source) =>
      PostByUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostByUser(id: $id, title: $title, content: $content, organizer: $organizer, eventDate: $eventDate, isEvent: $isEvent, picture: $picture, isRegistered: $isRegistered)';
  }

  @override
  bool operator ==(covariant PostByUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.organizer == organizer &&
        other.eventDate == eventDate &&
        other.isEvent == isEvent &&
        other.picture == picture &&
        other.isRegistered == isRegistered;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        organizer.hashCode ^
        eventDate.hashCode ^
        isEvent.hashCode ^
        picture.hashCode ^
        isRegistered.hashCode;
  }
}
