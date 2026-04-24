import 'package:flutter/material.dart';
import 'package:mobileprogramming_pertemuan6/pages/profile.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan_page.dart';

class ListPage extends StatefulWidget {
  ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Widget> page = [ProfilePage(), ListPage()];
  List<Pertemuan> pertemuan = [
    Pertemuan(title: 'Pertemuan 1', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 2', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 3', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 4', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 5', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 6', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 7', subtitle: 'Pengenalan Android'),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          'List View',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: pertemuan.length,
        itemBuilder: (context, index) {
          final Pertemuan = pertemuan[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text(Pertemuan.title),
              subtitle: Text(Pertemuan.subtitle),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PertemuanPage(pertemuan: Pertemuan),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Pertemuan {
  final String title;
  final String subtitle;

  Pertemuan({required this.title, required this.subtitle});
}
