import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/routes/routes.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
                  const Center(
                    child: Text('KPU',
                        style: TextStyle(
                          fontSize: 62,
                          fontWeight: FontWeight.bold,
                          color: ColorApp.primary,
                        )),
                  ),
                  Gap.h32,
                  ButtonWidget.primary(
                    text: 'Informasi',
                    onTap: () {
                      context.pushNamed(Routes.people.name);
                    },
                  ),
                  Gap.h32,
                  ButtonWidget.primary(
                    text: 'Form Entry',
                    onTap: () {
                      context.pushNamed(Routes.peopleAdd.name);
                    },
                  ),
                  Gap.h32,
                  ButtonWidget.primary(
                    text: 'Lihat Data',
                    onTap: () {
                      context.pushNamed(Routes.people.name);
                    },
                  ),
                  Gap.h32,
                  ButtonWidget.outlined(
                    text: 'Keluar',
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
