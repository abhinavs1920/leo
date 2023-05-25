import 'package:flutter/material.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_drawer.dart';
import 'package:leo/widgets/events_card.dart';

import '../utils/constants.dart';

final List<String> images = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
];

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Events",
        ),
        drawer: const CustomDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(defaultPadding),
          children: [
            EventsCard(
              images: images,
              eventName: "Orphan Meet",
              eventDate: DateTime.parse("2012-02-27 13:27:00"),
              eventDescription:
                  "This is a random long description of the event, the event was organised by so and so at so and so location and these were the guests overall it was great!",
              eventLocation: "Nepal",
              eventCoordinators: const ["Kunal Jain", "Priyanshu Jalan"],
              organiser: "Leo Club of Kathmandu",
            ),
            EventsCard(
              images: images,
              eventName: "Orphan Meet",
              eventDate: DateTime.parse("2012-02-27 13:27:00"),
              eventDescription:
                  "This is a random long description of the event, the event was organised by so and so at so and so location and these were the guests overall it was great!",
              eventLocation: "Nepal",
              eventCoordinators: const ["Kunal Jain", "Priyanshu Jalan"],
              organiser: "Leo Club of Kathmandu",
            ),
            EventsCard(
              images: images,
              eventName: "Orphan Meet",
              eventDate: DateTime.parse("2012-02-27 13:27:00"),
              eventDescription:
                  "This is a random long description of the event, the event was organised by so and so at so and so location and these were the guests overall it was great!",
              eventLocation: "Nepal",
              eventCoordinators: const ["Kunal Jain", "Priyanshu Jalan"],
              organiser: "Leo Club of Kathmandu",
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryColor,
              child: const Icon(Icons.download),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteEnums.addEventPage);
              },
              backgroundColor: primaryColor,
              child: const Icon(Icons.add),
            ),
          ],
        ));
    ;
  }
}
