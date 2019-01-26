import 'package:flutter/material.dart';
import 'package:team_score_counter/Model/score_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:team_score_counter/counter.dart';

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


