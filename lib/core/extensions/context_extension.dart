import 'package:flutter/material.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/enums/snack_bar_type.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/custom_confirmation_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/no_internet_connection_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/custom_confirmation_delete_dialog.dart';

extension CustomSnackBarExtension on BuildContext {
  showCustomSnackbar({
    required String message,
    Color backgroundColor = primaryColor,
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

  Future<Object?> showCustomConfirmationDeleteDialog({
    required String title,
    required String message,
    required VoidCallback onTapDeleteButton,
  }) {
    return showDialog(
      context: this,
      builder: (context) => CustomConfirmationDeleteDialog(
        title: title,
        message: message,
        onTapDeleteButton: onTapDeleteButton,
      ),
    );
  }

  Future<Object?> showCustomConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onTapPrimaryButton,
    required String primaryButtonText,
    bool withCloseButton = true,
  }) {
    return showDialog(
      context: this,
      builder: (context) => CustomConfirmationDialog(
        title: title,
        message: message,
        withCloseButton: withCloseButton,
        onTapPrimaryButton: onTapPrimaryButton,
        primaryButtonText: primaryButtonText,
      ),
    );
  }

  Future<Object?> showServerErrorDialog({
    required String title,
    required String message,
    required VoidCallback onTapPrimaryButton,
    required String primaryButtonText,
    bool withCloseButton = true,
  }) {
    return showDialog(
      context: this,
      builder: (context) => CustomConfirmationDialog(
        title: title,
        message: message,
        withCloseButton: withCloseButton,
        onTapPrimaryButton: onTapPrimaryButton,
        primaryButtonText: primaryButtonText,
      ),
    );
  }

  Future<Object?> showNoInternetConnectionDialog({
    required String title,
    required String message,
    required VoidCallback onTapPrimaryButton,
    required String primaryButtonText,
    bool withCloseButton = true,
  }) {
    return showDialog(
      context: this,
      builder: (context) => NoInternetConnectionDialog(
        title: title,
        message: message,
        withCloseButton: withCloseButton,
        onTapPrimaryButton: onTapPrimaryButton,
        primaryButtonText: primaryButtonText,
      ),
    );
  }
}
