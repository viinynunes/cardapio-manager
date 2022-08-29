import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:cardapio_manager/src/modules/menu/infra/models/item_menu_model.dart';
import 'package:cardapio_manager/src/modules/menu/infra/repositories/item_menu_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasources/mock_datasources.mocks.dart';

main() {
  final datasource = MockIItemMenuDatasource();
  final repository = ItemMenuRepositoryImpl(datasource);
  late ItemMenuModel item;

  setUp(() {
    item = ItemMenuModel(
        id: 'AAAA',
        name: 'Arroz, contra filé e batata frita',
        description: 'AAA',
        imgUrl: 'https://',
        enabled: true,
        weekdayList: [1, 5]);

    when(datasource.create(any)).thenAnswer((realInvocation) async => item);

    when(datasource.update(any)).thenAnswer((realInvocation) async => item);

    when(datasource.disable(any)).thenAnswer((realInvocation) async => true);
  });

  group('Tests to create an Item Menu', () {
    test('Should return a ItemMenuModel from datasource', () async {
      final result = await repository.create(item);

      expect(result.fold(id, id), isA<ItemMenu>());
      expect(result.fold((l) => null, (r) => r.id), equals('AAAA'));
    });

    test('should throw an ItemMenuError when something goes wrong', () async {
      when(datasource.create(any)).thenThrow(Exception('Uncaught Error'));

      final result = await repository.create(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Exception: Uncaught Error'));
    });
  });

  group('Tests to update an Item Menu', () {
    test('Should return a ItemMenuModel from datasource', () async {
      final result = await repository.update(item);

      expect(result.fold(id, id), isA<ItemMenu>());
      expect(result.fold((l) => null, (r) => r.id), equals('AAAA'));
    });

    test('should throw an ItemMenuError when something goes wrong', () async {
      when(datasource.update(any)).thenThrow(Exception('Uncaught Error'));

      final result = await repository.update(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Exception: Uncaught Error'));
    });
  });

  group('Tests to disable an Item Menu', () {
    test('Should return a ItemMenuModel from datasource', () async {
      final result = await repository.disable('AAA');

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should throw an ItemMenuError when something goes wrong', () async {
      when(datasource.disable(any)).thenThrow(Exception('Uncaught Error'));

      final result = await repository.disable('AAAA');

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Exception: Uncaught Error'));
    });
  });
}
