import 'package:flutter/material.dart';
import 'package:random_users_app/data/models/users_params_model.dart';
import 'package:random_users_app/data/repositories/get_users_repositories.dart';
import 'package:random_users_app/presentation/home_page/widgets/custom_dropdown_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> genderItems = ['male', 'female'];
  String selectedValue = 'male';

  List<String> countItems = [for (var i = 1; i < 50; i++) i.toString()];
  String selectedCount = '10';

  Future<void>? _launched;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomDropdownButton(
                      hintalue: 'gender',
                      selectedValue: selectedValue,
                      genderItems: genderItems,
                      onSelectedValueChanged: (String value) {
                        selectedValue = value;
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomDropdownButton(
                      hintalue: 'count',
                      selectedValue: selectedCount,
                      genderItems: countItems,
                      onSelectedValueChanged: (String value) {
                        selectedCount = value;
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: GetUsersRepositories().getUsers(
                    model: UsersParamsModel(
                      results: int.tryParse(selectedCount),
                      gender: selectedValue,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator.adaptive(),
                          ],
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.results?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                _launched = _launchUrl(
                                  Uri(
                                    scheme: 'https',
                                    host: 'maps.google.com',
                                    queryParameters: {
                                      "q":
                                          "${snapshot.data?.results?[index].location?.coordinates?.latitude},${snapshot.data?.results?[index].location?.coordinates?.longitude}"
                                    },
                                  ),
                                );
                                debugPrint('Card tapped.');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data?.results?[index].picture
                                                  ?.large ??
                                              '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 250,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                        "${snapshot.data?.results?[index].name?.title}.${snapshot.data?.results?[index].name?.first} ${snapshot.data?.results?[index].name?.last}"),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data?.results?[index].location?.street?.number} ${snapshot.data?.results?[index].location?.street?.name}",
                                        ),
                                        Text(
                                          "${snapshot.data?.results?[index].location?.city}, ${snapshot.data?.results?[index].location?.country}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
