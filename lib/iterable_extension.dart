extension IterableExtension<E> on Iterable<E> {
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

  Iterable<E> separatedBy(E Function(int index) separator) sync* {
    int index = -1;
    for (var item in this) {
      if (index != -1) yield separator(index);
      yield item;
      ++index;
    }
  }

  String joinOxford() {
    final StringBuffer buffer = StringBuffer();
    final iterator = this.iterator;
    if (iterator.moveNext()) return '';
    buffer.write(iterator.current);
    bool wroteMoreThanTwo = false;
    while (iterator.moveNext()) {
      final current = iterator.current;
      final currentIsLast = !iterator.moveNext();
      if (currentIsLast) {
        buffer.write(wroteMoreThanTwo ? ', and $current' : ' and $current');
        break;
      } else {
        buffer.write(', $current');
      }
      wroteMoreThanTwo = true;
    }
    return buffer.toString();
  }
}
