import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/asset_helper/asset_helper.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/asset_helper/assets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../config/constants.dart';

class MaintenanceBreak extends StatelessWidget {
  const MaintenanceBreak({super.key});

  static const name = 'maintenance-break';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetHelper.createSvgAsset(
                assetPath: SvgAssets.error,
                width: size.height * 0.22,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'We are under maintenance.',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                  textScaler: TextScaler.linear(1.4),
                ),
              ),
              const Text(
                'We will be back soon.',
                textScaler: TextScaler.linear(1.1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () async =>
                      await launchUrl(Uri.parse('http://pritomshajed.com')),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Row(
                      mainAxisSize: mainMin,
                      children: [
                        const Icon(Icons.engineering),
                        const SizedBox(width: 10.0),
                        Text(
                          t.contactWithAdmin,
                          textScaler: const TextScaler.linear(0.8),
                        ),
                      ],
                    ),
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
