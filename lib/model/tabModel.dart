import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {}); // Trigger rebuild to update indicator color
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color getIndicatorColor() {
    switch (_tabController.index) {
      case 0: // Academic
        return Color.fromARGB(255, 115, 0, 255);
      case 1: // Costs
        return Color.fromARGB(255, 200, 255, 0);
      case 2: // Admission
        return Color.fromARGB(255, 255, 81, 0);
      case 3: // Campus
        return Color.fromARGB(255, 255, 132, 177);
      default:
        return Colors.black; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'Academic',
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Costs',
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Admission',
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Color.fromARGB(255, 255, 81, 0),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Campus',
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Color.fromARGB(255, 255, 132, 177),
                  ),
                ),
              ),
            ],
            labelColor: Colors.black, // Default selected color (overridden by individual styles)
            unselectedLabelStyle: GoogleFonts.raleway(
              fontSize: 12,
              color: Colors.black,
            ),
            indicatorColor: getIndicatorColor(), // Dynamic divider color
            indicatorWeight: 6.0,
            unselectedLabelColor: Colors.grey, // Default unselected color (overridden by individual styles)
          ),
          // Add TabBarView or other content here if needed
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('Academic Content')),
                Center(child: Text('Costs Content')),
                Center(child: Text('Admission Content')),
                Center(child: Text('Campus Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}