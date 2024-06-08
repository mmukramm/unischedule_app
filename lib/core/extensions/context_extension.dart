import 'package:flutter/material.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';


extension CustomSnackBarExtension on BuildContext {
  showCustomSnackbar({
    required String message,
    Color backgroundColor = primaryColor,
    Color textColor = scaffoldColor,
    SnackBarType type = SnackBarType.primary,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: type.textColor,
        ),
      ),
      backgroundColor: type.backgroundColor,
      duration: const Duration(milliseconds: 3000),
    );

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }
}

extension CustomDialogExtension on BuildContext {
  Future<Object?> showLoadingDialog() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const Loading(),
    );
  }

  Future<Object?> showCustomSelectorDialog({
    required String title,
    required String message,
    required List<SelectorDialogParams> items,
  }) {
    return showDialog(
      context: this,
      builder: (context) => CustomSelectorDialog(
        title: title,
        message: message,
        items: items,
      ),
    );
  }
}

