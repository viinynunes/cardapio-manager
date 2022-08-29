import 'package:cardapio_manager/src/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio_manager/src/modules/menu/domain/usecases/impl/item_menu_usecase_impl.dart';
import 'package:cardapio_manager/src/modules/menu/errors/item_menu_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories_mocks.mocks.dart';

main() {
  final repository = MockIItemMenuRepository();
  final usecase = ItemMenuUsecaseImpl(repository);
  late ItemMenu item;

  setUp(() {
    item = ItemMenu(
        id: 'AAAA',
        name: 'Arroz, contra filé e batata frita',
        description: 'AAA',
        imgUrl: 'https://',
        enabled: true,
        weekdayList: [1, 5]);

    when(repository.create(any))
        .thenAnswer((realInvocation) async => Right(item));

    when(repository.create(any))
        .thenAnswer((realInvocation) async => Right(item));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));

    when(repository.findAll())
        .thenAnswer((realInvocation) async => Right(<ItemMenu>[item, item]));
  });

  group('Tests to create a new Item Menu', () {
    test('should return a item Menu when everything is correct', () async {
      var result = await usecase.create(item);

      expect(result.fold(id, id), isA<ItemMenu>());
      expect(result.fold((l) => null, (r) => r.name),
          equals('Arroz, contra filé e batata frita'));
    });

    test('should return a ItemMenuError when name length has less then 2 chars',
        () async {
      item.name = 'a';

      var result = await usecase.create(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Enter a valid name'));
    });

    test('should return a ItemMenuError when weekday list is empty', () async {
      item.weekdayList = [];

      var result = await usecase.create(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid weekday list'));
    });
  });

  group('Tests to update an Item Menu', () {
    test('should return a item Menu when everything is correct', () async {
      var result = await usecase.update(item);

      expect(result.fold(id, id), isA<ItemMenu>());
      expect(result.fold((l) => null, (r) => r.name),
          equals('Arroz, contra filé e batata frita'));
    });

    test('should return a ItemMenuError when ID is Empty', () async {
      item.id = '';

      var result = await usecase.update(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('item menu id is invalid'));

      item.id = null;

      result = await usecase.update(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('item menu id is invalid'));
    });

    test('should return a ItemMenuError when name length has less then 2 chars',
        () async {
      item.name = 'a';

      var result = await usecase.update(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Enter a valid name'));
    });

    test('should return a ItemMenuError when weekday list is empty', () async {
      item.weekdayList = [];

      var result = await usecase.update(item);

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid weekday list'));
    });
  });

  group('Tests to disable Item Menu', () {
    test('should return a bool', () async {
      var result = await usecase.disable('AAA');

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should return an ItemMenuError when id is empty item menu', () async {
      var result = await usecase.disable('');

      expect(result.fold(id, id), isA<ItemMenuError>());
      expect(result.fold((l) => l.message, (r) => null), equals('Invalid id'));
    });
  });

  group('Tests to findAll method', () {
    test('should return a list of ItemMenu', () async {
      var result = await usecase.findAll();

      expect(result.fold(id, id), isA<List<ItemMenu>>());
    });
  });
}
