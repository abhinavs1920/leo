import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/static_data.dart';
import 'package:leo/widgets/name_card.dart';

class GetStartedPage extends StatelessWidget {
  static const Map<String, Object> metaData = StaticData.getStartedPage;
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    metaData["leoLogo"] as String,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    metaData["districtLogo"] as String,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                metaData["title"] as String,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 40),
              Column(
                children: (metaData["messages"] as List<Map<String, String>>)
                    .map(
                      (e) => NameCard(
                        name: e["name"]!,
                        message: e["message"]!,
                        imageUrl: e["imageUrl"]!,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).popAndPushNamed(RouteEnums.login)
                    },
                    child: Text(
                      metaData["btnText"] as String,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
