import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScoreModel extends Model {
  int _score = 0;

  int get score => _score;

  void increment3Score() {
    _score += 3;
    notifyListeners();
  }

  void increment2Score() {
    _score += 2;
    notifyListeners();
  }

  void decrement3Score() {
    _score -= 3;
    notifyListeners();
  }

  void decrement2Score() {
    _score -= 2;
    notifyListeners();
  }

  void reset() {
    _score = 0;
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Board',
      theme: ThemeData.dark(),
      home: ScopedModel<ScoreModel>(
        model: ScoreModel(),
        child: ScoreCard(),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final ScoreModel teamAScoreModel = ScoreModel();
  final ScoreModel teamBScoreModel = ScoreModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Score Board',
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScopedModel<ScoreModel>(
              model: teamAScoreModel,
              child: Counter(
                teamName: "Team A",
              ),
            ),
            Container(
              width: 2.0,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(color: Colors.white),
            ),
            ScopedModel<ScoreModel>(
              model: teamBScoreModel,
              child: Counter(
                teamName: 'Team B',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String teamName;

  Counter({Key key, this.teamName});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScoreModel>(
      builder: (context, child, model) => Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$teamName:',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  model.score.toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: model.increment3Score,
                      child: Text('+ 3 POINTS'),
                      color: Colors.lightBlueAccent,
                      splashColor: Colors.green,
                    ),
                    FlatButton(
                      onPressed: model.increment2Score,
                      child: Text('+ 2 POINTS'),
                      color: Colors.deepOrangeAccent,
                      splashColor: Colors.redAccent,
                    ),
                  ],
                )
              ],
            ),
          ),
    );
  }
}
