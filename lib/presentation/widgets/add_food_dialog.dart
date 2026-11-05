import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calorie_provider.dart';

class AddFoodDialog extends StatefulWidget {
  const AddFoodDialog({Key? key}) : super(key: key);

  @override
  State<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _calorieController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _calorieController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final calories = int.parse(_calorieController.text.trim());

      Provider.of<CalorieProvider>(context, listen: false).addFood(name, calories);
      Navigator.pop(context); // Close dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Food"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Food Name"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a food name";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _calorieController,
              decoration: const InputDecoration(labelText: "Calorie Amount (kcal)"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter calorie amount";
                }
                final parsedValue = int.tryParse(value.trim());
                if (parsedValue == null || parsedValue <= 0) {
                  return "Must be a valid positive number";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Add"),
        ),
      ],
    );
  }
}