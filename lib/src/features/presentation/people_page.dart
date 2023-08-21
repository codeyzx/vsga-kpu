import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/constants/themes/palette.dart';
import 'package:kpu/src/features/domain/people.dart';
import 'package:kpu/src/features/presentation/people_controller.dart';
import 'package:kpu/src/features/presentation/people_state.dart';
import 'package:kpu/src/routes/routes.dart';
import 'package:kpu/src/shared/extensions/extensions.dart';

class PeoplePage extends ConsumerStatefulWidget {
  const PeoplePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PeoplePageState();
}

class _PeoplePageState extends ConsumerState<PeoplePage> {
  PeopleController get controller => ref.read(peopleControllerProvider.notifier);
  PeopleState get state => ref.watch(peopleControllerProvider);

  @override
  void didChangeDependencies() {
    safeRebuild(() {
      controller.getPeoples();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          if (state.peopleListValue.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (state.isLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state.peopleList.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada data',
                style: TypographyApp.headline2,
              ),
            );
          }
          return Column(
            children: [
              const TopBarFavoriteSection(),
              Gap.h20,
              Expanded(
                child: ListView.builder(
                  itemCount: state.peopleList.length,
                  padding: EdgeInsets.symmetric(horizontal: SizeApp.w32),
                  itemBuilder: (context, index) {
                    final people = state.peopleList[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          Routes.detail.name,
                          extra: Extras(
                            datas: {
                              'people': people,
                            },
                          ),
                        );
                      },
                      child: PeopleCardWidget(
                        people: people,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class PeopleCardWidget extends StatelessWidget {
  const PeopleCardWidget({
    Key? key,
    required this.people,
  }) : super(key: key);

  final People people;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Palette.color,
        boxShadow: [
          BoxShadow(
            color: Palette.color.shade200,
            blurRadius: 35,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      height: context.screenHeightPercentage(0.2),
      margin: EdgeInsets.only(
        bottom: SizeApp.h16,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.file(
              File(people.image),
              width: context.screenHeightPercentage(0.18),
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeApp.w8,
                vertical: SizeApp.h12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    people.fullname,
                    style: TypographyApp.headline2.white,
                  ),
                  Gap.h12,
                  Text(
                    people.nik,
                    style: TypographyApp.text1.white.light,
                  ),
                  Gap.h4,
                  Text(
                    people.address,
                    style: TypographyApp.text1.white,
                  ),
                  const Spacer(),
                  Text(
                    people.gender,
                    style: TypographyApp.text1.white.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBarFavoriteSection extends StatelessWidget {
  const TopBarFavoriteSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.chevron_left_rounded,
              color: ColorApp.black,
              size: SizeApp.h40,
            ),
          ),
          Expanded(
            child: Text('Informasi', style: TypographyApp.headline2),
          ),
        ],
      ),
    );
  }
}
