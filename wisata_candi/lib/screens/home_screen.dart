import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   Todo 1 buat appbar dengan judul wisata
      appBar: AppBar(title: Text('Wisata Candi'),),
    //   Todo2 buat body dengan gridview.buider
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.all(8),
          itemCount: candiList.length,
          itemBuilder: (context,index){
            Candi candi = candiList[index];
            return ItemCard(candi: candi);
          }
      ),
    //   Todo3 buat ItemCard sebagai return value dari gridview.builder
      
    );
  }
}
