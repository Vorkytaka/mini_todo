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
