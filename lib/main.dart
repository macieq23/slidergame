import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

var firstRandom = 1;
var secondRandom = 1;
void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        body: MyA(),
      ),
    ),
  );
}

class MyA extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State {
  @override
  Widget build(BuildContext context) {
    //Random random = new Random();
    //Random random2 = new Random();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Slider Game'),
          backgroundColor: Colors.black26,
        ),
        body: Column(
          children: [
            Center(
              child: Transform.rotate(
                angle: pi,
                child: Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('images/roter.png'),
                ),
              ),
            ),
            /*CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/roter.png'),
              backgroundColor: Colors.deepOrangeAccent,
            ),*/
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Game()));
              },
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                color: Colors.deepPurpleAccent,
                //alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            /*SizedBox(
              height: 20,
              child: Divider(
                thickness: 3,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          firstRandom = Random().nextInt(6) + 1;
                          secondRandom = Random().nextInt(6) + 1;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        primary: Colors.black,
                      ),
                      child: Expanded(
                        child: Center(
                          child: Text(
                            '$firstRandom',
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          firstRandom = Random().nextInt(6) + 1;
                          secondRandom = Random().nextInt(6) + 1;
                        });
                      },
                      child: Expanded(
                        child: Center(
                          child: Text(
                            '$secondRandom',
                            style: TextStyle(
                              fontSize: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);


  @override
  _Game createState() => _Game();
}

class _Game extends State<Game> with SingleTickerProviderStateMixin {
  bool bDirection = true;
  bool bCallOnlyOnce = true;
  double moveY = 1.25;
  int count = 3;
  double position = 0;
  double moveSlider = 0;
  double? sliderSize = 0;
  int level = 1;
  double sliderWidth = 130;
  String sFinish = '';
  bool stopGame = false;
  late Offset offset;
  final keyImage = GlobalKey();
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    sliderMoving();
    super.initState();
  }

  void calculatePosition(){

  }

  void moving() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      setState(() {

        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final RenderBox box = keyImage.currentContext!.findRenderObject()! as RenderBox;
          offset = box.localToGlobal(Offset.zero);
          //print(offset.dx);
        });
        //czytanie pozycji X obrazka powyzej

        double checkScreenWidth = MediaQuery.of(context).size.width;
        //czytanie szerokosci ekranu

        sliderSize = keyImage.currentContext?.size?.width;
        //czytanie szerokosci slidera
        if (!stopGame){
          moveY -= 0.01;
        }
        position -= 10;
        if (moveY < -1.05) {
          if (offset.dx < (checkScreenWidth / 2) &&
              (offset.dx + sliderSize!) > (checkScreenWidth / 2)) {
            //if (bCallOnlyOnce){
            sliderWidth = sliderWidth - 10;
            level++;
            //print("slider: $sliderWidth");
            //bCallOnlyOnce = false;
            //}
            if (sliderWidth < 31){
              sFinish = ' Game is Finished!';
              stopGame = true;
            }
          }else{
            level = 1;
            sliderWidth = 130;
          }
          //if (moveY < -1.05) {
            moveY = 1.25;
            count--;
            //if (count < 1) {
            timer.cancel();
            //}
          //}
        }
      });
    });
  }

  void sliderMoving(){
    Timer.periodic(Duration(milliseconds: 35), (timer) {
      setState(() {
        if (!stopGame) {
          if (moveSlider <= 1 && bDirection) {
            moveSlider += 0.03;
            if (moveSlider >= 1) {
              bDirection = false;
            }
          } else if (moveSlider >= -1 && !bDirection) {
            moveSlider -= 0.03;
            if (moveSlider < -1) {
              bDirection = true;
            }
          };
        };
      });
    });
  }

  void calculateSize() {
    //checkSliderPosition = keyImage.currentContext?.size?.width;
    //print(keyImage.currentContext?.size?.width);
  }

  void checkPrint(){
    //double checkWidth = MediaQuery.of(context).size.width;
    //print(checkWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: moving,
          //onDoubleTap: calculateSize,
          onDoubleTap: calculatePosition,
          child: Column(
              children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //alignment: Alignment.center,
              alignment: Alignment(moveSlider,0),
              child: Image(
                key: keyImage,
                alignment: Alignment.bottomCenter,
                height: 50,
                width: sliderWidth,
                color: Colors.deepPurple,
                image: AssetImage('images/slider.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: 15,
                height: 30,
                child: Image(
                  alignment: Alignment(-0, moveY),
                  image: AssetImage('images/bullet.png'),
                ),
              ),
            ),
            Image(
              fit: BoxFit.fitWidth,
              height: 110,
              image: AssetImage('images/roter.png'),
            ),
          Text(
            'Level: $level'+ sFinish,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20),
          )
          ]),
        ),
      ),
    );
  }
}
