import 'package:flutter/material.dart';

class HourlyUpdate extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  const HourlyUpdate({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(height: 8),
              Text(
                time,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Icon(icon),
              SizedBox(height: 8),
              Text(temp),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
