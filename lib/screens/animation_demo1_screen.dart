import 'package:flutter/material.dart';

class AnimationDemo1Screen extends StatefulWidget {
  @override
  _AnimationDemo1ScreenState createState() => _AnimationDemo1ScreenState();
}

class _AnimationDemo1ScreenState extends State<AnimationDemo1Screen> with SingleTickerProviderStateMixin {
	AnimationController _animationController;

@override
	void initState(){
	  super.initState();
	  _animationController = new AnimationController(
		duration: const Duration(milliseconds: 1000), 
		vsync: this,
	  );
	  _animationController.addListener((){
		  setState((){});
	  });
	  _animationController.forward();
	}

 @override
	void dispose(){
	  _animationController.dispose();
	  super.dispose();
	}

	@override
	Widget build(BuildContext context){
		final int percent = (_animationController.value * 100.0).round();
		return new Scaffold(
			body: new Container(
				child: new Center(
					child: new Text('$percent%'),
				),
			),
		);
	}
}