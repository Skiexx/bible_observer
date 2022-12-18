import 'package:flutter/material.dart';

import '../models/bible.dart';
import '../models/book.dart';

class BibleBooksPage extends StatelessWidget {
  const BibleBooksPage({Key? key}) : super(key: key);

  static late Bible bible;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    bible = settings.arguments as Bible;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Книги',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: Text('hello?'),
      ),
      body: const BooksWidget(),
    );
  }
}

class BooksWidget extends StatefulWidget {
  const BooksWidget({Key? key}) : super(key: key);

  @override
  BooksWidgetState createState() => BooksWidgetState();
}

class BooksWidgetState extends State<BooksWidget> {
  late Future<BookList> bookList;

  @override
  void initState() {
    bookList = fetchBooks(BibleBooksPage.bible.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookList>(
      future: bookList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.books.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Название: ${snapshot.data!.books[index].name}'),
                onTap: () {
                  Navigator.pushNamed(context, '/chapters',
                      arguments: snapshot.data!.books[index]);
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
