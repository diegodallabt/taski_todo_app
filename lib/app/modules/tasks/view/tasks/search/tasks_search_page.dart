import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/widgets/bottom_navbar.dart';
import 'package:taski/app/widgets/checkbox.dart';
import 'package:taski/app/widgets/error.dart';
import 'package:taski/app/widgets/searchbar.dart';
import 'package:taski/app/widgets/skeleton.dart';

import '../../../../../utils/modal_utils.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/not_found.dart';
import '../../../viewmodel/bloc/tasks_bloc.dart';
import '../../../viewmodel/bloc/tasks_event.dart';
import '../../../viewmodel/bloc/tasks_state.dart';

class TasksSearchPage extends StatefulWidget {
  const TasksSearchPage({super.key});

  @override
  TasksSearchPageState createState() => TasksSearchPageState();
}

class TasksSearchPageState extends State<TasksSearchPage> {
  final Map<int, bool> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    Modular.get<TaskBloc>().add(SearchTasks(''));
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
            SearchBarComponent(),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                bloc: Modular.get<TaskBloc>(),
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Skeleton(
                      onlyTasksSkeleton: true,
                    );
                  } else if (state is TaskLoaded) {
                    final tasks = state.tasks;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NotFoundComponent(
                              message: "No tasks found.",
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final isExpanded = _expandedItems[index] ?? false;

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.4,
                                  child: CheckBoxComponent(onChanged: (value) {
                                    Modular.get<TaskBloc>()
                                        .add(UpdateTask(id: task.id!));
                                  }),
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
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (isExpanded)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              task.description ?? '',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 110, 133, 150),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _expandedItems[index] = !isExpanded;
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
                    );
                  } else if (state is TaskError) {
                    return ErrorComponent(message: state.message);
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NotFoundComponent(
                          message: "No tasks found.",
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
        currentIndex: 2,
        onCreate: showCreateTaskModal,
      ),
    );
  }
}
