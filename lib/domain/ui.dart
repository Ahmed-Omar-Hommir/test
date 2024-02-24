// import 'package:flutter/widgets.dart';

// import 'data_controller.dart';
// import 'param_data_controller.dart';
// import 'restaurant_repo.dart';

// class RestaurantCubit extends ParamDataController {
//   RestaurantCubit(this.restaurantRepo) : super(restaurantRepo.getRestaurant);

//   final RestaurantRepo restaurantRepo;

//   void loadRestaurant(int id) {
//     load(id);
//   }
// }

// void make() {}

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     final restaurantRepo = RestaurantRepo();

//     final controller = ParamDataController(restaurantRepo.getRestaurant);
//     controller.load((id: 1, filter: null));

//     final controllerc = ParamDataController(restaurantRepo.getRestaurant);
//     final controllerx = DataController(restaurantRepo.getNearbyRestaurants);

//     controller.load((id: 1, filter: null));

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox();
//   }
// }
