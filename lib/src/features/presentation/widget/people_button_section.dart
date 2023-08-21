import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/features/presentation/people_controller.dart';

class PeopleAddButtonSection extends ConsumerWidget {
  const PeopleAddButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(peopleControllerProvider);
    final controller = ref.read(peopleControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonWidget.primary(
          text: 'SUBMIT',
          onTap: controller.addPeople,
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
