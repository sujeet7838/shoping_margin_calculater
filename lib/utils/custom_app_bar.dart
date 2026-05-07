import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String logoPath;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logoPath,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      shadowColor: Colors.black26,
      centerTitle: true,
      toolbarHeight: 70,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),

      backgroundColor: Colors.transparent,

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFFee709a),
              Color(0xFFff9472),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),

      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
               fontWeight: FontWeight.w600,
              height: 1,
              letterSpacing: 1,
            ),
          ),
        ],
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                logoPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}