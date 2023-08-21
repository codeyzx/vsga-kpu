import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/constants/themes/palette.dart';
import 'package:kpu/src/features/domain/people.dart';
import 'package:kpu/src/shared/extensions/extensions.dart';

class PeopleDetailPage extends ConsumerWidget {
  final People people;
  const PeopleDetailPage({
    super.key,
    required this.people,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
          // height: context.screenHeightPercentage(0.2),
          width: context.screenWidth,
          margin: EdgeInsets.symmetric(
            horizontal: SizeApp.w24,
            vertical: SizeApp.h40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    File(people.image),
                    width: context.screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  // CachedNetworkImage(
                  //   // imageUrl: People.imageUrl,
                  //   imageUrl: 'https://picsum.photos/200/300',
                  //   width: context.screenWidth,
                  //   fit: BoxFit.fitWidth,
                  // ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeApp.w32,
                    vertical: SizeApp.h20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NIK: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          Text(
                            people.nik,
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          Text(
                            people.fullname,
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          Text(
                            people.handphone,
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gender: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          Text(
                            people.gender,
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          Text(
                            DateTime.parse(people.createdAt).toYyyyMMDd,
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                        ],
                      ),
                      Gap.h16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Alamat: ',
                            style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                          ),
                          SizedBox(
                            width: context.screenWidthPercentage(0.4),
                            child: Text(
                              people.address,
                              style: TypographyApp.headline3.white.fontSizeCustom(20.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
