import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import 'edit_book_page.dart';
import 'book_detail_page.dart';
import '../widget/book_card_widget.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<Note> books;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBooks();
  }

  @override
  void dispose() {
    BooksDatabase.instance.close();

    super.dispose();
  }

  Future refreshBooks() async {
    setState(() => isLoading = true);

    books = await BooksDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book List',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : books.isEmpty
                  ? const Text(
                      'No Books',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : buildBooks(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshBooks();
          },
        ),
      );
  Widget buildBooks() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        books.length,
        (index) {
          final note = books[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ));

                refreshBooks();
              },
              child: NoteCardWidget(note: note, index: index),
            ),
          );
        },
      ));
}
