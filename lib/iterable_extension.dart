/// Extension that applies to all iterables.
///
/// Contains common functionality used on iterables.
extension IterableExtension<E> on Iterable<E> {
  /// Interlaces the elements with the elements from [other] iterable to create
  /// an iterable with one element of each stream at the time.
  ///
  /// If one of the iterables is bigger than the other then the remaining
  /// elements from that iterable will be added to the end.
  Iterable<E> interlaceWith(Iterable<E> other) sync* {
    final first = this.iterator;
    final second = other.iterator;
    while (first.moveNext()) {
      yield first.current;

      if (second.moveNext()) {
        yield second.current;
      }
    }

    while (second.moveNext()) {
      yield second.current;
    }
  }

  /// Introduces a separator between all elements of the iterable.
  ///
  /// The separator can be dynamically adjusted for each call.
  Iterable<E> separatedBy(E Function(int index) separator) sync* {
    int index = -1;
    for (var item in this) {
      if (index != -1) yield separator(index);
      yield item;
      ++index;
    }
  }

  /// Converts each element to a [String] and concatenates the strings taking
  /// into account serial comma (also known as Oxford comma).
  ///
  /// Iterates through elements of this iterable,
  /// converts each one to a [String] by calling [Object.toString],
  /// and then concatenates the strings taking into account the punctuation.
  String joinOxford({String coordinator = 'and'}) {
    final StringBuffer buffer = StringBuffer();
    final iterator = this.iterator;
    if (iterator.moveNext()) return '';
    buffer.write(iterator.current);
    bool wroteMoreThanTwo = false;
    while (iterator.moveNext()) {
      final current = iterator.current;
      final currentIsLast = !iterator.moveNext();
      if (currentIsLast) {
        buffer.write(wroteMoreThanTwo
            ? ', $coordinator $current'
            : ' $coordinator $current');
        break;
      } else {
        buffer.write(', $current');
      }
      wroteMoreThanTwo = true;
    }
    return buffer.toString();
  }
}
