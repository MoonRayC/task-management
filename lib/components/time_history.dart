import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeHistory extends StatelessWidget {
  final DateTime createdAt;
  final DateTime endDate;
  final String status;

  const TimeHistory({
    super.key,
    required this.createdAt,
    required this.endDate,
    required this.status,
  });

  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, y').format(createdAt);
    }
  }

  Color getTextColor() {
    if (status == 'completed' && DateTime.now().isBefore(endDate)) {
      return Colors.green;
    } else if (status != 'completed' && DateTime.now().isAfter(endDate)) {
      return Colors.red;
    } else {
      return Colors.black; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeAgo(),
      style: TextStyle(
        color: getTextColor(),
      ),
    );
  }
}
