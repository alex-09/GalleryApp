import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final List highlList = [
  "assets/img/highl/Light's Nature.jpg",
  "assets/img/highl/A feel of Engineering.jpg",
  "assets/img/highl/Albert Einstein.jpg",
  "assets/img/highl/Dedicated Classroom.jpg",
  "assets/img/highl/Electronics.jpg",
  "assets/img/highl/Hardwork's Definition.jpg",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dei\'s Gallery',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: GalleryHomePage(),
    );
  }
}

class GalleryHomePage extends StatefulWidget {
  @override
  State<GalleryHomePage> createState() => _GalleryHomePageState();
}

class _GalleryHomePageState extends State<GalleryHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 1:
        page = FavoritesPage();
        break;
      case 0:
        page = HighlPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      String timeCurrent = DateFormat("hh:mm a").format(DateTime.now());
      String dateCurrent = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
      String timeMsg =
          "The time and date is currently $timeCurrent - $dateCurrent";

      return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.motion_photos_on,
            size: 50,
            color: Color.fromARGB(189, 9, 36, 48),
          ),
          title: AppTitle(),
          actions: <Widget>[
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.query_builder),
              tooltip: 'Date & Time',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(timeMsg)));
              },
            ),
            IconButton(
              iconSize: 40,
              icon: const Icon(Icons.perm_identity),
              tooltip: 'Get to see me',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: TextPhotosMe(),
                        backgroundColor: Color.fromARGB(255, 255, 234, 167),
                      ),
                      body: DevPics(),
                    );
                  },
                ));
              },
            ),
          ],
          backgroundColor: Color.fromARGB(255, 255, 234, 167),
        ),
        body: Row(
          children: [
            SafeArea(
              right: true,
              child: NavigationRail(
                extended: constraints.maxWidth >= 800,
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                selectedLabelTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1)),
                destinations: [
                  NavigationRailDestination(
                    selectedIcon: Icon(Icons.psychology_alt),
                    icon: Icon(Icons.psychology_alt_outlined),
                    label: Text('Highlights'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite_outline),
                    selectedIcon: Icon(Icons.favorite),
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
            const VerticalDivider(thickness: 1, width: 1),
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
        "Dei's Gallery",
        style: TextStyle(
          letterSpacing: 5,
          fontFamily: 'Popp',
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Color.fromARGB(255, 0, 0, 0)!,
        ),
      ),
      Text(
        "Dei's Gallery",
        style: TextStyle(
          letterSpacing: 5,
          fontFamily: 'Popp',
          fontSize: 30,
          color: Colors.grey[300],
        ),
      ),
    ]);
  }
}

class TextPhotosMe extends StatelessWidget {
  const TextPhotosMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Text(
        "Photos of Me",
        style: TextStyle(
          letterSpacing: 5,
          fontFamily: 'Popp',
          fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Color.fromARGB(255, 0, 0, 0)!,
        ),
      ),
      Text(
        "Photos of Me",
        style: TextStyle(
          letterSpacing: 5,
          fontFamily: 'Popp',
          fontSize: 30,
          color: Colors.grey[300],
        ),
      ),
    ]);
  }
}

final List<Widget> imageSliders = highlList
    .map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: Stack(
          children: <Widget>[
            Image.asset(
              item,
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Text(
              item.toString().substring(17, item.toString().length - 4),
              style: TextStyle(
                backgroundColor: Color.fromARGB(143, 9, 132, 227),
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        )))
    .toList();

class HighlPage extends StatelessWidget {
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

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List favList = [
      Image.asset('assets/img/fav/10.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/1.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/2.jpg',
          fit: BoxFit.cover, alignment: Alignment.topCenter),
      Image.asset('assets/img/fav/3.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/4.jpg',
          fit: BoxFit.cover, alignment: Alignment.topCenter),
      Image.asset('assets/img/fav/5.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/6.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/7.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/8.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/9.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/11.jpg',
          fit: BoxFit.cover, alignment: Alignment.topCenter),
      Image.asset('assets/img/fav/12.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/13.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/14.jpg', fit: BoxFit.cover),
      Image.asset('assets/img/fav/15.jpg', fit: BoxFit.cover),
    ];

    return ListView(children: [
      for (var pair in favList)
        Container(
          height: 500,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: pair,
        ),
    ]);
  }
}

class DevPics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List meList = [
      Image.asset('assets/img/me/m1.jpg'),
      Image.asset('assets/img/me/m2.jpg'),
      Image.asset('assets/img/me/m3.jpg'),
      Image.asset('assets/img/me/m4.jpg'),
      Image.asset('assets/img/me/m5.jpg'),
      Image.asset('assets/img/me/m6.jpg'),
    ];
    meList.shuffle();

    return GridView.count(
        childAspectRatio: 1,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        children: [
          for (var contentImg in meList)
            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              padding: const EdgeInsets.all(8),
              color: Color.fromARGB(124, 162, 155, 254),
              child: contentImg,
            ),
        ]);
  }
}
