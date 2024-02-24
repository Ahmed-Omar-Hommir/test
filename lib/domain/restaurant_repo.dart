import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'response_failure.dart';

part 'restaurant_repo.g.dart';

@JsonSerializable()
class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
  });

  final int id;
  final String name;
  final String description;
  final bool isFavorite;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  Restaurant copyWith({
    int? id,
    String? name,
    String? description,
    bool? isFavorite,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Category {}

class RestaurantRepo {
  RestaurantRepo({
    required Dio dio,
  }) : _remoteApi = _RestaurantRemoteApi(dio);

  final _RestaurantRemoteApi _remoteApi;

  Future<Either<ResponseFailure, Restaurant>> getRestaurant(
      ({
        int id,
        String? filter,
      }) param) async {
    return right(
      const Restaurant(
        id: 1,
        name: 'name',
        description: 'description',
        isFavorite: true,
      ),
    );
  }

  Future<Either<ResponseFailure, List<Restaurant>>>
      getNearbyRestaurants() async {
    try {
      final response = await _remoteApi.getRestaurants();
      return right(response);
    } catch (e) {
      return left(const ResponseFailureX());
    }
  }

  Future<Either<ResponseFailure, List<Category>>> getCategories() async {
    return right([]);
  }

  Future<Either<ResponseFailure, List<Restaurant>>>
      getFeaturedRestaurants() async {
    return right([]);
  }
}

@RestApi(baseUrl: 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/')
abstract class _RestaurantRemoteApi {
  factory _RestaurantRemoteApi(Dio dio) = __RestaurantRemoteApi;

  @GET('/restaurants')
  Future<List<Restaurant>> getRestaurants();
}

@HiveType(typeId: 0)
class RestaurantCM extends HiveObject {
  RestaurantCM({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
  });
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isFavorite;
}

extension RestaurantToCache on Restaurant {
  RestaurantCM toCache() {
    return RestaurantCM(
      id: id,
      name: name,
      description: description,
      isFavorite: isFavorite,
    );
  }
}

extension RestaurantCMToDomain on RestaurantCM {
  Restaurant toDomain() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      isFavorite: isFavorite,
    );
  }
}

class RestaurantExplorerCubit extends Cubit<List<Restaurant>> {
  RestaurantExplorerCubit() : super([]);

  void favorites({
    required int id,
    required bool isFavorite,
  }) {
    emit(state.favorite(id: id, isFavorite: isFavorite));
  }
}

class RestaurantSearchCubit extends Cubit<List<Restaurant>> {
  RestaurantSearchCubit() : super([]);

  void favorites({
    required int id,
    required bool isFavorite,
  }) {
    emit(state.favorite(id: id, isFavorite: isFavorite));
  }
}

// Service Pattern

abstract class Favorite {
  static List<Restaurant> toggle({
    required int id,
    required bool isFavorite,
    required List<Restaurant> restaurants,
  }) {
    return restaurants.map((restaurant) {
      if (restaurant.id == id) {
        return restaurant.copyWith(isFavorite: isFavorite);
      }
      return restaurant;
    }).toList();
  }
}

// Extension Patterns

extension FavoriteToggle on List<Restaurant> {
  List<Restaurant> favorite({
    required int id,
    required bool isFavorite,
  }) {
    return map((restaurant) {
      if (restaurant.id == id) {
        return restaurant.favorite(isFavorite: isFavorite);
      }
      return restaurant;
    }).toList();
  }
}

extension FavoriteToggleX on Restaurant {
  Restaurant favorite({
    required bool isFavorite,
  }) {
    final sream = Stream.empty();
    sream.listen((event) {
      print(event);
    });
    return copyWith(isFavorite: isFavorite);
  }
}
