import 'package:flutter/material.dart';
import '../styles/style.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Style.white,
  elevation: 1,
  iconTheme: const IconThemeData(color: Style.black),
  titleTextStyle: Style.interNormal(size: 16),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(Style.primary),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: WidgetStateProperty.all(Style.black),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    border: Border.all(color: Style.black),
  ),
  dataTextStyle: Style.interNormal(size: 12),
);
