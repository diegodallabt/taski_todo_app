import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taski/app/widgets/bottom_navbar.dart';
import 'package:taski/app/widgets/skeleton.dart';

import '../../../../../utils/use_style.dart';
import '../../../viewmodel/tasks/list/bloc/tasks_bloc.dart';
import '../../../viewmodel/tasks/list/bloc/tasks_event.dart';
import '../../../viewmodel/tasks/list/bloc/tasks_state.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  TasksListPageState createState() => TasksListPageState();
}

class TasksListPageState extends State<TasksListPage> {
  final Map<int, bool> _expandedItems = {};
  final TextStyle headerLarge = GoogleFonts.inter(
    color: const Color.fromARGB(255, 43, 43, 43),
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<TaskBloc>()..add(LoadTasks()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.check_box, color: Colors.blue, size: 36),
                  SizedBox(width: 8),
                  Text(
                    'Taski',
                    style: useStyle(
                      TextStyle(
                        color: const Color.fromARGB(255, 43, 43, 43),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 14,
                children: [
                  Text(
                    'John',
                    style: useStyle(
                      TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.5,
                          color: const Color.fromARGB(255, 43, 43, 43)),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 228, 228, 228),
                    foregroundColor: const Color.fromARGB(255, 228, 228, 228),
                    backgroundImage:
                        NetworkImage('https://avatar.iran.liara.run/public'),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome, ',
                  style: useStyle(
                    TextStyle(
                      color: const Color.fromARGB(255, 43, 43, 43),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: 'John.',
                      style: useStyle(
                        TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return Skeleton();
                    } else if (state is TaskLoaded) {
                      return Column(
                        spacing: 30,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You've got ${state.tasks.length} tasks to do.",
                            style: useStyle(
                              TextStyle(
                                  color:
                                      const Color.fromARGB(255, 110, 133, 150),
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.tasks.length,
                              itemBuilder: (context, index) {
                                final task = state.tasks[index];
                                final isExpanded =
                                    _expandedItems[index] ?? false;

                                return Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
                                    child: Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: 1.4,
                                          child: Checkbox(
                                            visualDensity:
                                                VisualDensity.compact,
                                            side: BorderSide(
                                              width: 1.4,
                                              color: const Color.fromARGB(
                                                  120, 110, 133, 150),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            value: false,
                                            onChanged: (value) {},
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  task.title,
                                                  style: useStyle(
                                                    TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                if (isExpanded)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: Text(
                                                      task.description,
                                                      style: useStyle(
                                                        TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              110, 133, 150),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _expandedItems[index] =
                                                    !isExpanded;
                                              });
                                            },
                                            child: Icon(
                                              isExpanded
                                                  ? Icons.expand_less
                                                  : Icons.more_horiz,
                                              color: const Color.fromARGB(
                                                  255, 201, 201, 201),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is TaskError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text('No tasks available.'));
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbar(),
      ),
    );
  }
}
