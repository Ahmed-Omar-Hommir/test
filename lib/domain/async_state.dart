import 'package:equatable/equatable.dart';

import 'response_failure.dart';

sealed class AsyncState<Response> {
  const AsyncState();
}

class Ideal<Response> extends AsyncState<Response> {
  const Ideal();
}

class Loading<Response> extends AsyncState<Response> {
  const Loading();
}

class Loaded<Response> extends AsyncState<Response> with EquatableMixin {
  const Loaded(this.data);
  final Response data;

  @override
  List<Object?> get props => [data];
}

class Failed<Response> extends AsyncState<Response> with EquatableMixin {
  const Failed(this.failure);
  final ResponseFailure failure;

  @override
  List<Object?> get props => [failure];
}
