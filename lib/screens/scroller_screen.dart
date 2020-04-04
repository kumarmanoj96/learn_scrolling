import 'package:flutter/material.dart';
import 'dart:async';

class ScrollerScreen extends StatefulWidget {
  @override
  _ScrollerScreenState createState() => _ScrollerScreenState();
}

class _ScrollerScreenState extends State<ScrollerScreen> {
  String message = "";
  bool _isDone = false;
  bool scroll = false;
  int speedFactor = 500;
  final ScrollController _scrollController = ScrollController();
  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      message = "Scroll Start";
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    setState(() {
      message = "Scroll Update";
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      message = "Scroll End";
    });
  }

  _scrollListener() {
    print("max scroll extent:");
    print(_scrollController.position.maxScrollExtent);
    print("\nis out of range:");
    print(_scrollController.position.outOfRange);
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        _isDone = true;
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  @override
  void initState() {
    print('inside initState');
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scroll(int speedFactor) {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;
    print("_scrollController.position.maxScrollExtent:");
    print(_scrollController.position.maxScrollExtent);
    print("_scrollController. offset:");
    print(_scrollController.offset);
    _scrollController
        .animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(
                seconds:
                    durationDouble.toInt() != 0 ? durationDouble.toInt() : 1),
            curve: Curves.linear)
        .then((onValue) {
      print("animation completed:\n");
      // print(onValue);
    });
  }

  _toggleScrolling(int speedFactor) {
    setState(() {
      scroll = !scroll;
    });

    if (scroll) {
      _scroll(speedFactor);
    } else {
      // print("offset:");
      // print(_scrollController.offset);
      _scrollController.animateTo(_scrollController.offset,
          duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }

  Widget _getFloatingActionButton() {
    if (_isDone) {
      return Container();
    }
    return FloatingActionButton(
        child: Icon(
          scroll ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          if (_isDone == false) {
            _toggleScrolling(speedFactor);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    String val =
        "sahasdkksadhWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordWhat kinds of acts brought about the wordjkshsadddsasdasadasdsadasdsadssadasdadsdsaasdasdasdadsjksadkkjsakmanoj";
    return Scaffold(
      appBar: AppBar(
        title: Text("learn scrolling"),
      ),
      body: _isDone
          ? Container(
              child: Center(
                child: Text('you are done'),
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  color: Colors.green,
                  child: Center(
                    child: Text(message),
                  ),
                ),
                NotificationListener(
                  onNotification: (notif) {
                    if (notif is ScrollEndNotification && scroll) {
                      Timer(Duration(seconds: 1), () {
                        _scroll(speedFactor);
                      });
                    }
                    return true;
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 500,
                      width: 300,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.grey,width: 5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        
                        controller: _scrollController,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Text(index == 0 ? val : '',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white
                              ));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }
}
