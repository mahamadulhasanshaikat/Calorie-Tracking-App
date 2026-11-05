import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/calorie_provider.dart';
import '../widgets/calorie_summary_card.dart';
import '../widgets/add_food_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getTodayDate() {
    return DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calorie Tracker"),
      ),
      body: Consumer<CalorieProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Greeting and Date
                const Text(
                  "Hello, Shaikat!", // You can customize this
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _getTodayDate(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                
                // Summary Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalorieSummaryCard(
                      title: "Total",
                      value: "${provider.totalCalories}",
                      color: Colors.orange,
                      icon: Icons.fastfood,
                    ),
                    CalorieSummaryCard(
                      title: "Goal",
                      value: "${provider.dailyGoal}",
                      color: Colors.blue,
                      icon: Icons.flag,
                    ),
                    CalorieSummaryCard(
                      title: "Remaining",
                      value: "${provider.remainingCalories}",
                      color: provider.remainingCalories < 0 ? Colors.red : Colors.green,
                      icon: Icons.local_fire_department,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                const Text(
                  "Today's Food Log",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Food List
                Expanded(
                  child: provider.foods.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant_menu, size: 64, color: Colors.grey.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              const Text(
                                "No food added yet!",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const Text(
                                "Tap '+' to log your meal.",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: provider.foods.length,
                          itemBuilder: (context, index) {
                            final food = provider.foods[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal.withOpacity(0.1),
                                  child: const Icon(Icons.lunch_dining, color: Colors.teal),
                                ),
                                title: Text(
                                  food.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "${food.calories} kcal",
                                  style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () => provider.deleteFood(food.id),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddFoodDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Food", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}