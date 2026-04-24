import 'package:flutter/material.dart';
import 'package:mobileprogramming_pertemuan6/pertemuan/pertemuan5.dart';

class PertemuanPage extends StatelessWidget {
  final Pertemuan pertemuan;

  PertemuanPage({Key? key, required this.pertemuan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pertemuan.title)),
      body: Column(
        children: [
          Text(
            pertemuan.subtitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
