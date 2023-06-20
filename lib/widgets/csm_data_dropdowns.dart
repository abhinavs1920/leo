import 'package:flutter/material.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/models/user.model.dart';
import 'package:leo/services/user.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/string_utility.dart';
import 'package:provider/provider.dart';

class CSMDataDropdowns extends StatefulWidget {
  final String? selectedData;
  final String type;
  final List<dynamic> data;
  final Function(String, String) onChanged;
  const CSMDataDropdowns({
    super.key,
    required this.selectedData,
    required this.data,
    required this.type,
    required this.onChanged,
  });

  @override
  State<CSMDataDropdowns> createState() => _CSMDataDropdownsState();
}

class _CSMDataDropdownsState extends State<CSMDataDropdowns> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel?>(context);
    return FutureBuilder<Object?>(
      future: UserService(uid: auth?.uid ?? '').getUserData(),
      builder: (context, snapshot) {
        UserModel? userData = snapshot.data as UserModel?;
        if (snapshot.hasData) {
          return Column(
            children: [
              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: widget.selectedData,
                    hint: Text(
                      'Select ${widget.type.toCapitalized()}',
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    // value: csmData?.regions[0],
                    iconSize: 0.0,
                    items: widget.data
                        .map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<dynamic>(
                        value: value.toString(),
                        child: Center(
                          child: Text(
                            value.toString(),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      widget.onChanged(value.toString(), widget.type);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a ${widget.type.toCapitalized()}';
                      }
                      if (userData?.role == 'club_pvst') {
                        if (widget.type == 'region' &&
                            userData?.region != value) {
                          return 'Not authorized to add data for this region';
                        } else if (widget.type == 'organiser' &&
                            userData?.homeClub != value) {
                          return 'Not authorized to add data for this club';
                        } else {
                          return null;
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
            ],
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
