import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:leo/models/events.model.dart';
import 'package:printing/printing.dart';

class EventsService {
  final String? uid;
  EventsService({this.uid});

  final CollectionReference _eventsCollection =
      FirebaseFirestore.instance.collection('events');

  //add event
  Future<DocumentReference> addEvent(
    String name,
    String organizer,
    String region,
    String department,
    String venue,
    String date,
    double peopleServed,
    double participants,
    String description,
    double volunteerHour,
    List<String> guests,
    List<String> coordinators,
    List<String> highlights,
    List<String> images,
  ) async {
    return await _eventsCollection.add(
      {
        'name': name,
        'organizer': organizer,
        'region': region,
        'department': department,
        'venue': venue,
        'date': date,
        'peopleServed': peopleServed,
        'participants': participants,
        'description': description,
        'volunteerHour': volunteerHour,
        'guests': guests,
        'coordinators': coordinators,
        'highlights': highlights,
        'images': images,
        'createdBy': uid,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  EventsModel _eventFromDocument(DocumentSnapshot doc) {
    return EventsModel(
      name: (doc.data() as dynamic)['name'] ?? '',
      organizer: (doc.data() as dynamic)['organizer'] ?? '',
      region: (doc.data() as dynamic)['region'] ?? '',
      department: (doc.data() as dynamic)['department'] ?? '',
      venue: (doc.data() as dynamic)['venue'] ?? '',
      date: (doc.data() as dynamic)['date'] ?? '',
      peopleServed: (doc.data() as dynamic)['peopleServed'] ?? 0,
      participants: (doc.data() as dynamic)['participants'] ?? 0,
      description: (doc.data() as dynamic)['description'] ?? '',
      volunteerHour: (doc.data() as dynamic)['volunteerHour'] ?? 0,
      guests: (doc.data() as dynamic)['guests'] ?? [],
      coordinators: (doc.data() as dynamic)['coordinators'] ?? [],
      highlights: (doc.data() as dynamic)['highlights'] ?? [],
      images: (doc.data() as dynamic)['images'] ?? [],
    );
  }

  //get all events
  Stream<List<EventsModel>> get getAllEvents {
    return _eventsCollection.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map(_eventFromDocument).toList(),
        );
  }

  Future<List<EventsModel>> getAllUserRoleFilteredEvents() async {
    // final user = await UserService(uid: uid).getUserData();
    //filter events data based on user role
    // if (user.role.contains('club')) {
    //   final querySnapshot = await _eventsCollection
    //       .where('organizer', isEqualTo: user.homeClub)
    //       .get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // } else if (user.role.contains('region')) {
    //   final querySnapshot =
    //       await _eventsCollection.where('region', isEqualTo: user.region).get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // } else if (user.role.contains('department')) {
    //   final querySnapshot = await _eventsCollection
    //       .where('department', isEqualTo: user.department)
    //       .get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // }

    final querySnapshot = await _eventsCollection.get();
    return querySnapshot.docs.map(_eventFromDocument).toList();
  }

  Future<List<EventsModel>> getAllUserRoleFilteredEventsDateFilter(DateTime _date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(_date);
    final querySnapshot = await _eventsCollection
        .where('date', isEqualTo: formattedDate)
        .get();

    return querySnapshot.docs.map(_eventFromDocument).toList();
  }



  //get events list of a user
  Stream<List<QueryDocumentSnapshot<Object?>>> get getUserEvents {
    return _eventsCollection.where('createdBy', isEqualTo: uid).snapshots().map(
          (event) => event.docs,
        );
  }
}
