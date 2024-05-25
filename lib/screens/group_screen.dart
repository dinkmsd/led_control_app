import 'package:flutter/material.dart';
import 'package:led_control_app/components/group_led_widget.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/server/data_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late UserProvider userProvider;
  final DataService dataService = DataService();

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Group'),
          actions: [
            IconButton(
                onPressed: () {
                  var dataProvider =
                      Provider.of<DataProvider>(context, listen: false);
                  final groupTextController = TextEditingController();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (BuildContext context) {
                      return ChangeNotifierProvider.value(
                        value: dataProvider,
                        child: Consumer<DataProvider>(
                            builder: (context, state, child) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15))),
                                  padding: contentPadding,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel')),
                                          IconButton(
                                              onPressed: () {},
                                              icon:
                                                  const Icon(Icons.ios_share)),
                                        ],
                                      ),
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Add Group',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: CustomTextField(
                                          controller: groupTextController,
                                          hintText: 'Enter led name',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        4,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Add Group handler
                                        dataService.addNewGroup(
                                            groupTextController.text, context);
                                        Navigator.of(context).pop();
                                      },
                                      label: const Text(
                                        "Add",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      icon: const Icon(
                                        Icons.add_box_outlined,
                                        color: Colors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF007AFF),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: contentPadding,
          child: Consumer<DataProvider>(builder: (context, state, child) {
            if (state.state == LoadingState.wating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.state == LoadingState.fail) {
              return Center(
                child: Column(
                  children: [
                    Text('Network Failed!!!'),
                    ElevatedButton(
                        onPressed: () {
                          state.loading();
                          dataService.getData(context: context);
                        },
                        child: Text('Reload'))
                  ],
                ),
              );
            }
            var items = state.groups;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Empty',
                ),
              );
            }
            return ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  return GroupLedWidget(groupIdx: index);
                });
          }),
        ));
  }
}
