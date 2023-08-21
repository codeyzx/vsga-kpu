import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/constants/themes/palette.dart';
import 'package:kpu/src/features/presentation/people_controller.dart';
import 'package:kpu/src/shared/extensions/extensions.dart';

class PeopleAddFormSection extends ConsumerWidget {
  const PeopleAddFormSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(peopleControllerProvider);
    final controller = ref.read(peopleControllerProvider.notifier);
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Entry',
            style: TypographyApp.headline1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap.h20,
          InputFormWidget(
            controller: controller.nikController,
            onChanged: (value) {},
            hintText: 'NIK',
            prefixIcon: Icons.person_outline_rounded,
            validator: controller.validate,
          ),
          Gap.h16,
          InputFormWidget(
            controller: controller.fullnameController,
            onChanged: (value) {},
            hintText: 'Full name',
            prefixIcon: Icons.person_outline_rounded,
            validator: controller.validate,
          ),
          Gap.h16,
          InputFormWidget(
            controller: controller.handphoneController,
            onChanged: (value) {},
            hintText: 'No. Hp',
            prefixIcon: Icons.person_outline_rounded,
            validator: controller.validate,
          ),
          Gap.h16,
          DropdownFormWidget(
            value: state.genderValue,
            list: state.gender,
            prefixIcon: Icons.person_outline_rounded,
            onChanged: (value) {
              if (value.isNotNull()) {
                controller.onRoleValueChanged(value);
              }
            },
          ),
          Gap.h16,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Palette.colorGray,
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () {
                controller.showDate(context);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.date == null ? 'Pilih Tanggal' : state.date!.toYyyyMMDd,
                      style: TypographyApp.text1.grey,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Palette.colorGray.shade400,
                  ),
                ],
              ),
            ),
          ),
          Gap.h16,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Palette.colorGray,
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () {
                controller.getCurrentLocation();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.address == '' ? 'Dapatkan Alamat' : state.address,
                      style: TypographyApp.text1.grey,
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Palette.colorGray.shade400,
                  ),
                ],
              ),
            ),
          ),
          Gap.h16,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Palette.colorGray,
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () {
                controller.addImage(context: context);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.image == '' ? 'Ambil Gambar' : 'Gambar Tersimpan',
                      style: TypographyApp.text1.grey,
                    ),
                  ),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Palette.colorGray.shade400,
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
