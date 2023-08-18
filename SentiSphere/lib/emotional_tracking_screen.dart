import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'notes_provider.dart';
import 'colors.dart';

class EmotionalTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotional Tracking'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: Center( // Center the text widget
        child: Text(
          'Coming soon! See a graph of how your emotional levels have (hopefully) increased!',
          style: TextStyle(fontSize: 20), // You can adjust the style as needed
        ),
      ),

      /*
      body: FutureBuilder<List<double>>(
        future: NotesProvider().weeklyEmojiAverages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final weeklyAverages = snapshot.data ?? [];
            if (weeklyAverages.isEmpty) { // Check if the list is empty
              return Center(
                child: Text('No data available'),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(weeklyAverages.length,
                                (index) => FlSpot(index.toDouble(), weeklyAverages[index])),
                        isCurved: true,
                        colors: [AppColors.primaryLight],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData()),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: true),
                      bottomTitles: SideTitles(showTitles: true),
                    ),
                    borderData: FlBorderData(show: true),
                    gridData: FlGridData(show: true),
                  ),
                ),
              ),
            );
          }
        },
      ),*/
    );
  }
}

