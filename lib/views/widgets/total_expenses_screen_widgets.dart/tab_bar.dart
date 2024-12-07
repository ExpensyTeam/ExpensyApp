import 'package:flutter/material.dart';

class Tabbare extends StatefulWidget {
  @override
  _TabbareState createState() => _TabbareState();
}

class _TabbareState extends State<Tabbare> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spends vs Categories'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Spends'),
                Tab(text: 'Categories'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Spends tab content
                Center(child: Text('Spends tab')),
                // Categories tab content
                Center(child: Text('Categories tab')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
