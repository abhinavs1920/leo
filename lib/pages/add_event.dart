import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:leo/widgets/chip_input.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_drawer.dart';

import '../utils/constants.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> coordinatorNameChips = [];
  List<String> guestNameChips = [];
  List<String> highlightChips = [];
  File? image;
  String fileName = '';
  String dropdownValue = list.first;

  final eventNameController = TextEditingController();
  final eventOrganizerController = TextEditingController();
  final regionController = TextEditingController();
  final coordinatorController = TextEditingController();
  final guestController = TextEditingController();
  final eventHighlightsController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventDepartmentController = TextEditingController();
  final peopleServedController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        fileName = imageTemp.toString().split('/').last;
      });

      print(imageTemp.toString().split('/').last);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void addCoordinatorChip(String value) {
    setState(() {
      coordinatorNameChips.add(value);
      coordinatorController.clear();
    });
  }

  void removeCoordinatorChip(String chip) {
    setState(() {
      coordinatorNameChips.remove(chip);
    });
  }

  void addGuestChip(String value) {
    setState(() {
      guestNameChips.add(value);
      guestController.clear();
    });
  }

  void removeGuestChip(String chip) {
    setState(() {
      guestNameChips.remove(chip);
    });
  }

  void addHighlightsChip(String value) {
    setState(() {
      highlightChips.add(value);
      eventHighlightsController.clear();
    });
  }

  void removeHighlightsChip(String chip) {
    setState(() {
      highlightChips.remove(chip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Event"),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: eventNameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event name',
                  labelText: 'Event Name',
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: eventOrganizerController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter you organization name',
                  labelText: 'Organization Name',
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: eventVenueController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event venue',
                  labelText: 'Event Venue',
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: eventDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event description',
                  labelText: 'Event Description',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: eventDepartmentController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event department',
                  labelText: 'Event Department',
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: peopleServedController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter number of people served',
                  labelText: 'People Served',
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: eventDateController,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event date',
                  labelText: 'Event Date',
                  alignLabelWithHint: true,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      eventDateController.text = formattedDate;
                    });
                  } else {}
                },
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text(fileName.isEmpty ? 'Upload Group Photo' : fileName),
              ),
              const SizedBox(height: defaultPadding),
              image != null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Image.file(
                        image!,
                        fit: BoxFit.contain,
                      ),
                      height: 200,
                    )
                  : Text(
                      "No image selected",
                    ),
              const SizedBox(height: defaultPadding),
              ChipInput(
                controller: coordinatorController,
                hintText: 'Enter coordinator names',
                labelText: 'Coordinator Names',
                nameList: coordinatorNameChips,
                onFieldSubmitted: addCoordinatorChip,
                onDeleted: removeCoordinatorChip,
              ),
              ChipInput(
                controller: guestController,
                hintText: 'Enter guest names',
                labelText: 'Guest Names',
                nameList: guestNameChips,
                onFieldSubmitted: addGuestChip,
                onDeleted: removeGuestChip,
              ),
              ChipInput(
                controller: eventHighlightsController,
                hintText: 'Enter event highlights',
                labelText: 'Event Highlights',
                nameList: highlightChips,
                onFieldSubmitted: addHighlightsChip,
                onDeleted: removeHighlightsChip,
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding * 3),
              ElevatedButton(
                onPressed: () async {},
                child: const Text('Submit Event'),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
