import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:unischedule_app/core/theme/colors.dart';

class Loading extends StatelessWidget {
  final Color color;
  final bool withScaffold;

  const Loading({
    super.key,
    this.color = secondaryTextColor,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: _buildLoading(),
          )
        : _buildLoading();
  }

  Widget _buildLoading() => Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: color, size: 60),
      );
}