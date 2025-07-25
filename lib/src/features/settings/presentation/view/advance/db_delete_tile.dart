import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/asset_helper/asset_helper.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/asset_helper/assets.dart';

import '../../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../../data/repositories/hive_repository_impl.dart';

class DBDeleteTile extends StatelessWidget {
  const DBDeleteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AssetHelper.createSvgAsset(assetPath: SvgAssets.delete)),
      ),
      title: Text(
        t.deleteDatabase,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => DeleteDatabaseWarningPopup(
          onPressed: () async => await HiveRepositoryImpl().delete(),
        ),
      ),
    );
  }
}

class DeleteDatabaseWarningPopup extends StatelessWidget {
  const DeleteDatabaseWarningPopup({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Warning'),
        content: SizedBox(
          width: min(context.width * 0.8, 400.0),
          child: const Text(
              'Are you sure you want to delete database? This will delete all your data and this action is irreversible. This will also close the app. You will have to manually start the app to use it again.'),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: context.theme.dividerColor.withValues(alpha: 0.8)),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'DELETE',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
