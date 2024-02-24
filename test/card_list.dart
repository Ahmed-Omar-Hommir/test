import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rules/domain/async_state.dart';

import 'bloc/card_list_cubit.dart';

Widget composeCartListPage(CardRepo repo) {
  return BlocProvider(
    create: (context) => CardListCubit(repo)..fetch(),
    child: const CardListPage(),
  );
}

class CardListPage extends StatefulWidget {
  const CardListPage({super.key});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CardListCubit, AsyncState<List<CardItem>>>(
        builder: (context, state) {
          return switch (state) {
            Ideal<List<CardItem>>() => const SizedBox(),
            Loading<List<CardItem>>() => const CircularProgressIndicator(),
            Loaded<List<CardItem>>(data: final items) => ListView.builder(
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.price.toString()),
                  );
                },
                itemCount: items.length,
              ),
            Failed<List<CardItem>>() => ElevatedButton(
                onPressed: () {
                  context.read<CardListCubit>().fetch();
                },
                child: const Text('Retry'),
              ),
          };
        },
      ),
    );
  }
}
