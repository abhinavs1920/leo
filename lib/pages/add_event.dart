import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/models/csmdata.model.dart';
import 'package:leo/services/csmdata.service.dart';
import 'package:leo/services/events.service.dart';
import 'package:leo/services/storage.service.dart';
import 'package:intl/intl.dart';
import 'package:leo/widgets/chip_input.dart';
import 'package:leo/widgets/csm_data_dropdowns.dart';
import 'package:leo/widgets/form_input.dart';
import 'package:nanoid/non_secure.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final Storage _storage = Storage();

  List<String> coordinatorNameChips = [];
  List<String> guestNameChips = [];
  List<String> highlightChips = [];
  String groupImageName = '';
  String bannerImageName = '';
  String? region;
  String? department;
  String? organiser;
  String groupPhotoUrl = '';
  String bannerPhotoUrl = '';
  bool _autovalidate = false;

  final eventNameController = TextEditingController();
  final coordinatorController = TextEditingController();
  final guestController = TextEditingController();
  final eventHighlightsController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final peopleServedController = TextEditingController();
  final volunteerHourController = TextEditingController();
  final participantsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> _createEvent(String uid) async {
    await EventsService(uid: uid).addEvent(
      eventNameController.text,
      organiser ?? '',
      region ?? '',
      department ?? '',
      eventVenueController.text,
      eventDateController.text,
      double.parse(peopleServedController.text),
      double.parse(participantsController.text),
      eventDescriptionController.text,
      double.parse(volunteerHourController.text),
      guestNameChips,
      coordinatorNameChips,
      highlightChips,
      [
        bannerPhotoUrl,
        groupPhotoUrl,
      ],
    );
    setState(
      () {
        eventNameController.clear();
        eventVenueController.clear();
        eventDateController.clear();
        peopleServedController.clear();
        participantsController.clear();
        eventDescriptionController.clear();
        volunteerHourController.clear();
        coordinatorNameChips.clear();
        guestNameChips.clear();
        highlightChips.clear();
        groupImageName = '';
        bannerImageName = '';
        groupPhotoUrl = '';
        bannerPhotoUrl = '';
      },
    );
  }

  Future<String> _uploadEventImage(trigger) async {
    final selectedImage = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (selectedImage == null) {
      return '';
    }

    final path = selectedImage.files.single.path;
    final name = nanoid();

    final url = await _storage.uploadImage(name, File(path!));
    setState(() {
      [trigger == 'group' ? groupImageName = path : bannerImageName = path];
      [trigger == 'group' ? groupPhotoUrl = url : bannerPhotoUrl = url];
    });
    return url;
  }

  void addChip(
      List<String> list, TextEditingController controller, String value) {
    setState(() {
      list.add(value);
      controller.clear();
    });
  }

  void removeChip(List<String> list, String chip) {
    setState(() {
      list.remove(chip);
    });
  }

  void setCSMData(String value, String type) {
    setState(() {
      if (type == 'region') {
        region = value;
      } else if (type == 'department') {
        department = value;
      } else {
        organiser = value;
      }
    });
  }

  @override
  void dispose() {
    eventNameController.dispose();
    eventVenueController.dispose();
    eventDateController.dispose();
    peopleServedController.dispose();
    participantsController.dispose();
    eventDescriptionController.dispose();
    volunteerHourController.dispose();
    coordinatorController.dispose();
    guestController.dispose();
    eventHighlightsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    eventDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel?>(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Event"),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: ListView(
            children: [
              CustomFormInput(
                controller: eventNameController,
                hintText: 'Enter event name',
                labelText: 'Event Name',
                listOfTextInputFormatters: [],
                isNumber: false,
              ),
              CustomFormInput(
                controller: eventVenueController,
                hintText: 'Enter event venue',
                labelText: 'Event Venue',
                listOfTextInputFormatters: [],
                isNumber: false,
              ),
              TextFormField(
                controller: eventDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Enter event description',
                  labelText: 'Event Description',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: defaultPadding),
              FutureBuilder<Object?>(
                future: CSMDataService().getCSMData(),
                builder: (context, snapshot) {
                  CSMData? csmData = snapshot.data as CSMData?;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CSMDataDropdowns(
                          selectedData: region,
                          data: csmData?.regions as List<dynamic>,
                          type: 'region',
                          onChanged: setCSMData,
                        ),
                        CSMDataDropdowns(
                          selectedData: department,
                          data: csmData?.departments as List<dynamic>,
                          type: 'department',
                          onChanged: setCSMData,
                        ),
                        CSMDataDropdowns(
                          selectedData: organiser,
                          data: csmData?.organisers as List<dynamic>,
                          type: 'organiser',
                          onChanged: setCSMData,
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              CustomFormInput(
                controller: peopleServedController,
                hintText: 'Enter number of people served',
                labelText: 'People Served',
                listOfTextInputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                isNumber: true,
              ),
              CustomFormInput(
                controller: volunteerHourController,
                hintText: 'Enter volunteer hours',
                labelText: 'Volunteer Hours',
                listOfTextInputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                isNumber: true,
              ),
              CustomFormInput(
                controller: participantsController,
                hintText: 'Enter event participants',
                labelText: 'Event Participants',
                listOfTextInputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                isNumber: true,
              ),
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
              groupImageName.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      height: 200,
                      child: Image.network(
                        groupPhotoUrl,
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Text(
                      "No image selected",
                    ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {
                  _uploadEventImage("group");
                },
                child: Text(groupImageName.isEmpty
                    ? 'Upload Group Photo'
                    : groupImageName.split("/").last),
              ),
              const SizedBox(height: defaultPadding),
              bannerImageName.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      height: 200,
                      child: Image.network(
                        bannerPhotoUrl,
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Text(
                      "No image selected",
                    ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {
                  _uploadEventImage("banner");
                },
                child: Text(bannerImageName.isEmpty
                    ? 'Upload Banner Photo'
                    : bannerImageName.split("/").last),
              ),
              const SizedBox(height: defaultPadding),
              ChipInput(
                controller: coordinatorController,
                hintText: 'Enter coordinator names',
                labelText: 'Coordinator Names',
                nameList: coordinatorNameChips,
                onFieldSubmitted: (value) => addChip(
                  coordinatorNameChips,
                  coordinatorController,
                  value,
                ),
                onDeleted: (value) => removeChip(
                  coordinatorNameChips,
                  value,
                ),
              ),
              ChipInput(
                controller: guestController,
                hintText: 'Enter guest names',
                labelText: 'Guest Names',
                nameList: guestNameChips,
                onFieldSubmitted: (value) => addChip(
                  guestNameChips,
                  guestController,
                  value,
                ),
                onDeleted: (value) => removeChip(
                  guestNameChips,
                  value,
                ),
              ),
              ChipInput(
                controller: eventHighlightsController,
                hintText: 'Enter event highlights',
                labelText: 'Event Highlights',
                nameList: highlightChips,
                onFieldSubmitted: (value) => addChip(
                  highlightChips,
                  eventHighlightsController,
                  value,
                ),
                onDeleted: (value) => removeChip(
                  highlightChips,
                  value,
                ),
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding * 3),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await _createEvent(authModel?.uid ?? "");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all the fields'),
                      ),
                    );
                  }
                },
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
