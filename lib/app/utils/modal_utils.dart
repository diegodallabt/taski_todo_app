import 'package:flutter/material.dart';

import '../widgets/modal.dart';

void showCreateTaskModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => Modal(),
  );
}
