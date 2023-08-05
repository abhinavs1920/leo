import 'package:flutter/material.dart';
import 'package:leo/models/csmdata.model.dart';
import 'package:leo/services/csmdata.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class UnAuthDrawer extends StatelessWidget {
  const UnAuthDrawer({super.key});

  _launchURLBrowser(String url) async {
    ;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: CSMDataService().getCSMData(),
          builder: (BuildContext context, AsyncSnapshot<CSMData> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final csmData = snapshot.data;
              return Column(
                children: csmData!.sideDrawer
                    .map(
                      (item) => ListTile(
                        leading: const Icon(
                          Icons.download,
                        ),
                        title: Text(
                          item["title"],
                          style: textStyle,
                        ),
                        onTap: () async {
                          await _launchURLBrowser(item["url"]);
                        },
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      ],
    );
  }
}
