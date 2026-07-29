import 'package:flutter/material.dart';

extension CharacterStatusX on String {
  Color get statusColor {
    switch (toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      case 'unknown':
      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (toLowerCase()) {
      case 'alive':
        return Icons.favorite_rounded;
      case 'dead':
        return Icons.dangerous_rounded;
      case 'unknown':
      default:
        return Icons.help_rounded;
    }
  }
}
