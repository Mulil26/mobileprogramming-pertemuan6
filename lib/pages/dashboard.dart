import 'package:flutter/material.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan5.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan6.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan7.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan8.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan9.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan10.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan13.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan14.dart';

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
    {
      "title": "Pertemuan 13",
      "icon": Icons.auto_stories,
      "color": Colors.red,
      "page": AudioVideo(),
    },
    {
      "title": "Pertemuan 14",
      "icon": Icons.auto_stories,
      "color": Colors.blue,
      "page": MapDirectionScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // === Option Menu di AppBar ===
          PopupMenuButton<String>(
            onSelected: (value) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Option dipilih: $value")));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black54),
                    SizedBox(width: 8),
                    Text("Profile"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black54),
                    SizedBox(width: 8),
                    Text("Settings"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black54),
                    SizedBox(width: 8),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onLongPressStart: (details) async {
                // === Context Menu saat long press card ===
                final selected = await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                  ),
                  items: const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.black54),
                          SizedBox(width: 8),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.black54),
                          SizedBox(width: 8),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                );

                if (selected != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Context menu: $selected")),
                  );
                }
              },
              child: _buildMenuCard(
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
              ),
            );
          },
        ),
      ),

      // === Floating Action Button dengan Option Menu ===
      floatingActionButton: PopupMenuButton<String>(
        icon: const Icon(Icons.add_circle, size: 56, color: Colors.blueAccent),
        onSelected: (value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("FAB option: $value")));
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'add',
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.black54),
                SizedBox(width: 8),
                Text("Add"),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.black54),
                SizedBox(width: 8),
                Text("Edit"),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.black54),
                SizedBox(width: 8),
                Text("Delete"),
              ],
            ),
          ),
        ],
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
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
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
