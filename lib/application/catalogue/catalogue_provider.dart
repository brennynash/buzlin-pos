import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'catalogue_notifier.dart';
import 'catalogue_state.dart';


final catalogueProvider =
StateNotifierProvider<CatalogueNotifier, CatalogueState>(
      (ref) => CatalogueNotifier(),
);
