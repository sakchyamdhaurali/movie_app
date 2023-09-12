

import 'package:flutter/material.dart';
import 'package:movie_app/Services/nowplaying_model.dart';

import '../Services/model.dart';
import '../Services/networkHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<TrendingData>? trendingData;
  Future<NowPlaying>? nowPlaying;
  @override
  void initState() {
    // TODO: implement initState
    trendingData = getTrendingData();
    nowPlaying= getNowPlayingData();

    super.initState();
  }

  

  Future<TrendingData>? getTrendingData() async {
    NetworkHelper networkHelper = NetworkHelper();
    return await networkHelper.getTrendingData();
  }

Future<NowPlaying>? getNowPlayingData()async{
NetworkHelper netHelp= NetworkHelper();
return await netHelp.getNowPlayingData();
}

 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff242A32),
        elevation: 0,
        title: Text('NEPFLIX',
        style: TextStyle(
          color: Colors.red,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          
        ),),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff242A32),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  NetworkHelper networkHelper = NetworkHelper();
                  await networkHelper.getTrendingData();
                },
                child: Text(
                  'What do you want to watch?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                //margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xFF67676D)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF67676D),
                    ),
                    fillColor: Color(0xFF3A3F47),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 21,
              ),




              Text('Trending Movies',
               style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),),
                SizedBox(height: 10,),
              Container(
                height:350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: FutureBuilder<TrendingData>(
                  
                    future: trendingData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data?.results?.length,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var imageData =
                                  snapshot.data?.results?[index].posterPath;
                                  String? movieName = snapshot.data?.results?[index].originalTitle;
                           
                        
                              String? description =
                                  snapshot.data?.results?[index].overview;
                              double? famous= snapshot.data?.results?[index].popularity;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return TrendingDetailsPage(
                                          imageData, description,famous);
                                    }));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        height: 225,
                                        width: 150,
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500$imageData',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        movieName ?? (snapshot.data?.results?[index].name)!,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        //shrimmer
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              

     
             
              Text(
                'Now Playing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
        
              SizedBox(
                height: 10,
              ),
             





       Container(
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: FutureBuilder<NowPlaying>(
                    future: nowPlaying,
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        return Center(
                          child: Text(snapshot.error.toString(),
                          style: TextStyle(
                            color: Colors.white
                          ),
                          ),
                        );
                      }


                     else if (snapshot.hasData) { 
                        return ListView.builder(
                            itemCount: snapshot.data?.results?.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var imagePath =
                                  snapshot.data?.results?[index].posterPath;
                                  String? movieTitle = snapshot.data?.results?[index].originalTitle;
                           
            var random= snapshot.data?.results?[index].title;
                              String? overView =
                                  snapshot.data?.results?[index].overview;
                              double? poPular= snapshot.data?.results?[index].popularity!.toDouble();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return NowPlayingDetails(
                                          imagePath, overView,poPular,random);
                                    }));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                        height: 225,
                                        width: 150,
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500$imagePath',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        movieTitle ?? (snapshot.data?.results?[index].title)!,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      

                      
                      
                      
                       else{
                        
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        
                      }


                    }),
              ),
      
      
  

            
                
              
            ],
          ),
        )),
      ),
    );
  }
}


class TrendingDetailsPage extends StatelessWidget {
  final imageData;
  final description;
  final famous;
  
  // final poPular;
 
  // NowPlayingDetails(var imageNetwork, var description) {
  //   this.imageNetwork = imageNetwork;
  //   this.description = description;
  // }

  TrendingDetailsPage(this.imageData, this.description,this.famous);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff242A32),
        title: Text('Trending Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Container(
              width: 500,
              height: 300,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$imageData',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(description ?? 'Not Available',   style: TextStyle(fontSize: 15)),
        SizedBox(
            height: 20,
          ),
          Text('Popularity: ${famous.toString()}' , style: TextStyle(fontSize: 15)),
        ]),
      ),
    );
  }
}

class NowPlayingDetails extends StatelessWidget {
  final imagePath;
  final overView;
  final poPular;
 final random;
  // NowPlayingDetails(var imageNetwork, var description) {
  //   this.imageNetwork = imageNetwork;
  //   this.description = description;
  // }

  NowPlayingDetails(this.imagePath, this.overView,this.poPular,this.random);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff242A32),
        
        title: Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Container(
              width: 500,
              height: 300,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$imagePath',
                fit: BoxFit.contain,
              ),
            ),
          ),
      
          SizedBox(
            height: 20,
          ),
          Text(random,style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
       SizedBox(
            height: 20,
          ),
          Text(overView ?? '',
          style: TextStyle(fontSize: 15),),
        SizedBox(
            height: 20,
          ),
          Text('Popularity: ${poPular.toString()}',  style: TextStyle(fontSize: 15)),
          
        ]),
      ),
    );
  }
}