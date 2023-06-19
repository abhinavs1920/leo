class EventsModel {
  final String name;
  final String organizer;
  final String region;
  final String department;
  final String venue;
  final String date;
  final double peopleServed;
  final double participants;
  final String description;
  final double volunteerHour;
  final List<dynamic> guests;
  final List<dynamic> coordinators;
  final List<dynamic> highlights;
  final List<dynamic> images;

  EventsModel({
    required this.name,
    required this.organizer,
    required this.region,
    required this.department,
    required this.venue,
    required this.date,
    required this.peopleServed,
    required this.participants,
    required this.description,
    required this.volunteerHour,
    required this.guests,
    required this.coordinators,
    required this.highlights,
    required this.images,
  });
}
