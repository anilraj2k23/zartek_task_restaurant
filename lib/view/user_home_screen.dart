import 'package:flutter/material.dart';

class ScreenUserHome extends StatefulWidget {
  const ScreenUserHome({Key? key}) : super(key: key);

  @override
  State<ScreenUserHome> createState() => _ScreenUserHomeState();
}

class _ScreenUserHomeState extends State<ScreenUserHome>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add cart icon action logic here
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Add drawer item 1 logic here
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add drawer item 2 logic here
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Tab 1 Item $index'),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 10,
          ),
          ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Tab 2 Item $index'),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
