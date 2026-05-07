import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CardButton({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Color(0xFFF87AA4),
                Color(0xFFFF9A9E),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 40,
                width: 40,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}