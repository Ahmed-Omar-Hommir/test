import 'package:bloc/bloc.dart';
import 'async_state.dart';

class AsyncController<Response> extends Cubit<AsyncState<Response>> {
  AsyncController({
    AsyncState<Response> initState = const Loading(),
  }) : super(initState);
}

// Paginated Data
// Stream Data
// Custom Merge
