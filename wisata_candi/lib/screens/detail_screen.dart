import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_candi/models/candi.dart';

class DetailScreen extends StatefulWidget{
  final Candi candi;
  const DetailScreen({super.key, required this.candi});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    // memeriksa status sign in saat layar dibuka
    _checkSignInStatus();
    // memeriksa status favorite saat layar dibuka
    _loadFavoriteStatus();

  }
  // memeriksa status sign in
  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
  }

  // membuat status favorite
  void _loadFavoriteStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favorite = prefs.getBool('favorite_${widget.candi.name}') ?? false;
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void>_toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Memerikasa apakah pengguna sudah sign in
    if(!isSignedIn){
    //   jika belum sign in, arahkan ke signInScreen
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pushReplacementNamed(context, '/signin');
      });
      return;
    }
    bool favoriteStatus = !isFavorite;
    prefs.setBool('favorite_${widget.candi.name}', favoriteStatus);

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          Stack(
            children: [
              //gambar utama
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.candi.imageAsset,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              ),
              // //tombol back kustom
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,
                  ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100]?.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                 child: IconButton(onPressed: () {
                   Navigator.pop(context);
                 },
                     icon: const Icon(
                       Icons.arrow_back,
                     ),
                 ),
              ),
              ),
            ],
          ),
          //Detail info
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16,),
                //info atas(nama candi dan favirite)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.candi.name,
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    IconButton(onPressed: (){
                      _toggleFavorite();
                    },
                    icon: Icon(isSignedIn && isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                      color: isSignedIn && isFavorite ? Colors.red : null,),
                    )
                  ],
                ),
                //info tengah(lokasi, dibangun, tipe)
                SizedBox(height: 16,),
                Row(children: [
                  Icon(Icons.place, color: Colors.red,),
                  SizedBox(width: 8,),
                  SizedBox(width: 70,
                      child: Text("Lokasi", style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                  Text((': ${widget.candi.location}')),
                ],),
                Row(children: [
                  Icon(Icons.calendar_month, color: Colors.blue,),
                  SizedBox(width: 8,),
                  SizedBox(width: 70,
                    child: Text("Dibangun", style: TextStyle(
                        fontWeight: FontWeight.bold),),),
                  Text((': ${widget.candi.built}')),
                ],),
                Row(children: [
                  Icon(Icons.house, color: Colors.green,),
                  SizedBox(width: 8,),
                  SizedBox(width: 70,
                    child: Text("Tipe", style: TextStyle(
                        fontWeight: FontWeight.bold),),),
                  Text((': ${widget.candi.type}')),
                ],),
                SizedBox(height: 16,),
                Divider(color: Colors.deepPurple.shade100,),
                SizedBox(height: 16,
                  child: Text("Deskripsi", style: TextStyle(
                    fontWeight: FontWeight.bold),),),
                SizedBox(height: 16,),
                Text(('${widget.candi.description}'))
                //info bawah(deskripsi)

              ],
            ),
          ),
          //Detail Gallery
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.deepPurple.shade100,),
                  Text('Galery',style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.candi.imageUrls.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.deepPurple.shade100,
                                width: 2,
                              )
                            ),
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  imageUrl: widget.candi.imageUrls[index],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.deepPurple[50],
                                  ),
                                errorWidget: (context, url, error) =>Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text('Tap untuk memperbesar', style: TextStyle(
                    fontSize: 12, color: Colors.black54,
                  ),)
                ],
              ),
          )

        ],
      ),
      ),

    );


  }
}