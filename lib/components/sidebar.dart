import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class AppSidebar extends StatefulWidget {
  final Widget body;
  final Function(int) onItemSelected;
  final int currentIndex;

  const AppSidebar({
    super.key,
    required this.body,
    required this.onItemSelected,
    required this.currentIndex,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        if (isMobile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xFF203A43),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: Drawer(
              backgroundColor: Colors.grey.shade900,
              child: ListView(
                padding: EdgeInsets.zero,
                children: _buildMobileDrawerItems(),
              ),
            ),
            body: widget.body,
          );
        }

        // Desktop/tablet layout
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 20, 26, 28),
                Color(0xFF203A43),
              ],
            ),
          ),
          child: CollapsibleSidebar(
            isCollapsed: _isCollapsed,
            items: _buildSidebarItems(),
            title: 'K U M A R',
            body: widget.body,
            onTitleTap: () {
               setState(() => _isCollapsed = !_isCollapsed);
            },
            toggleTitle: _isCollapsed ? 'Expand' : 'Collapse',
            toggleButtonIcon: _isCollapsed ? Icons.menu_open : Icons.menu,
            backgroundColor: Colors.grey.shade900,
            selectedIconBox: Colors.indigoAccent.withOpacity(0.5),
            selectedTextColor: Colors.white,
            unselectedIconColor: Colors.white70,
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            titleStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            avatarImg: const AssetImage('assets/kartikaycircle.png'),
            sidebarBoxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 46, 56, 60),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(5, 0),
              ),
            ],
            borderRadius: 15,
          ),
        );
      },
    );
  }

  List<CollapsibleItem> _buildSidebarItems() {
    return [
      _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
      _buildNavItem(1, Icons.person_outline, Icons.person, 'About'),
      _buildNavItem(2, Icons.school_outlined, Icons.school, 'Awards'),
      _buildNavItem(3, Icons.work_outline, Icons.work, 'Projects'),
      // The unselected icon for Contact is now different
      _buildNavItem(4, Icons.send_outlined, Icons.send, 'Contact'),
    ];
  }

  CollapsibleItem _buildNavItem(int index, IconData unselectedIcon, IconData selectedIcon, String text) {
    final isSelected = widget.currentIndex == index;
    return CollapsibleItem(
      text: text,
      // CORRECTED: This now correctly passes IconData, not a Widget
      icon: isSelected ? selectedIcon : unselectedIcon,
      onPressed: () => widget.onItemSelected(index),
      isSelected: isSelected,
    );
  }

  List<Widget> _buildMobileDrawerItems() {
    return [
      const DrawerHeader(
        decoration: BoxDecoration(color: Color(0xFF2C5364)),
        child: Text(
          'K U M A R',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      _buildDrawerItem(0, Icons.home, 'Home'),
      _buildDrawerItem(1, Icons.person, 'About'),
      _buildDrawerItem(2, Icons.school, 'Awards'),
      _buildDrawerItem(3, Icons.work, 'Projects'),
      _buildDrawerItem(4, Icons.send, 'Contact'), // Updated icon here too
    ];
  }

  Widget _buildDrawerItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.indigoAccent.withOpacity(0.3),
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
      onTap: () {
        widget.onItemSelected(index);
        Navigator.pop(context);
      },
    );
  }
}