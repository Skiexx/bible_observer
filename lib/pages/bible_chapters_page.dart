import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/chapter.dart';

class BibleChaptersPage extends StatelessWidget {
  const BibleChaptersPage({Key? key}) : super(key: key);

  static late Book book;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    book = settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Главы',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: Text('hello?'),
      ),
      body: const ChaptersWidget(),
    );
  }
}

class ChaptersWidget extends StatefulWidget {
  const ChaptersWidget({Key? key}) : super(key: key);

  @override
  ChaptersWidgetState createState() => ChaptersWidgetState();
}

class ChaptersWidgetState extends State<ChaptersWidget> {
  late Future<ChapterList> chapterList;

  @override
  void initState() {
    chapterList = fetchChapters(
        BibleChaptersPage.book.bibleId, BibleChaptersPage.book.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChapterList>(
      future: chapterList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.chapters.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    snapshot.data!.chapters[index].number,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/content',
                      arguments: snapshot.data!.chapters[index],
                    );
                  },
                ),
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
