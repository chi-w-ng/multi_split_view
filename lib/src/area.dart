/// Child area in the [MultiSplitView].
///
/// The area may have a [size] defined in pixels or [weight]
/// between 0 and 1.
/// Both [weight] and [minimalWeight] values will be multiplied by the total
/// size available ignoring the thickness of the dividers.
/// Before being visible for the first time, the [size] will be converted
/// to [weight] according to the size of the widget.
class Area {
  factory Area(
      {double? size,
      double? weight,
      double? minimalWeight,
      double? minimalSize}) {
    if (size != null && weight != null) {
      throw Exception('Cannot provide both a size and a weight.');
    }
    if (minimalWeight != null && minimalSize != null) {
      throw Exception('Cannot provide both a minimalWeight and a minimalSize.');
    }

    if (minimalWeight != null && (minimalWeight < 0 || minimalWeight > 1)) {
      throw Exception('The minimum weight must be between 0 and 1.');
    }

    return Area._(
        size: _check('size', size),
        weight: _check('weight', weight),
        minimalWeight: _check('minimalWeight', minimalWeight),
        minimalSize: _check('minimalSize', minimalSize));
  }

  Area._(
      {required this.size,
      required this.weight,
      required this.minimalWeight,
      required this.minimalSize});

  final double? size;
  final double? weight;
  final double? minimalWeight;
  final double? minimalSize;

  Area copyWithNewWeight(
      {double? weight, double? minimalWeight, double? minimalSize}) {
    return Area(
        size: null,
        weight: weight ?? this.weight,
        minimalSize: minimalSize ?? this.minimalSize,
        minimalWeight: minimalWeight ?? this.minimalWeight);
  }

  bool get hasMinimal => minimalSize != null || minimalWeight != null;

  static double? _check(String argument, double? value) {
    if (value != null) {
      if (value.isNaN) {
        throw Exception('$argument cannot be NaN');
      }
      if (value.isInfinite) {
        throw Exception('$argument cannot be Infinite');
      }
      if (value < 0) {
        throw Exception('$argument cannot be negative: $value');
      }
    }
    return value;
  }

  static List<Area> sizes(List<double> sizes) {
    List<Area> list = [];
    sizes.forEach((size) => list.add(Area(size: size)));
    return list;
  }

  static List<Area> weights(List<double> weights) {
    List<Area> list = [];
    weights.forEach((weight) => list.add(Area(weight: weight)));
    return list;
  }
}
