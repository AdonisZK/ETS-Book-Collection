# book_collection

- Nama  : Sony Hermawan
- NRP   : 5025211226
- Kelas : H

## Install Dependencies
```flutter pub get```

## CRUD
### Create
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/7d6f8e19-2e8c-49cd-945b-6f757a406aab)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/45a37324-6646-497b-8ec7-cc9791bde83a)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/da1a56ca-7c6b-4e2f-b0b1-8a2627a42c24)

### Read
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/eb38cada-d54b-4f78-8b8f-cf74487c5fc0)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/452bf088-a454-4788-ba1e-0a269e2721a5)

### Update
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/bdbf16ec-692e-44a7-b373-fe0eb6745fae)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/815f072b-53ba-43a8-882b-ab17216ddb8c)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/2b026f92-0a89-4b4f-b758-37fe53871fe6)

### Delete
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/6440440b-fea1-418e-a904-71069623c372)
![image](https://github.com/AdonisZK/ETS-Book-Collection/assets/48209612/12343e12-abd4-49ba-89de-e6196019bfda)


## Points example
- Classes
```dart
class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}
```
- images
```dart
  Widget buildAttachButton() {
    return IconButton(
      icon: Icon(Icons.attach_file),
      onPressed: () async {
        if (isImagePickerActive) return;

        isImagePickerActive = true;
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          setState(() {
            imagePath = pickedFile.path;
          });
        }
        isImagePickerActive = false;
      },
    );
  }
```
- error handling
```dart
    try {
      books = await BooksDatabase.instance.readAllNotes();
    } catch (e) {
      print('An error occurred while reading from the database: $e');
    } finally {
      setState(() => isLoading = false);
    }
```
- stateless and stateful <br>
stateless
`class ImageDisplayWidget extends StatelessWidget`
stateful
`class BooksPage extends StatefulWidget`
- CRUD Sqflite
create
```dart
  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableBooks, note.toJson());
    return note.copy(id: id, imagePath: note.imagePath);
  }
```
read
```dart
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableBooks, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }
```
update
```dart
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableBooks,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }
```
delete
```dart
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBooks,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }
```
- use at least 5 different widgets <br>
`AppBar`, `Text`, `FloatingActionButton`, `Icon`, `Column`
