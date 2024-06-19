import 'package:flutter/material.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/keys.dart';

class CustomConfirmationDeleteDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTapDeleteButton;

  const CustomConfirmationDeleteDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onTapDeleteButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: scaffoldColor,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 32,
      ),
      shape: const RoundedRectangleBorder(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: textTheme.headlineSmall!.copyWith(
                          fontSize: 20,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        navigatorKey.currentState!.pop();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: dangerColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: scaffoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onTapDeleteButton,
                      style: FilledButton.styleFrom(
                        backgroundColor: dangerColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text(
                        'Hapus',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
