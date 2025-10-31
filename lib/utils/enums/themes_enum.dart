import 'dart:collection';

import 'package:flutter/material.dart';

typedef ThemeEntry = DropdownMenuEntry<Themes>;

enum Themes {
  systemDefault("System Default"),
  light("Light"),
  dark("Dark");

  const Themes(this.label);
  final String label;

  static final List<ThemeEntry> entries = UnmodifiableListView<ThemeEntry>(
    values.map<ThemeEntry>(
      (Themes theme) => ThemeEntry(label: theme.label, value: theme),
    ),
  );
}
