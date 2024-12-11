import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/features/sample_dir/provider/sample_controller.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../provider/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final controller = Provider.of<DashBoardProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: controller.selectedIndex,
            children: controller.screens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a1e),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Theme(
                data: ThemeData(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home_filled),
                      label: 'Home',
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      activeIcon: Icon(Icons.list),
                      label: 'Notification',
                    ),
                  ],
                  currentIndex: controller.selectedIndex,
                  onTap: controller.onItemTapped,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey.shade500,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
