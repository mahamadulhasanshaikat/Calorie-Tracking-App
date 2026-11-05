import 'package:flutter/material.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/repositories/food_repository.dart';

class CalorieProvider extends ChangeNotifier {
  final FoodRepository repository;
  
  CalorieProvider({required this.repository});

  final int dailyGoal = 2000;

  List<FoodItem> get foods => repository.getAllFoods();

  int get totalCalories {
    return foods.fold(0, (sum, item) => sum + item.calories);
  }

  int get remainingCalories {
    return dailyGoal - totalCalories;
  }

  void addFood(String name, int calories) {
    final newItem = FoodItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      name: name,
      calories: calories,
    );
    repository.addFood(newItem);
    notifyListeners(); // Auto updates UI
  }

  void deleteFood(String id) {
    repository.deleteFood(id);
    notifyListeners(); // Auto updates UI
  }
}