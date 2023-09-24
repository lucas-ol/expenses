import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adptative_date_picker.dart';
import 'package:flutter/material.dart';

import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdaptativeTextField(
              controller: _titleController,
              label: 'Titulo',
            ),
            AdaptativeTextField(
              controller: _valueController,
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              label: 'Valor R\$',
            ),
            AdaptativeDatePicker(
              selectedDate: selectedDate,
              onDateChange: (date) => setState(
                () => selectedDate = date,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: AdaptativeButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: _submitForm,
                child: const Text(
                  "Nova Transação",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
