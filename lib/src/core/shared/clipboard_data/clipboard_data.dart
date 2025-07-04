import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/toasts/app_toasts.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text)).then((_) {
    AppToasts.longToast(
      'Copied to clipboard! [$text]',
    );
  });
}

Future<String> getCliboardData() async {
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  return data?.text ?? '';
}
