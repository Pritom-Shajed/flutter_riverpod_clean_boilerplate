import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/color/app_colors.dart';
import 'package:go_transitions/go_transitions.dart';

const darkUiConfig = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: _backgroundColor,
  systemNavigationBarIconBrightness: Brightness.light,
);

const darkPrimaryColor = AppColors.primaryColor;
const _headLineTextColor = Colors.white;
const _iconColorSecondary = AppColors.primaryColor;
const _backgroundColor = Color(0xFF181A20);
const _bodyTextColor = Colors.white;
const _unselectedColor = Colors.blueGrey;
const _titleTextColor = Colors.white;
const _primaryLightColor = AppColors.primaryColor;
const _cardBackgroundColor = Color.fromARGB(255, 0, 0, 0);
const _scaffoldBackgroundColor = Color(0xFF181A20);
const _appBarBackgroundColor = Color(0xFF181A20);
const _bottomSheetBackgroundColor = Color(0xFF181A20);
const _bottomAppBarColor = AppColors.darkAshColor;
const _floatingActionButtonColor = AppColors.primaryColor;
final _shadowColor = AppColors.shadowColor;

const _pageTransitionTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: GoTransitions.fade,
    TargetPlatform.iOS: GoTransitions.fade,
    TargetPlatform.macOS: GoTransitions.fade,
  },
);

final darkTheme = ThemeData(
  useMaterial3: true,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  // fontFamily: fontFamily,
  radioTheme: _radioTheme,
  shadowColor: _shadowColor,
  appBarTheme: _appBarTheme,
  tabBarTheme: _tabBarTheme,
  dialogTheme: _dialogTheme,
  switchTheme: _switchTheme,
  tooltipTheme: _tooltipTheme,
  brightness: Brightness.dark,
  listTileTheme: _listTileTheme,
  snackBarTheme: _snackBarTheme,
  primaryColor: darkPrimaryColor,
  cardColor: _cardBackgroundColor,
  dividerTheme: _dividerTheme,
  unselectedWidgetColor: _unselectedColor,
  bottomNavigationBarTheme: _bottomNavBar,
  secondaryHeaderColor: _primaryLightColor,
  textSelectionTheme: _textSelectionTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  inputDecorationTheme: _darkInputDecorationTheme,
  progressIndicatorTheme: _progressIndicatorTheme,
  scaffoldBackgroundColor: _scaffoldBackgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: _floatingActionButtonTheme,
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  chipTheme: _chipTheme,
  primaryIconTheme: const IconThemeData(color: darkPrimaryColor),
  pageTransitionsTheme: _pageTransitionTheme,
  bottomSheetTheme: _bottomSheetTheme,
  bottomAppBarTheme: _bottomAppBarTheme,
);

final _bottomAppBarTheme = BottomAppBarThemeData(color: _bottomAppBarColor, elevation: 4);

final _bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: _bottomSheetBackgroundColor,
  modalBackgroundColor: _bottomSheetBackgroundColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
);

final _chipTheme = ChipThemeData(
  backgroundColor: Colors.white,
  labelStyle: _textTheme.bodyMedium!.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
  padding: const EdgeInsets.symmetric(horizontal: 5),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  side: BorderSide.none,
  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
  elevation: 5.0,
  shadowColor: AppColors.primaryColor.withValues(alpha: 0.5),
);

final _dividerTheme = DividerThemeData(color: _unselectedColor.withValues(alpha: 0.4), thickness: 0.4);

final _switchTheme = SwitchThemeData(
  thumbColor: WidgetStateProperty.all(darkPrimaryColor),
  trackColor: WidgetStateProperty.all(darkPrimaryColor.withValues(alpha: 0.5)),
);

final _darkInputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.all(20),
  hintStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    gapPadding: 10,
    borderSide: BorderSide.none,
  ),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), gapPadding: 10, borderSide: BorderSide.none),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    gapPadding: 10,
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    gapPadding: 10,
    borderSide: BorderSide.none,
  ),
  floatingLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkPrimaryColor),
  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), gapPadding: 10, borderSide: BorderSide.none),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    gapPadding: 10,
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: _cardBackgroundColor,
  suffixIconColor: darkPrimaryColor,
  prefixIconColor: darkPrimaryColor,
  errorMaxLines: 3,
  floatingLabelBehavior: FloatingLabelBehavior.never,
);

