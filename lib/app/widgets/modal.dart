import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/tasks/viewmodel/tasks/list/bloc/tasks_bloc.dart';
import '../modules/tasks/viewmodel/tasks/list/bloc/tasks_event.dart';
import 'checkbox.dart';
import 'textfield.dart';

class Modal extends StatelessWidget {
  final BuildContext blocContext;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Modal({super.key, required this.blocContext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: CheckBoxComponent(onChanged: (value) {}),
                  ),
                  Expanded(
                    child: TextFieldComponent(
                      controller: titleController,
                      hintText: "What's in your mind?",
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Icon(
                      Icons.edit,
                      size: 28,
                      color: const Color.fromARGB(120, 110, 133, 150),
                    ),
                  ),
                  Expanded(
                    child: TextFieldComponent(
                      controller: descriptionController,
                      hintText: "Add a note",
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      BlocProvider.of<TaskBloc>(blocContext).add(
                        AddTask(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
