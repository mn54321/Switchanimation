import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    const SwitchAnimation(),
  );
}

class SwitchAnimation extends StatefulWidget {
  const SwitchAnimation({super.key});

  @override
  State<StatefulWidget> createState() {
    return SwitchAnimationState();
  }
}

class SwitchAnimationState extends State<SwitchAnimation>
    with SingleTickerProviderStateMixin {
  bool switchvalue = true;
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.addListener(() {
      setState(() {});
    });

    /* if (switchvalue) {
      animationController.value = 1.0;
    } else {
      animationController.value = 0.0;
    }*/
    super.initState();
  }

  void toggleSwitch(bool value) {
    setState(() {
      switchvalue = value;
      if (value) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return MaterialApp(
            theme: ThemeData.lerp(
                ThemeData.light(), ThemeData.dark(), animation.value),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(
              newswitchvalue: switchvalue,
              themechange: toggleSwitch,
            ));
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool newswitchvalue;
  final ValueChanged<bool> themechange;
  const HomeScreen(
      {super.key, required this.newswitchvalue, required this.themechange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: newswitchvalue ? Colors.white : Colors.black26,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Image(
                  image: newswitchvalue
                      ? const AssetImage('images/sun.gif')
                      : const AssetImage('images/moonnew.gif')),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                newswitchvalue ? '   Good\nMorning' : 'Good\nNight',
                style: TextStyle(
                    fontFamily: 'Schy',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: newswitchvalue
                        ? Colors.grey
                        : const Color.fromARGB(255, 201, 199, 199)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.scale(
              scale: 1.4,
              child: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.white,
                  trackOutlineColor: const WidgetStatePropertyAll(Colors.grey),
                  activeThumbImage: const AssetImage('images/sunicon.png'),
                  inactiveThumbImage: const AssetImage('images/moonicon.png'),
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.black,
                  value: newswitchvalue,
                  onChanged: themechange),
            ),
          ],
        ),
      ),
    );
  }
}

/*final _lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
      color: Colors.black,
    )));

final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(displayLarge: TextStyle(color: Colors.white)));*/
