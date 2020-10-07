import 'package:fruit_and_veggie_bucket/src/model/model.dart';

abstract class PlantsRepository {
  Future<List<Plant>> loadPlants();

  Future<List<Plant>> loadCart();

  Future insertCart(Plant plant);

  Future insertPlants(List<Plant> plants);
}