import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

import 'package:flutter_clean_architecture_template/src/localization/app_locale.dart';
import '../../repositories/hive_box.dart';

part 'locale_model.ext.dart';
part 'locale_model.g.dart';

@HiveType(typeId: HiveTypes.localeProfile)
enum LocaleProfile {
  @HiveField(0)
  english,
  @HiveField(1)
  bengali,
}
