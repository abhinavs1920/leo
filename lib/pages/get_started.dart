import 'package:flutter/material.dart';
import 'package:leo/models/csmdata.model.dart';
import 'package:leo/services/csmdata.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/static_data.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/name_card.dart';
import 'package:leo/widgets/unauth_drawer_wrapper.dart';

class GetStartedPage extends StatelessWidget {
  static const Map<String, Object> metaData = StaticData.getStartedPage;
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      endDrawer: UnAuthDrawerWrapper(),
      backgroundColor: primaryBackgroundColor,
      body: FutureBuilder(
        future: CSMDataService().getCSMData(),
        builder: (BuildContext context, AsyncSnapshot<CSMData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final csmData = snapshot.data;
            return csmData == null
                ? const Center(
                    child: Text('No data availale'),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                csmData.getStartedPageLeoLogo,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              Image.network(
                                csmData.getStartedPageDistrictLogo,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            csmData.getStartedPageTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 40),
                          Column(
                            children: csmData.getStartedPageMessages.map((e) {
                              return NameCard(
                                name: e["name"],
                                message: e["message"],
                                imageUrl: e["imageUrl"],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => {
                                  Navigator.of(context)
                                      .popAndPushNamed(RouteEnums.eventsPage)
                                },
                                child: Text(
                                  csmData.getStartedPageBtnText,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            csmData.getStartedPageFooterText,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}
