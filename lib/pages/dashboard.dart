import 'package:flutter/material.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan5.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan6.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan7.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan8.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan9.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan10.dart';

class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Pertemuan 5",
      "icon": Icons.auto_stories,
      "color": Colors.blue,
      "page": ListPage(),
    },
    {
      "title": "Pertemuan 6",
      "icon": Icons.auto_stories,
      "color": Colors.green,
      "page": CheckboxPage(),
    },
    {
      "title": "Pertemuan 7",
      "icon": Icons.auto_stories,
      "color": Colors.orange,
      "page": RadiobuttonPage(),
    },
    {
      "title": "Pertemuan 8",
      "icon": Icons.auto_stories,
      "color": Colors.red,
      "page": AutocompletespinPage(),
    },
    {
      "title": "Pertemuan 9",
      "icon": Icons.auto_stories,
      "color": Colors.blue,
      "page": DateTimePickerForm(),
    },
    {
      "title": "Pertemuan 10",
      "icon": Icons.auto_stories,
      "color": Colors.green,
      "page": SimpleAppBar(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(24),
          ),
        ),

        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return _buildMenuCard(
              context,
              title: item['title'],
              icon: item['icon'],
              color: item['color'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['page']),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
