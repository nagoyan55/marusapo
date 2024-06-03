import 'package:flutter/material.dart';
import 'package:myapp/models/week_plan.dart';
import 'meal_detail_screen.dart';

class PlanList extends StatelessWidget {
  final WeekPlan weekPlan;

  PlanList({required this.weekPlan});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weekPlan.days.length,
      itemBuilder: (context, index) {
        final dayPlan = weekPlan.days[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '${dayPlan.date.year}/${dayPlan.date.month.toString().padLeft(2, '0')}/${dayPlan.date.day.toString().padLeft(2, '0')} (${dayPlan.weekday})',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('朝食: ${dayPlan.menu.breakfast.name}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(meal: dayPlan.menu.breakfast),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('昼食: ${dayPlan.menu.lunch.name}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(meal: dayPlan.menu.lunch),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('夕食: ${dayPlan.menu.dinner.name}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(meal: dayPlan.menu.dinner),
                  ),
                );
              },
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
