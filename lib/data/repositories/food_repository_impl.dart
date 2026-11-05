import '../../domain/entities/food_item.dart';
import '../../domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  // Local list as per requirements. Data resets on restart.
  final List<FoodItem> _foodList = [];

  @override
  List<FoodItem> getAllFoods() {
    return _foodList;
  }

  @override
  void addFood(FoodItem food) {
    _foodList.add(food);
  }

  @override
  void deleteFood(String id) {
    _foodList.removeWhere((food) => food.id == id);
  }
}