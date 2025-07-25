import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/base/model/auth_store.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/config/get_platform.dart';
import '../../../../core/utils/logger/logger_helper.dart';
import '../../../../injector.dart';
import '../../domain/repositories/hive_repository.dart';
import '../models/locale/locale_model.dart';
import '../models/settings_model.dart';
import '../models/theme/theme_model.dart';
import 'hive_box.dart';

class HiveRepositoryImpl implements HiveRepository {
  @override
  Future<void> init() async {
    await _initDir();
    await _initHiveDB();
  }

  @override
  Future<void> delete() async {
    log.i('Deleting Database : ${sl<AppDir>().db}');
    await _clearAllBoxes();
    await _closeAllBoxes();
    await _deleteAllBoxes();
    await sl<AppDir>().root.delete(recursive: true);
    exit(0);
  }

  Future<void> _initDir() async {
    if (sl<PT>().isWeb) return;
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    sl<AppDir>().root = Directory(join(dir.path, '.template'));
    sl<AppDir>().db = Directory(join(sl<AppDir>().root.path, 'db'));
    sl<AppDir>().backup = Directory(join(sl<AppDir>().root.path, 'backup'));
    sl<AppDir>().files = Directory(join(sl<AppDir>().root.path, 'files'));
    if (!sl<AppDir>().root.existsSync())
      sl<AppDir>().root.createSync(recursive: true);
    if (!sl<AppDir>().db.existsSync())
      sl<AppDir>().db.createSync(recursive: true);
    if (!sl<AppDir>().backup.existsSync())
      sl<AppDir>().backup.createSync(recursive: true);
    if (!sl<AppDir>().files.existsSync())
      sl<AppDir>().files.createSync(recursive: true);
    log.i('App Directory: ${sl<AppDir>().root.path}');
  }

  Future<void> _initHiveDB() async {
    try {
      await Hive.initFlutter(sl<PT>().isWeb ? null : sl<AppDir>().db.path);
      _registerHiveAdepters();
      await _openAllBoxes();
    } catch (e) {
      log.e('Failed to initialize Hive DB: $e');
      rethrow;
    }
  }

  void _registerHiveAdepters() {
    Hive.registerAdapter(LocaleProfileAdapter());
    Hive.registerAdapter(ThemeProfileAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(AuthStoreAdapter());
  }

  Future<void> _openAllBoxes() async {
    await Hive.openBox<LocaleProfile>(BoxNames.localeProfile);
    await Hive.openBox<ThemeProfile>(BoxNames.themeProfile);
    await Hive.openBox<AppSettings>(BoxNames.appSettings);
    await Hive.openBox<AuthStore>(BoxNames.authStores);
  }

  Future<void> _closeAllBoxes() async {
    await Boxes.localeProfile.close();
    await Boxes.themeProfile.close();
    await Boxes.appSettings.close();
    await Boxes.authStores.close();
  }

  Future<void> _clearAllBoxes() async {
    await Boxes.localeProfile.clear();
    await Boxes.themeProfile.clear();
    await Boxes.appSettings.clear();
    await Boxes.authStores.clear();
  }

  Future<void> _deleteAllBoxes() async {
    await Hive.deleteBoxFromDisk(BoxNames.localeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.themeProfile);
    await Hive.deleteBoxFromDisk(BoxNames.appSettings);
    await Hive.deleteBoxFromDisk(BoxNames.authStores);
  }
}

class AppDir {
  late Directory db;
  late Directory root;
  late Directory files;
  late Directory backup;
  AppDir();
}
