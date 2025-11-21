import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:regenie/presentation/Home/Pages/progress_screen.dart';
import 'package:regenie/presentation/widgets/Action_data.dart';
import 'package:regenie/presentation/widgets/Button_Cards/monthly_bar_trend.dart';
import 'package:regenie/presentation/widgets/Button_Cards/summary_card.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder_item.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';
import 'package:regenie/presentation/widgets/Reminder/info_card.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart'; // Import BottomNavBar


class ProgressTrackerScreen extends StatelessWidget {
  const ProgressTrackerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    // Sample data from image
    final int thisWeek = 42;
    final double avgPerDay = 6.0;
    final int dayStreak = 7;


    final List<int> weeklyEcoActions = [4, 6, 3, 8, 5, 7, 9];
    final List<int> monthlyTrend = [20, 30, 27, 36];


    final List<ActionData> actions = [
      ActionData("Reusable bottles used", 24, Icons.water_drop, Colors.blue),
      ActionData("Plant-based meals", 18, Icons.restaurant, Colors.green),
      ActionData("Bike rides", 12, Icons.pedal_bike, Colors.teal),
      ActionData("Waste recycled", 30, Icons.recycling, Colors.green.shade700),
    ];


    return Scaffold(
      backgroundColor: const Color(0xFFD1F1DD),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- GREEN HEADER CONTAINER ----------
          Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 250),
          decoration: const BoxDecoration(
            color: Color(0xFF00BC7D),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),

                  // HEADER
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/progressscren/back_btn.png',
                            height: 54,
                            width: 54,
                            fit: BoxFit.contain,
                          ),
                        ),

                      ),

                      const SizedBox(width: 12),
                       Text(
                        "Progress Tracker",
                        style: AppTextstyle.textStyle24whiteW600,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Summary Cards (inside green header)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.trending_up,
                          title: "$thisWeek",
                          subtitle: "This Week",
                          iconColor: Colors.green.shade300,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.calendar_today,
                          title: avgPerDay.toStringAsFixed(1),
                          subtitle: "Avg/Day",
                          iconColor: Colors.blue.shade400,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.local_fire_department,
                          title: "$dayStreak",
                          subtitle: "Day Streak",
                          iconColor: Colors.orange.shade400,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),



          // ---------- MAIN CONTENT BELOW GREEN HEADER ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Eco Actions This Week
                  const SizedBox(height: 30),
                   Text(
                    "Eco Actions This Week",
                    style: AppTextstyle.textStyle20blackyW600,
                  ),
                  const SizedBox(height: 12),


                  // Line Chart for Weekly Eco Actions
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: 12,


                        // GRID
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          getDrawingHorizontalLine: (_) =>
                              FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                          getDrawingVerticalLine: (_) =>
                              FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                        ),


                        // BORDER
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                        ),


                        // LABELS
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, _) {
                                const labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                                return Text(
                                  labels[value.toInt()],
                                  style: const TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 3,
                              reservedSize: 28,
                              getTitlesWidget: (value, _) => Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),


                        // LINE DATA
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: const Color(0xFF06C167),
                            barWidth: 4,
                            spots: const [
                              FlSpot(0, 4),
                              FlSpot(1, 6),
                              FlSpot(2, 3),
                              FlSpot(3, 8),
                              FlSpot(4, 5),
                              FlSpot(5, 7),
                              FlSpot(6, 9),
                            ],


                            // Gradient under line
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF06C167).withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 30),


                  // Action Breakdown
                   Text(
                    "Monthly Trend",
                    style: AppTextstyle.textStyle20blackyW600,
                  ),
                  const SizedBox(height: 16),

                  


                  MonthlyTrendBarChart(
                    data: [24, 32, 28, 36], // Your monthly data
                  ),


                  const SizedBox(height: 16),
                  Text(
                    "Action Breakdown",
                    style: AppTextstyle.textStyle20blackyW600,
                  ),
                  const SizedBox(height: 8),
                  ...actions.map((action) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ActionBreakdownTile(action: action),
                    );
                  }).toList(),

                  const SizedBox(height: 40),



                  // Bottom Message Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightorng,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFB900), // start
                                Color(0xFFFF6900), // end
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Image.asset(
                            'assets/progressscren/badge.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Outstanding Progress! 🎉\n",
                                  style: AppTextstyle.textStyle16darkblackW600,    // custom title text style
                                ),
                                TextSpan(
                                  text:
                                  "You've completed 42 eco-friendly\nactions this month. Keep up the\namazing work!",
                                  style: AppTextstyle.textStyle16greyW400, // custom description text style
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




