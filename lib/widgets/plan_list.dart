import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/plan.dart';

class PlanList extends StatelessWidget {
  final WeekPlan weekPlan;

  PlanList({required this.weekPlan});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    return ListView.builder(
      itemCount: weekPlan.days.length,
      itemBuilder: (context, index) {
        final dayPlan = weekPlan.days[index];
        String formattedDate = dateFormat.format(dayPlan.date);
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$formattedDate (${dayPlan.weekday})',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('朝食: ${dayPlan.breakfast.name}',
                    style: TextStyle(fontSize: 14)),
                Text('昼食: ${dayPlan.lunch.name}',
                    style: TextStyle(fontSize: 14)),
                Text('夕食: ${dayPlan.dinner.name}',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}
