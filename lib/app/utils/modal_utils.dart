import 'package:flutter/material.dart';
import 'package:taski/app/widgets/modal.dart';

void showCreateTaskModal(BuildContext context) {
  final blocContext = context;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Modal(blocContext: blocContext);
    },
  );
}
