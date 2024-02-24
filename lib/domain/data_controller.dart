import 'package:fpdart/fpdart.dart';

import 'async_controller.dart';
import 'async_state.dart';
import 'response_failure.dart';

typedef SourceType<Response> = Future<Either<ResponseFailure, Response>>
    Function();

final class DataController<Response> extends AsyncController<Response> {
  DataController(
    SourceType<Response> source, {
    AsyncState<Response> initState = const Ideal(),
  })  : _source = source,
        super(initState: initState);

  final SourceType<Response> _source;

  void load() async {
    emit(const Loading());
    final response = await _source();
    response.fold(
      (l) => emit(Failed(l)),
      (r) => emit(Loaded(r)),
    );
  }

  void reload() {
    if (state is! Loaded) return;
    load();
  }

  Future<void> refresh() async {
    if (state is! Loaded) return;
    final response = await _source();
    response.fold(
      (_) => null,
      (r) => emit(Loaded(r)),
    );
  }

  void retry() {
    if (state is! Failed) return;
    load();
  }

  void update(Response response) {
    if (state is! Loaded) return;
    emit(Loaded(response));
  }
}
