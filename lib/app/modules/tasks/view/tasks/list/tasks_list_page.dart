import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/widgets/bottom_navbar.dart';
import 'package:taski/app/widgets/button.dart';
import 'package:taski/app/widgets/checkbox.dart';
import 'package:taski/app/widgets/skeleton.dart';

import '../../../../../utils/modal_utils.dart';
import '../../../../../utils/use_style.dart';
import '../../../../../widgets/error.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/not_found.dart';
import '../../../viewmodel/bloc/tasks_bloc.dart';
import '../../../viewmodel/bloc/tasks_event.dart';
import '../../../viewmodel/bloc/tasks_state.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  TasksListPageState createState() => TasksListPageState();
}

class TasksListPageState extends State<TasksListPage> {
  final Map<int, bool> _expandedItems = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Modular.get<TaskBloc>().add(LoadTasks(isCompleted: false));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final bloc = Modular.get<TaskBloc>();
        final state = bloc.state;

        if (state is TaskLoaded && state.hasMore && !state.isLoadingMore) {
          bloc.add(LoadMoreTasks(isCompleted: false));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                bloc: Modular.get<TaskBloc>(),
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Skeleton();
                  } else if (state is TaskLoaded) {
                    return Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.tasks.isNotEmpty
                              ? "You've got ${state.totalTasks} tasks to do."
                              : "Create tasks to achieve more.",
                          style: useStyle(
                            TextStyle(
                                color: const Color.fromARGB(255, 110, 133, 150),
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                          child: state.totalTasks != 0
                              ? ListView.builder(
                                  controller: _scrollController,
                                  itemCount: state.tasks.length +
                                      (state.isLoadingMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == state.tasks.length &&
                                        state.isLoadingMore) {
                                      return Center(
                                        child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    }

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
                                              child: CheckBoxComponent(
                                                  onChanged: (value) {
                                                Modular.get<TaskBloc>().add(
                                                    UpdateTask(id: task.id!));
                                              }),
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
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    if (isExpanded)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10.0),
                                                        child: Text(
                                                          task.description ??
                                                              '',
                                                          style: useStyle(
                                                            TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  110,
                                                                  133,
                                                                  150),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                )
                              : Center(
                                  child: Column(
                                    spacing: 25,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NotFoundComponent(
                                        message: "You have no task listed.",
                                      ),
                                      ButtonComponent(
                                        onTap: () =>
                                            showCreateTaskModal(context),
                                        label: 'Create Task',
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
                          message: "You have no task listed.",
                        ),
                        ButtonComponent(
                          onTap: () => showCreateTaskModal(context),
                          label: 'Create Task',
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
        currentIndex: 0,
        onCreate: showCreateTaskModal,
      ),
    );
  }
}
