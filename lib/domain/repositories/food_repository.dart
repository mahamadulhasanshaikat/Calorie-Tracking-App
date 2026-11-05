import '../entities/food_item.dart';

abstract class FoodRepository {
  List<FoodItem> getAllFoods();
  void addFood(FoodItem food);
  void deleteFood(String id);
}