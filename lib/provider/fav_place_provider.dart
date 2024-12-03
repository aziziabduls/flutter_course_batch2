import 'package:flutter/cupertino.dart';
import 'package:flutter_course_batch_2/screens/fav_place/fav_place_model.dart';

class FavPlaceProvider extends ChangeNotifier {
  final List<FavoritePlaceModel> _favPlaceModel = [];
  List<FavoritePlaceModel> get favPlaceModel => _favPlaceModel;
  void addPlace(FavoritePlaceModel item) {
    _favPlaceModel.add(
      FavoritePlaceModel(
        name: item.name,
        image: item.image,
        location: item.location,
        lat: item.lat,
        lng: item.lng,
      ),
    );
    notifyListeners();
  }
}
