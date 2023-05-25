import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/widgets/custom_list_tile.dart';

class EventsCard extends StatefulWidget {
  final List<String> images;
  final String eventName;
  final DateTime eventDate;
  final String eventDescription;
  final String eventLocation;
  final List<String> eventCoordinators;
  final String organiser;
  const EventsCard({
    super.key,
    required this.images,
    required this.eventName,
    required this.eventDate,
    required this.eventDescription,
    required this.eventLocation,
    required this.eventCoordinators,
    required this.organiser,
  });

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  final CarouselController _controller = CarouselController();

  List<Widget> caraouselImages = [];

  @override
  void initState() {
    super.initState();
    caraouselImages = widget.images
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          color: primaryColor,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CarouselSlider(
              items: caraouselImages,
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                '${widget.eventName} (${DateFormat.yMMMEd().format(widget.eventDate)})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: const EdgeInsets.all(defaultPadding / 2),
              subtitle: Text(
                widget.eventDescription,
                textAlign: TextAlign.justify,
              ),
              // trailing: const Icon(Icons.arrow_forward_ios, ),
            ),
            CustomListTile(
              title: "Organiser",
              subtitle: widget.organiser,
              icon: Icons.location_city,
            ),
            CustomListTile(
              title: "Region",
              subtitle: widget.eventLocation,
              icon: Icons.location_on,
            ),
            CustomListTile(
              title: "Coordinator",
              subtitle: widget.eventCoordinators.join(', '),
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
