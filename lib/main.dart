import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Blue Block Project',
      theme: ThemeData(
        fontFamily: 'DMSans', // Use the regular weight as the default
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Item {
  Item({
    required this.header,
    required this.icon,
    required this.body,
    this.isExpanded = false,
  });

  String header;
  IconData icon;
  String body;
  bool isExpanded;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  Color _appBarColor = Colors.transparent;

  // Initialize the list once
  final List<Item> _items = [
    Item(
      header: 'Plot',
      icon: Icons.bolt,
      body:
          '"Blue Lock" follows a unique and intense training program designed to create the world best striker for the Japanese national soccer team. After Japans disappointing performance in the 2018 World Cup, the program aims to cultivate individual talent through fierce competition, pushing players to their limits',
    ),
    Item(
      header: 'Characters',
      icon: Icons.face_6,
      body:
          'The story centers around Yoichi Isagi, a high school soccer player who joins the Blue Lock facility. Alongside him are various talented players, each with distinct skills and personalities, including the ambitious and confident Rin Itoshi and the strategic genius, Meguru Bachira.',
    ),
    Item(
      header: 'Themes',
      icon: Icons.sports_soccer,
      body:
          'The anime explores themes of ambition, rivalry, and the psychological aspects of sports. It delves into the balance between teamwork and individualism, highlighting the struggles and growth of young athletes as they strive for greatness.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50) {
      setState(() {
        _appBarColor = Colors.blue;
      });
    } else {
      setState(() {
        _appBarColor = Colors.transparent;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _togglePanel(int index) {
    setState(() {
      _items[index].isExpanded = !_items[index].isExpanded;
      print(
          'Item ${_items[index].header} expanded: ${_items[index].isExpanded}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Blue Block Project'),
        backgroundColor: _appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Header Card
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Image.network(
                      'https://i.ytimg.com/vi/gzUURj6nQDc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDhQ4XW76PxOH2hIF-2koXftNHEKQ',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'ブルーロック',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'The Japan national team finished 16th in the 2018 FIFA World Cup. The Japan Football Union hires the football enigma Jinpachi Ego. His masterplan to lead Japan to stardom is Blue Lock, a training regimen designed to create the best striker',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // ExpansionPanelList for sports
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  _togglePanel(index);
                },
                children: _items.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        leading: Icon(item.icon),
                        title: Text(
                          item.header,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, right: 16.0, left: 16.0),
                      child: Text(item.body),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
                animationDuration: const Duration(milliseconds: 500),
              ),
              const SizedBox(height: 16.0),

              // Horizontal ListView for asset images
              SizedBox(
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImageCard('images/image1.png'),
                    const SizedBox(width: 8.0),
                    _buildImageCard('images/image2.png'),
                    const SizedBox(width: 8.0),
                    _buildImageCard('images/image3.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String assetPath) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        width: 200,
        height: 200,
      ),
    );
  }
}
