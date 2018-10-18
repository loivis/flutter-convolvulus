import 'package:convvls/model/favorite.dart';
import 'package:convvls/model/search.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FavoriteModel, SearchModel {}
