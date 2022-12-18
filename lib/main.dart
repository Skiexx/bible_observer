import 'package:bible_observer/pages/chapter_content_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/bible.dart';
import 'pages/bible_books_page.dart';
import 'pages/bible_chapters_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/books': (context) => const BibleBooksPage(),
        '/chapters': (context) => const BibleChaptersPage(),
        '/content': (context) => const ChapterContentPage(),
      },
      home: const PageSelectorModule(),
    );
  }
}

class PageSelectorModule extends StatelessWidget {
  const PageSelectorModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Обозреватель библии',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        centerTitle: true,
      ),
      body: const BiblePage(),
      drawerEnableOpenDragGesture: true,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawer: const Drawer(
        child: Text('hello?'),
      ),
    );
  }
}

class BiblePage extends StatefulWidget {
  const BiblePage({Key? key}) : super(key: key);

  @override
  BiblePageState createState() => BiblePageState();
}

class BiblePageState extends State<BiblePage> {
  late Future<BibleList> bibleList;

  @override
  void initState() {
    bibleList = fetchBible();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bibleList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.bible.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.bible[index].name),
                subtitle: Text(
                    'Язык: ${snapshot.data!.bible[index].language ?? 'Не найден'}'),
                onTap: () {
                  Navigator.pushNamed(context, '/books',
                      arguments: snapshot.data!.bible[index]);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
