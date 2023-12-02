import 'package:immutable_ordered_map/immutable_ordered_map.dart';

void main() {
  final map = ImmutableOrderedMap.from({'a': 1, 'b': 2});
  print(map.get('a')); // 1
  print(map.get('b')); // 2
  print(map.get('c')); // null
  print(map.update('a', 3, null).get('a')); // 3
  print(map.update('a', 3, 'c').get('c')); // 3
  print(map.update('c', 3, null).get('c')); // 3
}
