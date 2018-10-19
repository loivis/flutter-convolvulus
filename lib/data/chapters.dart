import 'dart:convert';
import 'package:convvls/data/chapter.dart';
import 'package:http/http.dart' as http;

class Chapters {
  Chapters();

//   Future<Chapter> latest(String site, bookName) async {
//     List<Chapter> chapters = await all(site, bookName);

//     if (chapters.length == 0) {
//       return null;
//     }

//     int i = chapters.length - 1;
//     return chapters[i];
//   }

  Future<List<Chapter>> all(String site, bookName) async {
    List<Chapter> _chapters = [];

    String url = 'https://convvls.herokuapp.com/chapters' +
        '?site=$site&book_name=$bookName';
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode != 200) {
      print('failed to get chapters for "$bookName" on "$site" from backend');
      return _chapters;
    }

    print("response body: ${resp.body}");
    Map<String, dynamic> bodyJson = json.decode(resp.body);
    bodyJson["chapters"].forEach((item) {
      print(item);
      _chapters.add(Chapter.fromJson(item));
    });

    print('return ${_chapters.length} chapters from backend for "$bookName"');
    return _chapters;
  }
}
