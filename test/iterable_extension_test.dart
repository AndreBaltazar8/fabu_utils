import 'package:fabu_utils/iterable_extension.dart';
import 'package:test/test.dart';

void main() {
  test('interlaceWith', () {
    expect([].interlaceWith([]), []);
    expect([].interlaceWith([1, 2, 3]), [1, 2, 3]);
    expect([1, 2, 3].interlaceWith([]), [1, 2, 3]);
    expect([1, 2, 3].interlaceWith([3, 2, 1]), [1, 3, 2, 2, 3, 1]);
    expect([1, 2, 3].interlaceWith([4, 5, 6]), [1, 4, 2, 5, 3, 6]);
    expect([1, 2, 3, 4, 5].interlaceWith([4, 5, 6]), [1, 4, 2, 5, 3, 6, 4, 5]);
    expect([1, 2, 3].interlaceWith([4, 5, 6, 7, 8]), [1, 4, 2, 5, 3, 6, 7, 8]);
  });

  test('separatedBy', () {
    expect([].separatedBy((i) => i), []);
    expect([1].separatedBy((i) => i), [1]);
    expect([1, 2, 3].separatedBy((i) => i), [1, 0, 2, 1, 3]);
  });

  test('joinOxford', () {
    expect([].joinOxford(), '');
    expect(['a'].joinOxford(), 'a');
    expect(['a', 'b'].joinOxford(), 'a and b');
    expect(['a', 'b', 'c'].joinOxford(), 'a, b, and c');
    expect(['a', 'b', 'c', 'd'].joinOxford(), 'a, b, c, and d');
    expect([1, 2, 3].joinOxford(), '1, 2, and 3');
    expect(['a', 'b'].joinOxford(coordinator: 'or'), 'a or b');
    expect(['a', 'b', 'c'].joinOxford(coordinator: 'or'), 'a, b, or c');
  });
}
