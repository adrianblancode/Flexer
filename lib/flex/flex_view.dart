import 'package:Flexer/flex/contract.dart';
import 'package:Flexer/flex/flex_presenter.dart';
import 'package:Flexer/util/time_utils.dart';
import 'package:flutter/material.dart';


class FlexView extends StatefulWidget {
  @override
  _FlexViewState createState() => new _FlexViewState();
}

class _FlexViewState extends State<FlexView> implements FlexViewContract {
  FlexPresenterContract _presenter;

  Duration _time;
  Duration _timeToday;

  _FlexViewState() {
    _presenter = new FlexPresenterImpl(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadTime();
  }

  @override
  void onTimesReceived(Duration totalTime, Duration todayTime) {
    setState(() {
      _time = totalTime;
      _timeToday = todayTime;
    });
  }

  List<Color> _getColorsFromTime() {
    const double DURATION_GRADIENT_MIN = 10.0;
    const Color baseColor = Colors.green;
    const Color secondaryColor = Colors.red;

    if (_time == null) {
      return [baseColor, baseColor];
    }
    
    double top = 1.0 + (_time.inMinutes + 10.0) / DURATION_GRADIENT_MIN;
    double bottom = 1.0 + _time.inMinutes / DURATION_GRADIENT_MIN;

    top = top.clamp(0.0, 1.0);
    bottom = bottom.clamp(0.0, 1.0);

    return [Color.lerp(secondaryColor, baseColor, top),
    Color.lerp(secondaryColor, baseColor, bottom)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: _getColorsFromTime(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  TimeUtils.formatDuration(_time),
                  style: Theme
                      .of(context)
                      .textTheme
                      .display3
                      .copyWith(fontSize: 100.0),
                ),
                new Text(
                  TimeUtils.formatDuration(_timeToday, forcePrefix: true),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(
                      color: Theme
                          .of(context)
                          .textTheme
                          .display3
                          .color),
                ),
              ],
            ),
          ),
          new Align(
            alignment: Alignment.bottomRight,
            child: new Padding(
              padding: new EdgeInsets.only(bottom: 16.0, right: 8.0),
              child: new AddRemoveFabs(_presenter.onAddTimeClicked, _presenter.onRemoveTimeClicked),
            ),
          )
        ],
      ),
    );
  }
}

class AddRemoveFabs extends StatelessWidget {

  final VoidCallback onTopClicked;
  final VoidCallback onBottomClicked;

  AddRemoveFabs(this.onTopClicked, this.onBottomClicked);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new FloatingActionButton(
          onPressed: onTopClicked,
          child: new Icon(
            Icons.add,
            color: Colors.green,
          ),
        ),
        new Padding(padding: new EdgeInsets.all(8.0)),
        new FloatingActionButton(
          onPressed: onBottomClicked,
          child: new Icon(
            Icons.remove,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}