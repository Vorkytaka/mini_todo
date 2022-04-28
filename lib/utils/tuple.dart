import 'package:flutter/cupertino.dart';

typedef Pair<T1, T2> = Tuple2<T1, T2>;

class Tuple2<T1, T2> {
  final T1 value1;
  final T2 value2;

  const Tuple2(this.value1, this.value2);

  @override
  String toString() => 'Tuple2($value1, $value2)';

  @override
  bool operator ==(Object other) => other is Tuple2<T1, T2> && value1 == other.value1 && value2 == other.value2;

  @override
  int get hashCode => hashValues(value1, value2);
}
