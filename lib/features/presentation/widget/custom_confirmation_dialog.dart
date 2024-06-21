import 'package:flutter/material.dart';

import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final bool withCloseButton;
  final VoidCallback onTapPrimaryButton;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.withCloseButton = true,
    required this.onTapPrimaryButton,
    required this.primaryButtonText,
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
                    if (withCloseButton)
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
                      onPressed: onTapPrimaryButton,
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        primaryButtonText,
                        style: textTheme.titleMedium!
                            .copyWith(color: secondaryTextColor),
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
