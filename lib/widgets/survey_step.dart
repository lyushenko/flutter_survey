import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemFader extends StatefulWidget {
  final Widget child;

  const ItemFader({Key key, @required this.child}) : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  int position = 1;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 64 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
    );
  }
}

class StepNumber extends StatelessWidget {
  final int number;

  const StepNumber({Key key, @required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 110, right: 16),
      child: Text(
        number.toString().padLeft(2, '0'),
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}

class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 110, right: 8, top: 32),
      child: Text(
        question,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String name;
  final VoidCallback onTap;

  const OptionItem({
    Key key,
    @required this.name,
    @required this.onTap,
  }) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(68, 16, 8, 16),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurveyStep extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const SurveyStep({
    Key key,
    @required this.number,
    @required this.question,
    @required this.answers,
    @required this.onOptionSelected,
  }) : super(key: key);

  @override
  _SurveyStepState createState() => _SurveyStepState();
}

class _SurveyStepState extends State<SurveyStep> {
  List<GlobalKey<_ItemFaderState>> keys;
  int selectedOptionKeyIndex;

  @override
  void initState() {
    super.initState();
    keys = List.generate(5, (_) => GlobalKey<_ItemFaderState>());
    onInit();
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
  }

  void onTap(int keyIndex) async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
      if (keys.indexOf(key) == keyIndex) {
        setState(() => selectedOptionKeyIndex = keyIndex);
      }
    }
    await Future.delayed(Duration(milliseconds: 400));
    widget.onOptionSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 32),
        ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
        ItemFader(key: keys[1], child: StepQuestion(question: widget.question)),
        Spacer(),
        ...widget.answers.map((String answer) {
          int i = widget.answers.indexOf(answer) + 2;
          return ItemFader(
            key: keys[i],
            child: OptionItem(
              name: answer,
              onTap: () => onTap(i),
            ),
          );
        }),
        SizedBox(height: 64),
      ],
    );
  }
}
