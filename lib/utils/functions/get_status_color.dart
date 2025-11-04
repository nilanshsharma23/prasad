import 'package:flutter/material.dart';
import 'package:prasad/utils/enums/status_enum.dart';

Color getStatusColor(BuildContext context, {required Status status}) {
  if (status == Status.unverified) {
    return Theme.of(context).colorScheme.onSurface;
  } else if (status == Status.accepted) {
    return Theme.of(context).colorScheme.secondary;
  } else if (status == Status.rejected) {
    return Theme.of(context).colorScheme.error;
  }

  return Theme.of(context).colorScheme.onSurface;
}
