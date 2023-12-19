import 'package:flutter/material.dart';
///一个简易的状态管理工具
class ValueNotifierManager<T> {
  ValueNotifier<T> _valueNotifier;

  ValueNotifierManager(T initialValue)
      : _valueNotifier = ValueNotifier<T>(initialValue);

  T get value => _valueNotifier.value;

  set value(T newValue) => _valueNotifier.value = newValue;

  void addListener(VoidCallback listener) {
    _valueNotifier.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _valueNotifier.removeListener(listener);
  }

}

class CounterState extends ValueNotifierManager<int> {
  CounterState() : super(0);

  void increment() {
    value++;
  }
}

class MyWidget extends StatelessWidget {
  final CounterState counterState = CounterState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encapsulated ValueNotifier')),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: counterState._valueNotifier,
          builder: (context, value, child) {
            return Text('Counter: $value');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterState.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
