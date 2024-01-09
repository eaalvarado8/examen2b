import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:examen2b/db/notes_database.dart';
import 'package:examen2b/model/note.dart';
import 'package:examen2b/screens/edit_note_screen.dart';
import 'package:examen2b/screens/note_detail_screen.dart';
import 'package:examen2b/widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  int _currentIndex = 0;

  void changeNavIndex(int num) {
    setState(() {
      _currentIndex = num;
    });
    print("dsadasdasdas");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ListNotesScreen(funcionCallback: changeNavIndex),
      AddEditNotePage(funcionCallback: changeNavIndex),
      Container(
        child: Text("dadasdasdas43434"),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notas',
          style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            print(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Listar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Agregar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'editar',
            ),
          ]),
      body: screens[_currentIndex],
      //   floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.black,
      //     child: Icon(Icons.add),
      //     onPressed: () async {
      //       await Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => AddEditNotePage()),
      //       );

      //       refreshNotes();
      //     },
      //   ),
    );
  }

  Widget buildNotes() {
    void changeNavIndex(int num) {
      setState(() {
        _currentIndex = num;
      });
      print("dsadasdasdas");
    }

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(
                noteId: note.id!,
                funcionCallback: changeNavIndex,
              ),
            ));

            refreshNotes();
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.description),
              trailing: GestureDetector(
                onTap: () {
                  () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetailPage(
                          noteId: note.id!, funcionCallback: changeNavIndex),
                    ));
                    refreshNotes();
                  };
                  // Acción al presionar el botón de la derecha
                  // Puedes agregar una navegación o una función para editar la nota
                },
                child: Icon(
                  Icons.edit, // Cambia esto por el icono que desees
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListNotesScreen extends StatefulWidget {
  final Function(int) funcionCallback;
  const ListNotesScreen({Key? key, required this.funcionCallback})
      : super(key: key);

  @override
  State<ListNotesScreen> createState() => _ListNotesScreenState();
}

class _ListNotesScreenState extends State<ListNotesScreen> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
                ? Text(
                    'No hay Notas',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildNotes(widget.funcionCallback),
      ),
    );
  }

  Widget buildNotes(
    Function(int) callback,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  NoteDetailPage(noteId: note.id!, funcionCallback: callback),
            ));

            refreshNotes();
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.description),
              trailing: GestureDetector(
                onTap: () {
                  () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetailPage(
                          noteId: note.id!, funcionCallback: callback),
                    ));
                    refreshNotes();
                  };
                  // Acción al presionar el botón de la derecha
                  // Puedes agregar una navegación o una función para editar la nota
                },
                child: Icon(
                  Icons.edit, // Cambia esto por el icono que desees
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class EditPAgeNote extends StatefulWidget {
  const EditPAgeNote({Key? key}) : super(key: key);

  @override
  State<EditPAgeNote> createState() => _EditPAgeNoteState();
}

class _EditPAgeNoteState extends State<EditPAgeNote> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
