import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

//Widget
class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

//Widget's state
class _RandomWordsState extends State<RandomWords> {
  final _wordSuggestions = <WordPair>[]; //array
  final _savedWords = <WordPair>{}; //set

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _savedWords.map(
            (pair) {
              return _buildRow(pair);
            },
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildList() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator '),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body: ListView.builder(
        // padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return const Divider();

          final index =
              i ~/ 2; // i ~/ 2 divides i by 2 and returns an integer result
          if (index >= _wordSuggestions.length) {
            _wordSuggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_wordSuggestions[index]);
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWords.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWords.remove(pair);
          } else {
            _savedWords.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
