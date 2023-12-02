class ImmutableOrderedMap<K, V> {
  final List<dynamic> _content;

  ImmutableOrderedMap._(this._content);

  /// Retrieve the index of the value stored under `key`, or return -1 when
  /// no such key exists.
  int find(K key) {
    for (int i = 0; i < _content.length; i += 2) {
      if (_content[i] == key) {
        return i;
      }
    }
    return -1;
  }

  /// Retrieve the value stored under `key`, or return undefined when
  /// no such key exists.
  V? get(K key) {
    final found = find(key);
    return found == -1 ? null : _content[found + 1];
  }

  /// Create a new map by replacing the value of `key` with a new
  /// value, or adding a binding to the end of the map. If `newKey` is
  /// given, the key of the binding will be replaced with that key.
  ImmutableOrderedMap<K, V> update(K key, V value, K? newKey) {
    final self = newKey != null && newKey != key ? this.remove(newKey) : this;
    var found = self.find(key);
    final content = [..._content];
    if (found == -1) {
      content.add(newKey ?? key);
      content.add(value);
    } else {
      content[found + 1] = value;
      if (newKey != null) {
        content[found] = newKey;
      }
    }
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Return a map with the given key removed, if it existed.
  ImmutableOrderedMap<K, V> remove(K key) {
    var found = this.find(key);
    if (found == -1) {
      return this;
    }
    var content = [..._content];
    content.removeRange(found, found + 2);
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Add a new key to the start of the map.
  ImmutableOrderedMap<K, V> addToStart(K key, V value) {
    final content = [key, value, ...remove(key)._content];
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Add a new key to the end of the map.
  ImmutableOrderedMap<K, V> addToEnd(key, value) {
    var content = [...this.remove(key)._content];
    content.add(key);
    content.add(value);
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Add a key after the given key. If `place` is not found, the new
  /// key is added to the end.
  ImmutableOrderedMap<K, V> addBefore(K place, K key, V value) {
    var without = this.remove(key);
    final content = [...without._content];
    var found = without.find(place);
    content.insert(found == -1 ? content.length : found, key);
    content.insert(found == -1 ? content.length : found + 1, value);
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Call the given function for each key/value pair in the map, in
  /// order.
  void forEach(void Function(K, V) f) {
    for (var i = 0; i < _content.length; i += 2) {
      f(_content[i], _content[i + 1]);
    }
  }

  /// Create a new map by prepending the keys in this map that don't
  /// appear in `map` before the keys in `map`.
  ImmutableOrderedMap<K, V> prepend(Map<K, V> map) {
    final ioMap = ImmutableOrderedMap.from(map);
    if (ioMap.size == 0) {
      return this;
    }
    final content = [...ioMap._content, ...this.subtract(map)._content];
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Create a new map by appending the keys in this map that don't
  /// appear in `map` after the keys in `map`.
  ImmutableOrderedMap<K, V> append(Map<K, V> map) {
    final ioMap = ImmutableOrderedMap.from(map);
    if (ioMap.size == 0) {
      return this;
    }
    final content = [...this.subtract(map)._content, ...ioMap._content];
    return ImmutableOrderedMap<K, V>._(content);
  }

  /// Create a map containing all the keys in this map that don't
  /// appear in `map`.
  ImmutableOrderedMap<K, V> subtract(Map<K, V> map) {
    var result = this;
    final ioMap = ImmutableOrderedMap.from(map);
    for (var i = 0; i < ioMap._content.length; i += 2) {
      result = result.remove(ioMap._content[i]);
    }
    return result;
  }

  /// The amount of keys in this map.
  get size {
    return _content.length >> 1;
  }

  Map<K, V> toMap() {
    Map<K, V> result = {};
    this.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  /// Return a map with the given content. If null, create an empty
  /// map. If given an ordered map, return that map itself. If given an
  /// object, create a map from the object's properties.
  static from<K, V>(Map<K, V>? map) {
    final List<dynamic> content = [];
    if (map != null) {
      map.forEach((key, value) {
        content.add(key);
        content.add(value);
      });
    }
    return ImmutableOrderedMap._(content);
  }
}
