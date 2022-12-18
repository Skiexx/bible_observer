import 'package:bible_observer/models/chapter.dart';
import 'package:flutter/material.dart';

class ChapterContentPage extends StatelessWidget {
  const ChapterContentPage({Key? key}) : super(key: key);

  static late Chapter chapter;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    chapter = settings.arguments as Chapter;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Глава ${chapter.number}',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: const ChapterContentWidget(),
    );
  }
}

class ChapterContentWidget extends StatefulWidget {
  const ChapterContentWidget({Key? key}) : super(key: key);

  @override
  ChapterContentWidgetState createState() => ChapterContentWidgetState();
}

class ChapterContentWidgetState extends State<ChapterContentWidget> {
  late Future<ChapterContent> chapter;

  @override
  void initState() {
    chapter = fetchChapterContent(
        ChapterContentPage.chapter.bibleId, ChapterContentPage.chapter.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _futureBuilder();
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder<ChapterContent>(
      future: chapter,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(snapshot.data?.content ?? 'Содержимое главы отсутствует'),
                const Divider(
                  color: Colors.transparent,
                ),
                _buttons(snapshot.data?.previous, snapshot.data?.next),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Row _buttons(String? prevChapterId, String? nextChapterId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: prevChapterId?.isEmpty ?? true
              ? null
              : () => Navigator.pushReplacementNamed(context, '/content',
                  arguments: Chapter(
                    id: prevChapterId!,
                    bookId: ChapterContentPage.chapter.bookId,
                    bibleId: ChapterContentPage.chapter.bibleId,
                    number: ChapterContentPage.chapter.number == '1'
                        ? 'intro'
                        : (int.parse(ChapterContentPage.chapter.number) - 1)
                            .toString(),
                  )),
          child: const Text('Предыдущая глава'),
        ),
        ElevatedButton(
          onPressed: nextChapterId?.isEmpty ?? true
              ? null
              : () => Navigator.pushReplacementNamed(context, '/content',
                  arguments: Chapter(
                      id: nextChapterId!,
                      bookId: ChapterContentPage.chapter.bookId,
                      bibleId: ChapterContentPage.chapter.bibleId,
                      number: ChapterContentPage.chapter.number == 'intro'
                          ? '1'
                          : (int.parse(ChapterContentPage.chapter.number) + 1)
                              .toString())),
          child: const Text('Следующая глава'),
        ),
      ],
    );
  }
}
