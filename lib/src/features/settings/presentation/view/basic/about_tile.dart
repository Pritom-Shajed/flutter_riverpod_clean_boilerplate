import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/asset_helper/asset_helper.dart';
import '../../../../../core/shared/asset_helper/assets.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';

final infoProvider =
    FutureProvider((_) async => await PackageInfo.fromPlatform());

class AboutTile extends ConsumerWidget {
  const AboutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(infoProvider).value;
    final bn = info?.buildNumber == '0' ? '' : '(${info?.buildNumber})';
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: AssetHelper.createSvgAsset(assetPath: SvgAssets.about),
      ),
      title: Text(
        t.about,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: info == null ? null : Text('${t.appTitle} ${info.version}$bn'),
      onTap: () => showInfoDialog(context),
    );
  }
}

void showInfoDialog(BuildContext context) => showAboutDialog(
      context: context,
      applicationName: appName,
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 $appName. All rights reserved.',
      applicationIcon:
          Image.asset('assets/icons/app_icon.png', height: 48, width: 48),
      children: const [
        Text(
            '\nA simple app to manage your the activities of template and actualize your goals.'),
      ],
    );
