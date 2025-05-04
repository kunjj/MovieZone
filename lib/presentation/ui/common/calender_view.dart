import 'package:flutter/material.dart';

import '../../../../core/configs/themes/app_colors.dart';

DateTime globalFirstDate = DateTime(1950);

Future<DateTime?> pickDateDialog(
        {required BuildContext context,
        required DateTime initialDate,
        DateTime? firstDate,
        DateTime? lastDate}) =>
    showDatePicker(
            context: context,
            builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: AppColors.primaryBlue1,
                        onPrimary: AppColors.white,
                        onSurface: AppColors.black)),
                child: child!),
            initialDate: initialDate,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            firstDate: firstDate ?? globalFirstDate,
            lastDate: lastDate ?? DateTime.now())
        .then((pickedDate) => pickedDate);
