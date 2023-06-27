import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter1 = 0;
  int _counter2 = 0;

  void _incrementCounter1() {
    setState(() {
      _counter1++;
    });
  }

  void _incrementCounter2() {
    setState(() {
      _counter2++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _incrementCounter1,
              child: const Text('Touch me 1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _incrementCounter2,
              child: const Text('Touch me 2'),
            ),
            const SizedBox(height: 16),
            MyInherited(
              count1: _counter1,
              count2: _counter2,
              child: const WidgetStateless(),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetStateless extends StatelessWidget {
  const WidgetStateless({super.key});

  @override
  Widget build(BuildContext context) {
    final count = MyInherited.of(context, 'one')?.count1 ?? 0;

    return Column(
      children: [
        Text('$count', style: const TextStyle(fontSize: 24)),
        const WidgetStateful(),
        const WidgetStateful(),
        const WidgetStateful(),
      ],
    );
  }
}

class WidgetStateful extends StatefulWidget {
  const WidgetStateful({super.key});

  @override
  State<WidgetStateful> createState() => _WidgetStatefulState();
}

class _WidgetStatefulState extends State<WidgetStateful> {
  @override
  Widget build(BuildContext context) {
    final count = MyInherited.of(context, 'two')?.count2 ?? 0;

    return Text('$count', style: const TextStyle(fontSize: 24));
  }
}

class MyInherited extends InheritedModel<String> {
  final int count1;
  final int count2;

  const MyInherited({
    super.key,
    required this.count1,
    required this.count2,
    required super.child,
  });

  static MyInherited? of(BuildContext context, Object? aspect) =>
      context.dependOnInheritedWidgetOfExactType<MyInherited>();

  @override
  bool updateShouldNotify(MyInherited oldWidget) =>
      oldWidget.count1 != count1 || oldWidget.count2 != count2;

  @override
  bool updateShouldNotifyDependent(
      covariant MyInherited oldWidget, Set<String> dependencies) {
    final isCount1Updated =
        (oldWidget.count1 != count1) && dependencies.contains('one');
    final isCount2Updated =
        oldWidget.count2 != count2 && dependencies.contains('two');

    return isCount1Updated || isCount2Updated;
  }
}

// class DataProviderInherited extends InheritedModel<String> {
//   final int valueOne;
//   final int valueTwo;
//
//   const DataProviderInherited({
//     super.key,
//     required super.child,
//     required this.valueOne,
//     required this.valueTwo,
//   });
//
//   @override
//   bool updateShouldNotify(covariant DataProviderInherited oldWidget) {
//     return oldWidget.valueOne != valueOne || oldWidget.valueTwo != valueTwo;
//   }
//
//   @override
//   bool updateShouldNotifyDependent(
//       covariant DataProviderInherited oldWidget, Set<String> dependencies) {
//     final isValueOneChanged =
//         (oldWidget.valueOne != valueOne) && dependencies.contains('one');
//     final isValueTwoChanged =
//         (oldWidget.valueTwo != valueTwo) && dependencies.contains('two');
//
//     return isValueOneChanged || isValueTwoChanged;
//   }
// }

// class MyInherited extends InheritedWidget {
//   final int count;
//
//   const MyInherited({
//     super.key,
//     required super.child,
//     required this.count,
//   });
//
//   @override
//   bool updateShouldNotify(MyInherited oldWidget) => oldWidget.count != count;
// }
