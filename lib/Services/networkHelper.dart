
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/Services/model.dart';

import 'nowplaying_model.dart';

class NetworkHelper{


Future getTrendingData() async{
var trendingModel;
final response = await http.get
 (Uri.parse('https://api.themoviedb.org/3/trending/all/day'),
 headers: 
{
  'Authorization' :
  'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMDhlZmVmYzJiODcyMzE4N2QyY2E3ZjgyOGU4NzFiMCIsInN1YiI6IjY0ZGI2YTI4ZDEwMGI2MDBhZGEzMDQ2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b47L6bxWyr3Rnio0wTqvwKE7q0px76Fm8sjBFURv9xM'
}
);

if(response.statusCode==200)
{
print(response.statusCode);

print(response.body);
var decodedData = jsonDecode(response.body);
 trendingModel = TrendingData.fromJson(decodedData);
}

//return jaile if bahira garne
  return trendingModel;


  //for now playing model
  





}

Future getNowPlayingData() async{
  var nowPlayingModel;
final nowPlayingURL=  await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),

headers: 
{
  'Authorization' :
  'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMDhlZmVmYzJiODcyMzE4N2QyY2E3ZjgyOGU4NzFiMCIsInN1YiI6IjY0ZGI2YTI4ZDEwMGI2MDBhZGEzMDQ2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b47L6bxWyr3Rnio0wTqvwKE7q0px76Fm8sjBFURv9xM'
}
);
if(nowPlayingURL.statusCode==200){

  print(nowPlayingURL.statusCode);
  print(nowPlayingURL.body);
  var finaldata = jsonDecode(nowPlayingURL.body);
nowPlayingModel = NowPlaying.fromJson(finaldata);
  
}

return nowPlayingModel;

}




}