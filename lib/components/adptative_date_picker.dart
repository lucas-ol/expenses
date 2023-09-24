import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime date) onDateChange;
  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  Future<void> _showDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      onDateChange(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              initialDateTime: selectedDate,
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2019),
              onDateTimeChanged: (DateTime value) {
                onDateChange(value);
              },
            ),
          )
        : Row(
            children: [
              Text(DateFormat("dd/MM/y").format(selectedDate)),
              TextButton(
                onPressed: () => _showDatePicker(context),
                child: const Text(
                  "Selecionar Data",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
  }
}
