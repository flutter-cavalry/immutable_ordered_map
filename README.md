[![pub package](https://img.shields.io/pub/v/immutable_ordered_map.svg)](https://pub.dev/packages/immutable_ordered_map)
[![Build Status](https://github.com/flutter-cavalry/immutable_ordered_map/workflows/Build/badge.svg)](https://github.com/flutter-cavalry/immutable_ordered_map/actions)

# immutable_ordered_map

A dart implementation of Immutable ordered map. A port of [orderedmap](https://github.com/marijnh/orderedmap).

## Usage

Refer to the [original repo](https://github.com/marijnh/orderedmap) for usage. There are some breaking changes though:

- The original `OrderedMap` is renamed to `ImmutableOrderedMap` for clarity.
- `ImmutableOrderedMap` is now a generic class with two type parameters: `K` and `V`.
- The original `OrderedMap.toObject` is renamed to `ImmutableOrderedMap.toMap` (Dart doesn't have a map-like Object type, use `Map<T, V>` instead).
