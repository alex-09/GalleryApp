import 'package:english_words/english_words.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List imgListN = [
  "assets/img/0.png",
  "assets/img/1.png",
  "assets/img/2.png",
  "assets/img/3.png",
  "assets/img/4.png",
  "assets/img/5.png",
  "assets/img/6.png",
  "assets/img/7.png",
  "assets/img/8.png",
  "assets/img/9.png",
  "assets/img/10.png",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BtnClick(),
      child: MaterialApp(
        title: 'Andrei\'s Gallery',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 128, 239, 156)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class BtnClick extends ChangeNotifier {
  var current = WordPair.random();
  var num = 9;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  void addFav() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
      print(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 1:
        page = FavoritesPageN();
        break;
      case 0:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.motion_photos_on,
            size: 100,
            color: Color.fromARGB(190, 43, 188, 255),
          ),
          title: AppTitle(),
          backgroundColor: Color.fromARGB(126, 221, 211, 165),
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                destinations: [
                  NavigationRailDestination(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    icon: Icon(Icons.home),
                    label: Text('Highlights'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('My Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Text(
        "Andrei's Gallery",
        style: TextStyle(
          letterSpacing: 10,
          fontFamily: 'Popp',
          fontSize: 40,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Color.fromARGB(255, 0, 0, 0)!,
        ),
      ),
      Text(
        "Andrei's Gallery",
        style: TextStyle(
          letterSpacing: 10,
          fontFamily: 'Popp',
          fontSize: 40,
          color: Colors.grey[300],
        ),
      ),
    ]);
  }
}

final List<Widget> imageSliders = imgListN
    .map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: Stack(
          children: <Widget>[
            Image.network(
              item,
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Text("HERER"),
          ],
        )))
    .toList();

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 1,
            height: height,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(
                days: 0,
                hours: 0,
                minutes: 0,
                seconds: 2,
                milliseconds: 0,
                microseconds: 0)),
        items: imageSliders,
      ),
    );
  }
}

class FavoritesPageN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BtnClick>();

    List imgList = [
      Image.asset('assets/img/0.png'),
      Image.asset('assets/img/1.png'),
      Image.asset('assets/img/2.png'),
      Image.asset('assets/img/3.png'),
      Image.asset('assets/img/4.png'),
      Image.asset('assets/img/5.png'),
      Image.asset('assets/img/6.png'),
      Image.asset('assets/img/7.png'),
      Image.asset('assets/img/8.png'),
      Image.asset('assets/img/9.png'),
      Image.asset('assets/img/10.png'),
    ];

    return ListView(children: [
      for (var pair in imgList)
        Container(
          height: 200,
          margin: EdgeInsets.only(top: 20),
          child: pair,
        ),
    ]);
    // return Center(
    //   child: GridView.count(
    //       childAspectRatio: 1,
    //       mainAxisSpacing: 5,
    //       crossAxisSpacing: 5,
    //       crossAxisCount: 4,
    //       children: [
    //         for (var contentImg in imgList)
    //           Container(
    //             padding: const EdgeInsets.all(8),
    //             color: Colors.teal[100],
    //             child: contentImg,
    //           ),
    //       ]),
    // );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BtnClick>();
    var randomName = "a random word";
    var wordPair = appState.current;

    IconData icon;
    if (appState.favorites.contains(wordPair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(randomName),
            MainContent(wordPair: wordPair),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.addFav();
                  },
                  icon: Icon(icon),
                  label: Text("Like"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
    required this.wordPair,
  });

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.primary);

    return Card(
      color: Color.fromARGB(230, 149, 156, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          wordPair.asCamelCase,
          selectionColor: Color.fromRGBO(100, 100, 100, 0.5),
          // style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          style: style,
        ),
      ),
    );
  }
}
