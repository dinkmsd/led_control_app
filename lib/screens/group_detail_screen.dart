import 'package:flutter/material.dart';
import 'package:led_control_app/components/led_info_item_widget.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/providers/group_setting_provider.dart';
import 'package:led_control_app/screens/group_setting_screen.dart';
import 'package:led_control_app/server/data_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class GroupDetailScreen extends StatefulWidget {
  final int groupIdx;
  const GroupDetailScreen({super.key, required this.groupIdx});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final DataService dataService = DataService();
  late DataProvider dataProvider;
  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              final nameTextController = TextEditingController();
              final latTextController = TextEditingController();
              final lonTextController = TextEditingController();
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
                            bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                          icon: const Icon(Icons.ios_share)),
                                    ],
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add Led',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomTextField(
                                      controller: nameTextController,
                                      hintText: 'Enter led name',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomTextField(
                                      controller: latTextController,
                                      hintText: 'Enter latitude',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomTextField(
                                      controller: lonTextController,
                                      hintText: 'Enter longitude',
                                    ),
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
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Add led handler
                                    dataService.addNewLed(
                                        context,
                                        nameTextController.text,
                                        double.parse(latTextController.text),
                                        double.parse(lonTextController.text),
                                        dataProvider
                                            .groups[widget.groupIdx].id);
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
                                      backgroundColor: const Color(0xFF007AFF),
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
            }),
        appBar: AppBar(
          title: Text(dataProvider.groups[widget.groupIdx].groupName),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (_) => GroupSettingProvider(
                              id: dataProvider.groups[widget.groupIdx].id,
                              token: dataProvider.token),
                          child: GroupSettingScreen(
                            onChangeStatus: (value) {
                              dataService.updateStatus(
                                  groupIdx: widget.groupIdx,
                                  status: value,
                                  context: context);
                            },
                            onDelete: (groupId) {
                              dataService.deleteGroup(groupId, context);
                            },
                            status: dataProvider.groups[widget.groupIdx].status,
                            id: dataProvider.groups[widget.groupIdx].id,
                          )),
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
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
            var items = state.groups[widget.groupIdx].leds;
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
                  return LedInfoItemWidget(
                      groupIdx: widget.groupIdx, ledIdx: index);
                });
          }),
        ));
  }
}
