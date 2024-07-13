import 'package:financial/blocs/leave/leave_bloc.dart';
import 'package:financial/models/leave_model.dart';
import 'package:financial/pages/leave_page.dart';
import 'package:flutter/material.dart';

class AddLeavePage extends StatefulWidget {
  const AddLeavePage({super.key});

  @override
  State<AddLeavePage> createState() => _AddLeavePageState();
}

class _AddLeavePageState extends State<AddLeavePage> {
  final startdateController = TextEditingController();
  //enddate , name , email, reason, status, note
  final enddateController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final reasonController = TextEditingController();
  final statusController = TextEditingController();
  final noteController = TextEditingController();

  late LeaveBloc financialBloc; // Declare the financialBloc variable

  @override
  void initState() {
    super.initState();
    financialBloc = LeaveBloc();
  }

  @override
  void dispose() {
    financialBloc.close();

    // Dispose the controllers
    startdateController.dispose();
    enddateController.dispose();
    nameController.dispose();
    emailController.dispose();
    reasonController.dispose();
    statusController.dispose();
    noteController.dispose();

    super.dispose();
  }

  void addLeave() {
    try {
      // Create a new LeaveModel object with the data from the text fields
      final financial = LeaveModel(
        id: 0,
        startdate: DateTime.parse(startdateController.text),
        enddate: DateTime.parse(enddateController.text),
        name: nameController.text,
        email: emailController.text,
        reason: reasonController.text,
        status: statusController.text,
        note: noteController.text,
      );
      financialBloc.add(AddLeave(financial));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LeavePage(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid input. Please check your data.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuin Cuti'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add text field for date startdate , enddate, name, email, reason, status, note

              //select date picker for start date and end date showDatepicker not using text field for start date and end date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        startdateController.text.isNotEmpty
                            ? DateTime(
                                    int.parse(startdateController.text
                                        .substring(0, 4)),
                                    int.parse(startdateController.text
                                        .substring(5, 7)),
                                    int.parse(startdateController.text
                                        .substring(8, 10)))
                                .toString()
                                .substring(0, 10)
                            : 'Select Start Date',
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              startdateController.text =
                                  picked.toString().substring(0, 10);
                            });
                          }
                        },
                        child: const Text('Change Start Date'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        enddateController.text.isNotEmpty
                            ? DateTime(
                                int.parse(
                                    enddateController.text.substring(0, 4)),
                                int.parse(
                                    enddateController.text.substring(5, 7)),
                                int.parse(
                                    enddateController.text.substring(8, 10)),
                              ).toString().substring(0, 10)
                            : 'Select End Date',
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              enddateController.text =
                                  picked.toString().substring(0, 10);
                            });
                          }
                        },
                        child: const Text('Change End Date'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(labelText: 'Reason'),
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                // when on pressed is clicked, it will call the addLeave function and print the data
                onPressed: addLeave,
                child: const Text('Ajuin Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
