import 'package:flutter/material.dart';

Color btnColors(String x) {
  List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.'
  ];
  List<String> operatos = ['(', ')', '/', 'x', '+', '-', '='];
  List<String> clears = ['C', 'DE'];

  if (numbers.contains(x)) {
    return Colors.white;
  } else if (operatos.contains(x)) {
    return Colors.green;
  } else if (clears.contains(x)) {
    return Colors.orange;
  }

  return Colors.white;
}
