import 'package:bloc/bloc.dart';
import 'package:rules/domain/async_state.dart';
import 'package:rules/domain/response_failure.dart';

class CardListCubit extends Cubit<AsyncState<List<CardItem>>> {
  CardListCubit(this.repo) : super(const Ideal());

  final CardRepo repo;

  Future<void> fetch() async {
    try {
      emit(const Loading());
      final data = await repo.fetchData();
      final items = data
          .map(
            (item) => CardItem(
              name: item.name,
              price: item.price,
            ),
          )
          .toList();
      emit(Loaded(items));
    } catch (e) {
      emit(const Failed(ResponseFailureX()));
    }
  }
}

class CardItem {
  final String name;
  final int price;

  CardItem({
    required this.name,
    required this.price,
  });
}

class CardRepo {
  Future<List<CardItem>> fetchData() async {
    return List.generate(
      20,
      (index) => CardItem(
        name: 'Card $index',
        price: 100 * index,
      ),
    );
  }
}
