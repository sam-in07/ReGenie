import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder.dart';
import 'package:regenie/presentation/widgets/Reminder/reminder_item.dart';
import 'package:regenie/presentation/widgets/colors.dart';
import 'package:regenie/presentation/widgets/Reminder/info_card.dart';
import 'package:regenie/presentation/navigation/bottom_nav.dart'; // Import BottomNavBar
import 'package:regenie/presentation/widgets/Button_Cards/summary_card.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header - Row for back button and title
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Progress Tracker",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Top summary cards container with the green background
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Summary Cards inside a Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SummaryCard(
                          icon: Icons.trending_up,
                          title: "$thisWeek",
                          subtitle: "This Week",
                          iconColor: Colors.green.shade300,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                        SummaryCard(
                          icon: Icons.calendar_today,
                          title: avgPerDay.toStringAsFixed(1),
                          subtitle: "Avg/Day",
                          iconColor: Colors.blue.shade400,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                        SummaryCard(
                          icon: Icons.local_fire_department,
                          title: "$dayStreak",
                          subtitle: "Day Streak",
                          iconColor: Colors.orange.shade400,
                          bgColor: Colors.white,
                          textColor: Colors.black87,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Eco Actions This Week - line chart placeholder
              const Text(
                "Eco Actions This Week",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: CustomPaint(
                  painter: LineChartPainter([4, 6, 3, 8, 5, 7, 9]), // Sample data
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ActionData {
  final String title;
  final int count;
  final IconData icon;
  final Color iconColor;

  ActionData(this.title, this.count, this.icon, this.iconColor);
}

class _ActionBreakdownTile extends StatelessWidget {
  final ActionData action;

  const _ActionBreakdownTile({required this.action});

  @override
  Widget build(BuildContext context) {
    final double progress = (action.count / 30).clamp(0, 1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(action.icon, color: action.iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    color: action.iconColor,
                    backgroundColor: action.iconColor.withOpacity(0.3),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "${action.count}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: action.iconColor,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            "times",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Simple Line Chart Painter for weekly data
class LineChartPainter extends CustomPainter {
  final List<int> data;
  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..color = Colors.green.shade100.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final double stepX = size.width / (data.length - 1);
    final double maxY = 12;

    // Calculate points
    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      double dx = stepX * i;
      double dy = size.height - (data[i] / maxY) * size.height;
      points.add(Offset(dx, dy));
    }

    // Draw fill under line
    Path fillPath = Path()..moveTo(points.first.dx, size.height);
    for (final point in points) {
      fillPath.lineTo(point.dx, point.dy);
    }
    fillPath.lineTo(points.last.dx, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, paintFill);

    // Draw line
    Path linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, paintLine);

    // Draw dots
    final paintDot = Paint()..color = Colors.green.shade600;
    for (final point in points) {
      canvas.drawCircle(point, 5, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple Bar Chart Painter for monthly data
class BarChartPainter extends CustomPainter {
  final List<int> data;
  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paintBar = Paint()..color = Colors.green.shade600;

    final double barWidth = size.width / (data.length * 2);
    final double maxY = 36;

    for (int i = 0; i < data.length; i++) {
      final x = (i * 2 + 1) * barWidth;
      final barHeight = (data[i] / maxY) * size.height;
      final rect = Rect.fromLTWH(
        x,
        size.height - barHeight,
        barWidth,
        barHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        paintBar,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;

  const SummaryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 104,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
