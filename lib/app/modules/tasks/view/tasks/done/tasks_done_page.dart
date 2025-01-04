import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/widgets/bottom_navbar.dart';
import 'package:taski/app/widgets/checkbox.dart';
import 'package:taski/app/widgets/skeleton.dart';
import 'package:taski/app/widgets/textbutton.dart';

import '../../../../../utils/modal_utils.dart';
import '../../../../../utils/use_style.dart';
import '../../../../../widgets/error.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/not_found.dart';
import '../../../viewmodel/bloc/tasks_bloc.dart';
import '../../../viewmodel/bloc/tasks_event.dart';
import '../../../viewmodel/bloc/tasks_state.dart';

class TasksDonePage extends StatefulWidget {
  const TasksDonePage({super.key});

  @override
  TasksDonePageState createState() => TasksDonePageState();
}

class TasksDonePageState extends State<TasksDonePage> {
  @override
  void initState() {
    super.initState();
    Modular.get<TaskBloc>().add(LoadTasks(isCompleted: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Header(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Completed Tasks',
                  style: useStyle(
                    TextStyle(
                      color: const Color.fromARGB(255, 43, 43, 43),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButtonComponent(
                  onTap: () => Modular.get<TaskBloc>().add(DeleteAllTasks()),
                  color: Colors.redAccent,
                  label: 'Delete all',
                  fontSize: 17,
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                bloc: Modular.get<TaskBloc>(),
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Skeleton(
                      onlyTasksSkeleton: true,
                    );
                  } else if (state is TaskLoaded) {
                    return Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: state.tasks.isNotEmpty
                              ? ListView.builder(
                                  itemCount: state.tasks.length,
                                  itemBuilder: (context, index) {
                                    final task = state.tasks[index];

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
                                              child: CheckBoxComponent(
                                                  isDone: true,
                                                  onChanged: (value) {}),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                              FontWeight.w500,
                                                          color: const Color
                                                              .fromARGB(120,
                                                              110, 133, 150),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Modular.get<TaskBloc>().add(
                                                      DeleteTask(task.id!));
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                    spacing: 25,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NotFoundComponent(
                                        message:
                                            "You don't have any completed tasks.",
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    );
                  } else if (state is TaskError) {
                    return ErrorComponent(message: state.message);
                  }
                  return Center(
                    child: Column(
                      spacing: 25,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NotFoundComponent(
                          message:
                              "Complete the task to make it visible on the page.",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onCreate: showCreateTaskModal,
      ),
    );
  }
}
