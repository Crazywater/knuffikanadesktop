import 'package:flutter/material.dart';
import 'package:knuffikanadesktop/src/guess.dart';
import 'package:knuffikanadesktop/src/kana.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knuffikana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'Knuffikana'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final round = createRound();
  final textEditingController = TextEditingController();
  final scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KanaString(round, scrollController),
            Input(handleInput, textEditingController)
          ],
        ),
      ),
    );
  }

  void handleInput(String input) {
    final want = kana[round.currentKana.kana];
    if (input == want) {
      setState(() {
        round.markCorrect();
        textEditingController.clear();
        scrollController.scrollTo(
          index: round.currentIndex,
          duration: const Duration(milliseconds: 500),
        );
      });
    }
  }
}

class KanaString extends StatelessWidget {
  final GuessRound round;
  final ItemScrollController scrollController;

  const KanaString(this.round, this.scrollController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ScrollablePositionedList.builder(
        itemCount: round.kana.length,
        itemBuilder: (context, i) => SingleKana(round.kana[i]),
        itemScrollController: scrollController,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class SingleKana extends StatelessWidget {
  final GuessableKana kana;

  const SingleKana(this.kana, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = kana.isDone ? Colors.green : Colors.black;
    return Text(kana.kana, style: TextStyle(fontSize: 128, color: color));
  }
}

class Input extends StatelessWidget {
  final void Function(String) handleInput;
  final TextEditingController controller;

  const Input(this.handleInput, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: handleInput,
      autofocus: true,
    );
  }
}
