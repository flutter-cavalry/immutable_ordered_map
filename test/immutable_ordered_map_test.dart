import 'package:immutable_ordered_map/immutable_ordered_map.dart';
import 'package:test/test.dart';

void main() {
  test('find', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.find('a'), 0);
    expect(map.find('b'), 2);
    expect(map.find('c'), -1);
  });

  test('get', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.get('a'), 1);
    expect(map.get('b'), 2);
    expect(map.get('c'), null);
  });

  test('update', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.update('a', 3, null).get('a'), 3);
    expect(map.update('a', 3, 'c').get('c'), 3);
    expect(map.update('c', 3, null).get('c'), 3);
    expect(map.update('c', 3, 'c').get('c'), 3);
  });

  test('remove', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.remove('a').get('a'), null);
    expect(map.remove('b').get('b'), null);
    expect(map.remove('c').get('c'), null);
  });

  test('addToStart', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.addToStart('a', 3).get('a'), 3);
    expect(map.addToStart('a', 3).get('b'), 2);
    expect(map.addToStart('c', 3).get('c'), 3);
    expect(map.addToStart('c', 3).get('a'), 1);
  });

  test('fromMap', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.get('a'), 1);
    expect(map.get('b'), 2);
    expect(map.get('c'), null);
  });

  test('addBefore', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.addBefore('a', 'c', 3).get('c'), 3);
    expect(map.addBefore('a', 'c', 3).get('a'), 1);
    expect(map.addBefore('a', 'c', 3).get('b'), 2);
    expect(map.addBefore('b', 'c', 3).get('c'), 3);
    expect(map.addBefore('b', 'c', 3).get('a'), 1);
    expect(map.addBefore('b', 'c', 3).get('b'), 2);
    expect(map.addBefore('c', 'c', 3).get('c'), 3);
    expect(map.addBefore('c', 'c', 3).get('a'), 1);
    expect(map.addBefore('c', 'c', 3).get('b'), 2);
  });

  test('forEach', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    final keys = <String>[];
    final values = <int>[];
    map.forEach((key, value) {
      keys.add(key);
      values.add(value);
    });
    expect(keys, ['a', 'b']);
    expect(values, [1, 2]);
  });

  test('prepend', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    final map2 = map.prepend({'c': 3, 'd': 4});
    expect(map2.get('a'), 1);
    expect(map2.get('b'), 2);
    expect(map2.get('c'), 3);
    expect(map2.get('d'), 4);
  });

  test('append', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    final map2 = map.append({'c': 3, 'd': 4});
    expect(map2.get('a'), 1);
    expect(map2.get('b'), 2);
    expect(map2.get('c'), 3);
    expect(map2.get('d'), 4);
  });

  test('subtract', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    final map2 = map.subtract({'a': 1, 'b': 2});
    expect(map2.get('a'), null);
    expect(map2.get('b'), null);
  });

  test('size', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.size, 2);
  });

  test('toMap', () {
    final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
    expect(map.toMap(), {'a': 1, 'b': 2});
  });
}
