import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScoreModel extends Model {
  int _score = 0;

  int get score => _score;

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void decrementScore() {
    _score--;
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
      builder: (context, child, model) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$teamName:'),
              Text(
                model.score.toString(),
                style: Theme.of(context).textTheme.display1,
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: model.incrementScore),
                  IconButton(
                      icon: Icon(Icons.minimize),
                      onPressed: model.decrementScore),
                ],
              )
            ],
          ),
    );
  }
}
