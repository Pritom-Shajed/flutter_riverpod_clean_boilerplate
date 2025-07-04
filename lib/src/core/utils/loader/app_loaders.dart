import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/color/app_colors.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/extensions/extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class AppLoaders {
  static Widget spinningLines({Key? key, double? size, Color? color}) {
    return SpinKitThreeBounce(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget pulse({Key? key, double? size, Color? color}) {
    return SpinKitPulse(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget wave({Key? key, double? size, Color? color}) {
    return SpinKitWave(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget dancingSquare({Key? key, double? size, Color? color}) {
    return SpinKitDancingSquare(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget foldingCube({Key? key, double? size, Color? color}) {
    return SpinKitFoldingCube(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget cubeGrid({Key? key, double? size, Color? color}) {
    return SpinKitCubeGrid(
        key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget loaderWithText(
    BuildContext context, {
    String? text,
    LoaderDirection direction = LoaderDirection.vertical,
    Widget? loaderWidget,
  }) {
    return Center(
      child: direction == LoaderDirection.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 14,
              children: [
                loaderWidget ?? AppLoaders.dancingSquare(),
                Text(text ?? 'Loading...', style: context.text.bodySmall),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                loaderWidget ?? AppLoaders.spinningLines(size: 12),
                Text(text ?? 'Loading...', style: context.text.bodySmall),
              ],
            ),
    );
  }
}

enum LoaderDirection { horizontal, vertical }
