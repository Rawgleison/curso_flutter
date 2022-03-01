import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home contador'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  bool get isFull {
    return _counter >= 20;
  }

  bool get isEmpty => _counter <= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/peoples.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isFull ? "Lotado!!!" : "Pode Entrar",
              style: TextStyle(
                  color: isFull ? Colors.red : Colors.white, fontSize: 60),
            ),
            Text(
              '$_counter',
              style: TextStyle(
                  color: isFull ? Colors.red : Colors.white, fontSize: 120),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: isEmpty ? null : _decrementCounter,
                  child: const Text("Saiu"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(150, 150),
                    primary: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 30,
                // ),
                TextButton(
                    onPressed: isFull ? null : _incrementCounter,
                    child: const Text("Entrou"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(150, 150),
                      primary: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
