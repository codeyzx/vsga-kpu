import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/features/presentation/widget/widget.dart';

class PeopleAddPage extends ConsumerWidget {
  const PeopleAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: CircleBackgroundWidget(
            child: PaddingWidget(
              child: Column(
                children: [
                  const Spacer(),
                  const TopBarWidget(),
                  Gap.h32,
                  const PeopleAddFormSection(),
                  Gap.h32,
                  const PeopleAddButtonSection(),
                  const Spacer(),
                  Gap.h36
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
