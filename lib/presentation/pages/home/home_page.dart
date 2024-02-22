import 'package:flutter/material.dart';
import 'package:pretest/presentation/widgets/selectable_tab.dart';

import '../../constants/color_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCalendarSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableTab(
                        isSelected: _isCalendarSelected,
                        label: 'Kalender',
                        iconPath: 'assets/icons/calendar.png',
                        selectedBackgroundColor: Colors.white,
                        textColor: Colors.white,
                        selectedTextColor: blue,
                        borderRadius: 12,
                        selectedSize: 120,
                        iconScale: 1,
                        onTap: () => setState(() => _isCalendarSelected = true),
                      ),
                      SelectableTab(
                        isSelected: !_isCalendarSelected,
                        label: 'Detail',
                        iconPath: 'assets/icons/detail-book.png',
                        selectedBackgroundColor: Colors.white,
                        textColor: Colors.white,
                        selectedTextColor: blue,
                        borderRadius: 12,
                        selectedSize: 120,
                        iconScale: 1,
                        onTap: () => setState(() => _isCalendarSelected = false),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
