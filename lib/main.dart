import 'package:flutter/material.dart';

import 'widgets/aeroplane.dart';
import 'widgets/line.dart';
import 'widgets/pagination.dart';
import 'widgets/survey_step.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Survey(),
    );
  }
}

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int stepNumber = 1;

  @override
  Widget build(BuildContext context) {
    Widget page = stepNumber == 1
        ? SurveyStep(
            key: Key('step1'),
            onOptionSelected: () => setState(() => stepNumber = 2),
            question:
                'Do you typically fly for business, personal reasons, or some other reason?',
            answers: <String>['Business', 'Personal', 'Others'],
            number: 1,
          )
        : SurveyStep(
            key: Key('step2'),
            onOptionSelected: () => setState(() => stepNumber = 1),
            question: 'How many hours is your average flight?',
            answers: <String>[
              'Less than two hours',
              'More than two but less than five hours',
              'Others'
            ],
            number: 2,
          );

    return Scaffold(
      body: Container(
        decoration: gradientDecoration,
        child: SafeArea(
          child: Stack(
            children: [
              Pagination(),
              Aeroplane(),
              Line(),
              page,
            ],
          ),
        ),
      ),
    );
  }
}

const gradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(76, 61, 243, 1),
      Color.fromRGBO(120, 58, 183, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
