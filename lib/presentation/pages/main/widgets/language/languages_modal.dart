import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../components/loading.dart';
import 'select_item.dart';

class LanguagesModal extends ConsumerWidget {
  final VoidCallback? afterUpdate;

  const LanguagesModal({super.key, this.afterUpdate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(languagesProvider.notifier);
    final state = ref.watch(languagesProvider);
    return state.isLoading
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Loading(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              itemCount: state.languages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return SelectItem(
                  onTap: () {
                    notifier.change(index, afterUpdate: afterUpdate);
                  },
                  isActive: LocalStorage.getLanguage()?.locale ==
                      state.languages[index].locale,
                  title: state.languages[index].title ?? '',
                );
              },
            ),
          );
  }
}
