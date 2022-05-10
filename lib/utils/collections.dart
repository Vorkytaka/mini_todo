import 'dart:math';

extension IterableUtils<E> on Iterable<E> {
  E? firstOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

int countChildWithSeparators(int childCount) {
  return max(0, childCount * 2 - 1);
}
