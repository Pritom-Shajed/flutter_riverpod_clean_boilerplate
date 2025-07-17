import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/riverpod/helper.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/features/settings/presentation/view/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    return provider.when(
      loading: riverpodLoading,
      error: riverpodError,
      data: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () => context.pushNamed(SettingsScreen.name),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: Center(
            child: Text('Home'),
          ),
        );
      },
    );
  }
}
