import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/asset_helper/asset_helper.dart';
import '../../../../../core/shared/asset_helper/assets.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../providers/performance_overlay_provider.dart';

class PerformanceOverlayTile extends StatelessWidget {
  const PerformanceOverlayTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child:
            AssetHelper.createSvgAsset(assetPath: SvgAssets.performanceOverlay),
      ),
      title: Text(
        t.performanceOverlay,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: Consumer(
          builder: (_, ref, __) => CupertinoSwitch(
            value: ref.watch(performanceOverlayProvider),
            onChanged: (v) async => await ref
                .read(performanceOverlayProvider.notifier)
                .changePerformanceOverlay(v),
          ),
        ),
      ),
    );
  }
}
