import 'package:flutter/material.dart';
import 'package:leo/models/events.model.dart';
import 'package:leo/services/events.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/widgets/events_card.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventsModel>>(
      future: EventsService().getAllUserRoleFilteredEvents(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EventsModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final events = snapshot.data;
          return events!.isEmpty
              ? const Center(
                  child: Text(
                    'No events available',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(defaultPadding),
                  children: (events)
                      .map(
                        (event) => EventsCard(
                          images: event.images,
                          eventName: event.name,
                          eventDate: DateTime.parse(event.date),
                          eventDescription: event.description,
                          eventLocation: event.region,
                          eventCoordinators: event.coordinators,
                          organiser: event.organizer,
                          department: event.department,
                          venue: event.venue,
                          guests: event.guests,
                          participants: event.participants,
                          highlights: event.highlights,
                        ),
                      )
                      .toList(),
                );
        }
      },
    );
  }
}
