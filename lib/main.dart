import 'package:clm_app/fetch_kmlstring.dart';
import 'package:clm_app/file_controller.dart';
import 'package:clm_app/sample_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => FileController())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community LIfe Media App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'CLM Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

  String sampleText = "sampling with text";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 92, 101, 106),
        title: Row(
          children: [
            GestureDetector(
              onTap: () async {
                debugPrint("getting data");
                sampleText = await fetchKmlString(
                    "https://www.google.com/maps/d/edit?mid=14YYS7C7wDERShr7Ve3HK2LS3iM1gPSs&ll=-33.91960114408931%2C18.505443635606056&z=16");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  "Import Dataset",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Row(
          children: [
            Container(
              height: height,
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(sampleText),
            ),
            const Expanded(
              child: MapSample(),
            )
          ],
        ),
      ),
    );
  }
}
