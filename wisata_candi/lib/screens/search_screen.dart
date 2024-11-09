import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/models/candi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // todo1 deklarasikan variabel yang dibutuhkan
  List<Candi> _filteredCandis = candiList;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // Todo 2 Buat appbar dengan judul pencarian
      appBar: AppBar(title: Text("Pencarian Candi"),),
      //   Todo3 buat body berupa column
      body: Column(
        children: [
    //   todo4 buat textfield pencarian sebagai anak dari column
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: const TextField(
                autofocus: false,
                // Todo 6 IMPLEMENTASI FITUR PENCARIAN
                decoration: InputDecoration(
                  hintText: 'Cari Candi...',
                  prefixIcon: Icon(Icons.search),
                  // TODO7. IMPLEMENTASI PENGOSONGAN INPUT
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide : BorderSide(color: Colors.deepPurple),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
    //   todo5 buat listview hasil pencarian sebagai anak dari column
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCandis.length,
              itemBuilder: (context, index) {
                final candi = _filteredCandis[index];
                // TODO 8 IMPLEMENTASI GESTUREDETECTOR DAN HERO ANIMATION
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                          candi.imageAsset,
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(candi.name,
                                style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4,),
                            Text(candi.location)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
