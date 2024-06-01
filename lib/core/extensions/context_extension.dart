import 'package:flutter/material.dart';
import 'package:unischedule_app/features/presentation/widget/custom_selector_dialog.dart';
import 'package:unischedule_app/features/presentation/widget/loading.dart';

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
