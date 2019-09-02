import 'package:flutter/material.dart';

void main() => runApp(QuoteApp());

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote',
      home: StatefulHomePage(),
    );
  }
}

class Quote {
  final String text;
  final String author;
  final String imageUrl;
  Quote(this.text, this.author, this.imageUrl);
}

class StatefulHomePage extends StatefulWidget {
  @override
  _StatefulHomePageState createState() => _StatefulHomePageState();
}

class _StatefulHomePageState extends State<StatefulHomePage> {
  final _formkey = GlobalKey<FormState>();
  String _inputQuote;
  String _inputAuthor;
  String _inputImage;

  List<Quote> quotes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quote'),
                  onSaved: (String value) {
                    _inputQuote = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'author'),
                  onSaved: (String value) {
                    _inputAuthor = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'image'),
                  onSaved: (String value) {
                    _inputImage = value;
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    _formkey.currentState.save();
                    print(_inputQuote);
                    print(_inputAuthor);
                    setState(() {
                      quotes.insert(
                          0, Quote(_inputQuote, _inputAuthor, _inputImage));
                    });
                    _formkey.currentState.reset();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: quotes.length == 0
                ? Center(
                    child: Text('Empty'),
                  )
                : ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return QuoteCard(quotes[index].text, quotes[index].author,
                          quotes[index].imageUrl);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote'),
      ),
      body: ListView(
        children: <Widget>[
          QuoteCard('11111', '111111', 'https://i.imgur.com/JJO2P6U.jpg'),
          QuoteCard('222222', '2222221', 'https://i.imgur.com/383Z4Do.jpg'),
          QuoteCard('33333', '333331', 'https://i.imgur.com/GYGN5Ee.jpg'),
          QuoteCard('44444', '444441', 'https://i.imgur.com/bfZe505.jpg'),
        ],
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final String _text;
  final String _author;
  final String _imageUrl;
  const QuoteCard(
    this._text,
    this._author,
    this._imageUrl, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage('$_imageUrl'))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '"$_text"',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment(1, 0),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '"$_author"',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
