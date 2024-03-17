import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/components/schedule_widget.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:led_control_app/server/schedule_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleService scheduleService = ScheduleService();
  @override
  void initState() {
    scheduleService.getSchedule(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var pickedTime = DateFormat('hh:mm aa').format(DateTime.now());
          scheduleService.setTimer(
              context, DateFormat('hh:mm aa').format(DateTime.now()));
          final valueController = TextEditingController();
          var scheduleProvider =
              Provider.of<ScheduleProvider>(context, listen: false);
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            context: context,
            builder: (BuildContext context) {
              return ChangeNotifierProvider.value(
                value: scheduleProvider,
                child: Consumer<ScheduleProvider>(
                    builder: (context, state, child) {
                  return Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Cancel')),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.ios_share)),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add Schedule',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            TextButton(
                              onPressed: () async {
                                var selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ) ??
                                    TimeOfDay.now();
                                var selectedDateTime = DateTime(2024, 1, 1,
                                    selectedTime.hour, selectedTime.minute);

                                // ignore: use_build_context_synchronously
                                scheduleService.setTimer(
                                    context,
                                    DateFormat('hh:mm aa')
                                        .format(selectedDateTime));
                              },
                              child: Text(
                                scheduleService.getTimer(context),
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextField(
                                controller: valueController,
                                hintText: 'Enter value',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Add schedule handler
                              scheduleService.setSchedule(
                                  context, valueController.text);
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
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ScheduleProvider>(builder: (context, state, child) {
        if (state.state == LoadingState.success) {
          var items = state.schedules;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                // Each Dismissible must contain a Key. Keys allow Flutter to
                // uniquely identify widgets.
                key: Key(item.id),
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                onDismissed: (direction) {
                  // Remove the item from the data source
                  scheduleService.deleteSchedule(context, item.id);
                  setState(() {
                    items.removeAt(index);
                  });

                  // Then show a snackbar.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$item dismissed')));
                },
                // Show a red background as the item is swiped away.
                background: Container(color: Colors.red),
                child: ScheduleWidget(item: item),
              );
            },
            // itemBuilder: (context, index) =>
            //     scheduleItem(Schedule(time: DateTime(2024), value: 30)),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
