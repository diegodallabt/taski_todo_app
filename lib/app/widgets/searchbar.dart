import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../modules/tasks/viewmodel/bloc/tasks_bloc.dart';
import '../modules/tasks/viewmodel/bloc/tasks_event.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      onChanged: (value) {
        Modular.get<TaskBloc>().add(SearchTasks(value));
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: 'Search tasks',
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 110, 133, 150),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: _hasFocus
              ? Colors.blue
              : const Color.fromARGB(255, 110, 133, 150),
        ),
        suffixIcon: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            _textController.clear();
            Modular.get<TaskBloc>().add(SearchTasks(''));
          },
          child: Icon(
            FontAwesomeIcons.circleXmark,
            size: 20,
            color: const Color.fromARGB(255, 110, 133, 150),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: const Color.fromARGB(255, 110, 133, 150),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
