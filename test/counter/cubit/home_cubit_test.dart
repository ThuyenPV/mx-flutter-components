import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_flutter_components/home/home.dart';

void main() {
  group('HomeCubit', () {
    test('initial state is 0', () {
      expect(HomeCubit().state, equals(0));
    });

    blocTest<HomeCubit, int>(
      'emits [1] when increment is called',
      build: HomeCubit.new,
      act: (cubit) => cubit.increment(),
      expect: () => [equals(1)],
    );

    blocTest<HomeCubit, int>(
      'emits [-1] when decrement is called',
      build: HomeCubit.new,
      act: (cubit) => cubit.decrement(),
      expect: () => [equals(-1)],
    );
  });
}
