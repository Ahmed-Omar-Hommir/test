import 'package:fpdart/fpdart.dart';

import 'async_controller.dart';
import 'async_state.dart';
import 'response_failure.dart';

typedef ParamSourceType<Response, Param>
    = Future<Either<ResponseFailure, Response>> Function(Param param);

class ParamDataController<Response, Param> extends AsyncController<Response> {
  ParamDataController(
    ParamSourceType<Response, Param> source, {
    AsyncState<Response> initState = const Ideal(),
  })  : _source = source,
        super(initState: initState);

  final ParamSourceType<Response, Param> _source;

  Param? _param;

  void load(Param param) async {
    _param = param;
    emit(const Loading());
    final response = await _source(param);
    response.fold(
      (l) => emit(Failed(l)),
      (r) => emit(Loaded(r)),
    );
  }

  void reload() {
    if (state is! Loaded) return;
    final param = _param;
    if (param == null) return;
    load(param);
  }

  Future<void> refresh() async {
    if (state is! Loaded) return;
    final param = _param;
    if (param == null) return;
    final response = await _source(param);
    response.fold(
      (_) => null,
      (r) => emit(Loaded(r)),
    );
  }

  void retry() {
    if (state is! Failed) return;
    final param = _param;
    if (param == null) return;
    load(param);
  }

  void update(Response response) {
    if (state is! Loaded) return;
    emit(Loaded(response));
  }
}
