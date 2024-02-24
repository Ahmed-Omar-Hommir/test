import 'package:anis_test/anis_test_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'bloc/card_list_cubit.dart';
import 'card_list.dart';

void main() {
  late CardRepoMock repo;
  late Widget wut;

  setUp(() {
    repo = CardRepoMock();
    wut = MaterialApp(home: composeCartListPage(repo));
  });

  anisTestWidgets(
    'should show loading while fetching data',
    (tester, task) async {
      // Given
      when(() => repo.fetchData()).answer(
        [],
        take: task.take(const Duration(seconds: 3)),
      );

      await tester.pumpWidget(wut);

      // When
      await tester.pump(const Duration(seconds: 1));

      // Then
      final loading = find.byType(CircularProgressIndicator);
      expect(loading, findsOne);
    },
  );

  anisTestWidgets(
    'show items after fetching data',
    (tester, task) async {
      // Given
      when(() => repo.fetchData()).answer(
        List.generate(
          20,
          (index) => CardItem(name: 'Card $index', price: 100 * index),
        ),
        take: task.take(const Duration(seconds: 3)),
      );

      await tester.pumpWidget(wut);

      // When
      await tester.pump(const Duration(seconds: 3));

      // Then
      final loading = find.text('Card 0');
      expect(loading, findsOne);
    },
  );

  anisTestWidgets(
    'should reload data when retry button is pressed',
    (tester, task) async {
      // Given
      when(() => repo.fetchData()).thenThrow(Error());

      await tester.pumpWidget(wut);
      await tester.pump();

      final retryButton = find.byType(ElevatedButton);

      when(() => repo.fetchData()).answer(
        List.generate(
          20,
          (index) => CardItem(name: 'Card $index', price: 100 * index),
        ),
        take: task.take(const Duration(seconds: 3)),
      );

      // When
      await tester.tap(retryButton);
      await tester.pump(const Duration(seconds: 3));

      // Then
      final loading = find.text('Card 0');
      expect(loading, findsOne);
    },
  );
}

// Repository

class CardRepoMock extends Mock implements CardRepo {}

extension WhenEx<T> on When<Future<T>> {
  void answer(T result, {Task<void>? take}) {
    thenAnswer(
      (_) async {
        await take?.run();
        return result;
      },
    );
  }
}
