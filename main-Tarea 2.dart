import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kItemExtent = 32.0;
const List<String> _fruitNames = <String>[
  'Apple',
  'Mango',
  'Banana',
  'Orange',
  'Pineapple',
  'Strawberry',
];

void main() => runApp(const PickerApp());

class PickerApp extends StatelessWidget {
  const PickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const PickerExample(),
    );
  }
}

class PickerExample extends StatefulWidget {
  const PickerExample({super.key});

  @override
  State<PickerExample> createState() => _PickerExampleState();
}

class _PickerExampleState extends State<PickerExample> {
  int _selectedFruit = 0;

  void _showCupertinoPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: _kItemExtent,
            scrollController: FixedExtentScrollController(
              initialItem: _selectedFruit,
            ),
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                _selectedFruit = selectedItem;
              });
            },
            children: List<Widget>.generate(_fruitNames.length, (int index) {
              return Center(child: Text(_fruitNames[index]));
            }),
          ),
        ),
      ),
    );
  }

  void _showMaterialPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        color: Theme.of(context).dialogBackgroundColor,
        child: ListWheelScrollView.useDelegate(
          itemExtent: _kItemExtent,
          controller: FixedExtentScrollController(
            initialItem: _selectedFruit,
          ),
          onSelectedItemChanged: (int selectedItem) {
            setState(() {
              _selectedFruit = selectedItem;
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (BuildContext context, int index) {
              if (index < 0 || index >= _fruitNames.length) {
                return null;
              }
              return Center(
                child: Text(_fruitNames[index]),
              );
            },
            childCount: _fruitNames.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picker Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Selected fruit:'),
            Text(
              _fruitNames[_selectedFruit],
              style: const TextStyle(
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showCupertinoPicker(context),
              child: const Text('Show Cupertino Picker'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showMaterialPicker(context),
              child: const Text('Show Material Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
