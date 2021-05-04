import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ), body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Man, I see in diskordlit the strongest and smartest men who've ever lived. I see all this potential, and I see it squandered. God damn it, an entire generation sleeping late, playing video games – watching 2D girls. Pop culture has us chasing fame and fortune, doing things we hate so we can get shit we don't need. We're the middle children of history, man. No purpose or place. We have no Great War. No Great Depression. Our great war is an academic war. Our great depression is our lives. We've all been raised on television to believe that one day we'd all be millionaires, and movie gods, and rock stars, but we won't. And we're slowly learning that fact. And we're very, very pissed off."
            , style: TextStyle(
              fontSize: 18
            )),
          )
        ],
      )
    ),
    );
  }
}
