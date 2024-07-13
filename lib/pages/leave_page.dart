import 'package:financial/blocs/leave/leave_bloc.dart';
import 'package:financial/pages/add_leave_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeavePage extends StatefulWidget {
  static const String routeName = '/financial'; // Add this line

  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  late LeaveBloc leaveBloc;

  final id = TextEditingController();

  @override
  void initState() {
    super.initState();
    leaveBloc = LeaveBloc()..add(FetchLeave());
  }

  @override
  void dispose() {
    leaveBloc.close();
    super.dispose();
  }

  void deleteLeave(String id) {
    leaveBloc.add(DeleteLeave(int.parse(id)));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          TextButton(
              onPressed: () {
                // i want go to ajuin cuti page and can return back , can we use  class name instead of path
                //navigor goto AddLeavePage()                 Navigator.pushNamed(AddLeavePage());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLeavePage(),
                  ),
                );
              },
              child: const Text('Ajuin Cuti')),
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight * 0.5,
            child: SingleChildScrollView(
              // make the column full width
              scrollDirection: Axis.vertical,

              // make the column scrollable
              // 1 bloc provider for each card
              // 2 bloc builder inside each card
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) => leaveBloc,
                    child: BlocBuilder<LeaveBloc, LeaveState>(
                      builder: (context, state) {
                        if (state is LeaveSuccess) {
                          return SizedBox(
                            width: screenWidth * 1,
                            child: Column(
                              children: state.leaves.map((leave) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: screenWidth * 1,
                                            child: Card(
                                              color: const Color.fromARGB(
                                                  255, 167, 212, 248),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      //take data from leave model date
                                                      //put 2 leave value id and date in 1 text
                                                      Text("${leave.name} "),
                                                      Text(" ${leave.email}"),
                                                      Text(leave.reason),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Start Date: ${leave.startdate.day}-${leave.startdate.month}-${leave.startdate.year}"),
                                                      Text(
                                                          "End Date: ${leave.enddate.day}-${leave.enddate.month}-${leave.enddate.year}"),

                                                      Text(
                                                          "Status : ${leave.status}"),
                                                      // Text(financial.note)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            deleteLeave(leave.id
                                                                .toString());
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        } else if (state is LeaveError) {
                          return Center(
                            child: Text('Error: ${state.e}'),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
