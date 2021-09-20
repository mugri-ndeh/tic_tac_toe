import 'package:backend/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => TicTacGame(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic tac toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TicTacGame>(context, listen: false);
    provider.init();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicTacGame>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Consumer<TicTacGame>(
                    builder: (_, provider, __) => GestureDetector(
                      onTap: () {
                        provider.updateTile(index, context);
                        //print(provider.currentPlayer);
                      },
                      onTapCancel: () {},
                      child: Container(
                        color: Colors.blueAccent,
                        child: Center(
                            child: Text(
                          provider.tiles[index],
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  onPressed: () {
                    provider.reset();
                  },
                  child: Text('Reset')),
            ])
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
