import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calorie_provider.dart';
import '../widgets/calorie_summary_card.dart';
import '../widgets/add_food_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calorie Tracker"),
        centerTitle: true,
      ),
      body: Consumer<CalorieProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date: ${_getTodayDate()}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                
                // Summary Cards
                Row(
                  children: [
                    CalorieSummaryCard(
                      title: "Total",
                      value: "${provider.totalCalories}",
                      color: Colors.blue,
                    ),
                    CalorieSummaryCard(
                      title: "Goal",
                      value: "${provider.dailyGoal}",
                      color: Colors.green,
                    ),
                    CalorieSummaryCard(
                      title: "Remaining",
                      value: "${provider.remainingCalories}",
                      color: provider.remainingCalories < 0 ? Colors.red : Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                const Text(
                  "Food Log",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Food List using ListView.builder
                Expanded(
                  child: provider.foods.isEmpty
                      ? const Center(child: Text("No food added yet!"))
                      : ListView.builder(
                          itemCount: provider.foods.length,
                          itemBuilder: (context, index) {
                            final food = provider.foods[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.fastfood, color: Colors.orangeAccent),
                                title: Text(food.name),
                                subtitle: Text("${food.calories} kcal"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    provider.deleteFood(food.id);
                                  },
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddFoodDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Food"),
      ),
    );
  }
}