const _textSelectionTheme = TextSelectionThemeData(
  cursorColor: darkPrimaryColor,
  selectionColor: darkPrimaryColor,
  selectionHandleColor: darkPrimaryColor,
);

final _snackBarTheme = SnackBarThemeData(
  actionTextColor: _textTheme.labelSmall!.color,
  contentTextStyle: _textTheme.labelSmall,
  backgroundColor: Colors.transparent,
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  elevation: 0.0,
);

final _tabBarTheme = TabBarThemeData(
  labelColor: darkPrimaryColor,
  unselectedLabelColor: _unselectedColor,
  indicatorSize: TabBarIndicatorSize.label,
  indicator: BoxDecoration(borderRadius: BorderRadius.circular(30)),
  indicatorColor: _floatingActionButtonColor,
);

final _cardTheme = CardThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  shadowColor: _shadowColor,
  color: _cardBackgroundColor,
  elevation: 0,
);

final _radioTheme = RadioThemeData(
  fillColor: WidgetStateProperty.all(darkPrimaryColor),
  overlayColor: WidgetStateProperty.all(_primaryLightColor),
);

final _listTileTheme = ListTileThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));

final _dialogTheme = DialogThemeData(
  backgroundColor: _cardBackgroundColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

final _tooltipTheme = TooltipThemeData(
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: _floatingActionButtonColor.withValues(alpha: 0.8),
  ),
  textStyle: _textTheme.titleSmall!.copyWith(color: Colors.white),
);

final _appBarTheme = AppBarTheme(
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  backgroundColor: _appBarBackgroundColor,
  elevation: 0.0,
  titleTextStyle: _textTheme.titleLarge,
);

const _floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: _floatingActionButtonColor,
  foregroundColor: Colors.white,
  elevation: 0,
);

const _progressIndicatorTheme = ProgressIndicatorThemeData(
  refreshBackgroundColor: _primaryLightColor,
  circularTrackColor: _primaryLightColor,
  linearTrackColor: _primaryLightColor,
  color: darkPrimaryColor,
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: darkPrimaryColor,
    textStyle: _textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
    foregroundColor: const Color(0xFFe2eeff),
    padding: const EdgeInsets.all(18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
  ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: BorderSide.none,
    foregroundColor: darkPrimaryColor,
    textStyle: _textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
    backgroundColor: const Color(0xFFe2eeff),
    padding: const EdgeInsets.all(18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
  ),
);

const _textTheme = TextTheme(
  titleSmall: TextStyle(fontWeight: FontWeight.w700, color: _titleTextColor),
  titleMedium: TextStyle(fontWeight: FontWeight.w700, color: _titleTextColor),
  titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0, color: _titleTextColor),
  labelSmall: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700, letterSpacing: 0.7),
  labelMedium: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  labelLarge: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(color: _bodyTextColor),
  bodyMedium: TextStyle(color: _bodyTextColor),
  bodyLarge: TextStyle(color: _bodyTextColor, fontSize: 16, fontWeight: FontWeight.w700),
  headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: _headLineTextColor),
);

const _bottomNavBar = BottomNavigationBarThemeData(
  unselectedItemColor: _unselectedColor,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: darkPrimaryColor,
  showUnselectedLabels: true,
  elevation: 30,
  selectedIconTheme: IconThemeData(color: darkPrimaryColor, size: 30),
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, color: darkPrimaryColor, fontSize: 10),
  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, color: _unselectedColor, fontSize: 10),
);

const darkGradiants = [
  [Color.fromARGB(150, 0, 85, 74), Color.fromARGB(255, 0, 85, 74)],
  [Color.fromARGB(150, 44, 50, 56), Color.fromARGB(255, 44, 50, 56)],
  [Color.fromARGB(150, 56, 101, 122), Color.fromARGB(255, 56, 101, 122)],
  [Color.fromARGB(150, 25, 133, 167), Color.fromARGB(255, 25, 133, 167)],
  [Color.fromARGB(150, 20, 59, 119), Color.fromARGB(255, 20, 59, 119)],
];
