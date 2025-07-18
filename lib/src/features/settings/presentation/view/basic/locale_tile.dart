import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/asset_helper/asset_helper.dart';
import '../../../../../core/shared/asset_helper/assets.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../../data/models/locale/locale_model.dart';
import '../../providers/locale_provider.dart';

class LocaleTile extends StatelessWidget {
  const LocaleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: AssetHelper.createSvgAsset(assetPath: SvgAssets.language),
      ),
      title: Text(
        t.language,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: const Size(50, 48)),
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LocaleChangerPopup(),
        ),
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(
          builder: (_, ref, __) {
            final locale = ref.watch(localeProvider);
            return Text(
              locale.label,
              style:
                  context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
            );
          },
        ),
      ),
    );
  }
}

class LocaleChangerPopup extends StatelessWidget {
  const LocaleChangerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Language'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                LocaleProfile.values.length,
                (index) => Consumer(
                  builder: (_, ref, __) => KListTile(
                    onTap: () async => await ref
                        .read(localeProvider.notifier)
                        .changeLocale(LocaleProfile.values[index])
                        .then((_) {
                      if (!context.mounted) return;
                      context.pop();
                    }),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    leading: Radio<LocaleProfile?>(
                      value: LocaleProfile.values[index],
                      groupValue: ref.watch(localeProvider),
                      onChanged: (v) async => await ref
                          .read(localeProvider.notifier)
                          .changeLocale(v!)
                          .then((_) {
                        if (!context.mounted) return;
                        context.pop();
                      }),
                    ),
                    title: Text(LocaleProfile.values[index].label),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
