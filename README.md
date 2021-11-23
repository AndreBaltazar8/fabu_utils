# FABU Utils

Extensions and other utilities for Dart and Flutter projects.

[![pub package](https://img.shields.io/pub/v/fabu_utils.svg)](https://pub.dev/packages/fabu_utils)

## Examples

### Extensions

```dart
void main() {
  ' '.isNullOrWhitespace;
  // output: true
  
  ['Item 1', 'Item 2', 'Item 3'].joinOxford();
  // output: 'Item 1, Item 2, and Item 3'
  
  [1, 2, 3].interlaceWith([4, 5, 6]);
  // output: [1, 4, 2, 5, 3, 6]
  
  [1, 2, 3].separatedBy((i) => 0);
  // output: [1, 0, 2, 0, 3]
  
  [
    Container(color: Colors.green),
    Container(color: Colors.red),
    Container(color: Colors.blue),
  ].separatedBy((i) => Container(color: Colors.yellow));
  // output: 
  // [
  //   Container(color: Colors.green),
  //   Container(color: Colors.yellow),
  //   Container(color: Colors.red),
  //   Container(color: Colors.yellow),
  //   Container(color: Colors.blue),
  // ]
}
```

### IoC container

#### Singleton

```dart
void main() {
  // Register class type
  Ioc().registerSingle(() => TestClass());
  // Get singleton instance
  Ioc().get<TestClass>().test();
  // prints: test called
}

class TestClass {
  void test() {
    print('test called');
  }
}
```

#### Factory

```dart
void main() {
  int i = 0;
  // Register class type
  Ioc().register(() => TestClass(i++));
  // Get instance of TestClass
  Ioc().get<TestClass>().test();
  // prints: test called 0
  // Get instance of TestClass (creates new instance)
  Ioc().get<TestClass>().test();
  // prints: test called 1
  
  // or a simplified version using only int as type, creating a counter
  int count = 0;
  Ioc().register(() => count++);
  Ioc().get<int>(); // returns 0
  Ioc().get<int>(); // returns 1
}

class TestClass {
  TestClass(this.i);

  final int i;
  
  void test() {
    print('test called $i');
  }
}
```