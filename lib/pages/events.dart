import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:leo/models/auth.model.dart';
import 'package:leo/models/events.model.dart';
// import 'package:leo/models/user.model.dart';
import 'package:leo/services/events.service.dart';
// import 'package:leo/services/user.service.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/string_utility.dart';
import 'package:leo/widgets/custom_appbar.dart';
// import 'package:leo/widgets/custom_drawer.dart';
import 'package:leo/widgets/events_card.dart';
import 'package:leo/widgets/unauth_drawer_wrapper.dart';
// import 'package:leo/widgets/unauth_drawer_wrapper.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';

import '../utils/constants.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _bottomNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Future<void> downloadPDF(List<EventsModel> events) async {
    final doc = pw.Document();
    // Add front page
    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Secretary Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Leo District Council 325 I, Nepal',
                  style: const pw.TextStyle(fontSize: 18),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );

    // Add individual pages for each dictionary entry
    for (var event in events) {
      final title = event.name;
      final image1 = await networkImage(event.images[0]);
      final image2 = await networkImage(event.images[1]);
      final description =
          '${event.description} \n\nThe event was held at ${event.venue}. It was graced by the presence of ${event.guests.join(', ')}, who attended as special ${event.guests.length > 1 ? 'guests' : 'guest'}. The event had a total of ${event.participants.toInt()} participants, and it showcased various highlights such as ${event.highlights.join(', ')}.';
      final coordinator = event.coordinators.join(', ');
      final venue = event.venue;
      final department = event.department;
      final date = DateFormat.yMMMEd().format(DateTime.parse(event.date));

      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Expanded(
              child: pw.Center(
                child: pw.Column(
                  children: [
                    pw.SizedBox(height: 40),
                    pw.Text(title, style: const pw.TextStyle(fontSize: 20)),
                    pw.SizedBox(height: 40),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Image(
                            image1,
                            width: 200,
                          ),
                          pw.Image(image2, width: 200),
                        ]),
                    pw.SizedBox(height: 40),
                    pw.Text(description),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      width: double.infinity,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Date: $date'),
                          pw.Text('Venue: $venue'),
                          pw.Text('Department: ${department.toCapitalized()}'),
                          pw.Text('Coordinator: $coordinator'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthModel?>(context);
    // return auth == null
    //     ? const Scaffold(
    //         appBar: CustomAppBar(
    //           title: "Events",
    //         ),
    //         endDrawer: UnAuthDrawerWrapper(),
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       )
    // :
    return FutureBuilder<List<EventsModel>>(
      future: EventsService().getAllUserRoleFilteredEvents(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EventsModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: CustomAppBar(
              title: "Events",
            ),
            endDrawer: UnAuthDrawerWrapper(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final events = snapshot.data;
          return Scaffold(
            appBar: const CustomAppBar(
              title: "Events",
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.indigo,
              currentIndex: _bottomNavIndex,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event,
                    // color: primaryColor,
                  ),
                  activeIcon: Icon(
                    Icons.event,
                    color: Colors.indigo,
                  ),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),
                  label: 'Posts',
                  activeIcon: Icon(
                    Icons.post_add,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            endDrawer: const UnAuthDrawerWrapper(),
            body: events!.isEmpty
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
                  ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "downloadButton",
                  onPressed: () async {
                    await downloadPDF(events);
                  },
                  backgroundColor: primaryColor,
                  child: Icon(Icons.download),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                FloatingActionButton(
                  heroTag: "addEventButton",
                  onPressed: () {
                    final navigator = Navigator.of(context);
                    // final scaffoldMessgener = ScaffoldMessenger.of(context);
                    // UserModel? user =
                    //     await UserService(uid: auth?.uid ?? '').getUserData();
                    // if (user.role == 'club_member' ||
                    //     user.role == 'region_coordinator' ||
                    //     user.role == 'department_chairperson' ||
                    //     user.role == 'district_member') {
                    //   const snackBar = SnackBar(
                    //     content: Text('You are not authorized to add events'),
                    //   );
                    //   scaffoldMessgener.showSnackBar(snackBar);
                    // } else {
                    navigator.pushNamed(RouteEnums.login);
                    // }
                  },
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
