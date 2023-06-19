import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/models/events.model.dart';
import 'package:leo/models/user.model.dart';
import 'package:leo/services/events.service.dart';
import 'package:leo/services/user.service.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_drawer.dart';
import 'package:leo/widgets/events_card.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
      final description = event.description;
      final coordinator = event.coordinators.join(', ');
      final venue = event.venue;
      final date = DateFormat.yMMMEd().format(DateTime.parse(event.date));

      doc.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Expanded(
              child: pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(title, style: const pw.TextStyle(fontSize: 20)),
                    pw.SizedBox(height: 10),
                    pw.Image(image1, width: double.infinity),
                    pw.SizedBox(height: 40),
                    pw.Image(image2, width: double.infinity),
                    pw.SizedBox(height: 40),
                    pw.Text(description),
                    pw.SizedBox(height: 10),
                    pw.Text('Coordinator: $coordinator'),
                    pw.Text('Venue: $venue'),
                    pw.Text('Date: $date'),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel?>(context);
    return StreamBuilder(
      stream: EventsService(uid: auth?.uid ?? '').getAllEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final events = snapshot.data;
          return Scaffold(
            appBar: const CustomAppBar(
              title: "Events",
            ),
            endDrawer: const CustomDrawer(),
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
                  child: const Icon(Icons.download),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                FloatingActionButton(
                  heroTag: "addEventButton",
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final scaffoldMessgener = ScaffoldMessenger.of(context);
                    UserModel? user =
                        await UserService(uid: auth?.uid ?? '').getUserData();
                    if (user.role == 'club_member' ||
                        user.role == 'region_coordinator' ||
                        user.role == 'department_chairperson' ||
                        user.role == 'district_member') {
                      const snackBar = SnackBar(
                        content: Text('You are not authorized to add events'),
                      );
                      scaffoldMessgener.showSnackBar(snackBar);
                    } else {
                      navigator.pushNamed(RouteEnums.addEventPage);
                    }
                  },
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
