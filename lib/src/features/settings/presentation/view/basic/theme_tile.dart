import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/asset_helper/asset_helper.dart';
import '../../../../../core/shared/asset_helper/assets.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../../data/models/theme/theme_model.dart';
import '../../providers/theme_provider.dart';

class ThemeTile extends ConsumerWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: AssetHelper.createSvgAsset(assetPath: SvgAssets.theme),
      ),
      title: Text(
        t.theme,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: ToggleButtons(
        borderRadius: BorderRadius.circular(25.0),
        constraints: const BoxConstraints(minWidth: 48.0, minHeight: 36.0),
        isSelected: List.generate(
          ThemeProfile.values.length,
          (i) => ThemeProfile.values[i] == theme,
        ),
        selectedColor: context.theme.primaryColor,
        onPressed: (i) async => ref
            .read(themeProvider.notifier)
            .changeTheme(ThemeProfile.values[i]),
        children: List.generate(
          ThemeProfile.values.length,
          (i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: AssetHelper.createSvgAsset(
                assetPath: ThemeProfile.values[i].icon),
          ),
        ),
      ),
    );
  }
}
