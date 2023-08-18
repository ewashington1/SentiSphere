import 'package:flutter/material.dart';
import 'colors.dart';
import 'notes_provider.dart';
import 'note_details_screen.dart';
import 'package:intl/intl.dart';



class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}


Icon getEmojiIcon(int rating) {
  switch (rating) {
    case 0:
      return Icon(Icons.sentiment_very_dissatisfied);
    case 1:
      return Icon(Icons.sentiment_dissatisfied);
    case 2:
      return Icon(Icons.sentiment_neutral);
    case 3:
      return Icon(Icons.sentiment_satisfied);
    case 4:
      return Icon(Icons.sentiment_very_satisfied);
    default:
      return Icon(Icons.sentiment_neutral); // Default case, if the rating is not in the expected range
  }
}


class _NotesListScreenState extends State<NotesListScreen> {
  late Future<List<Map<String, dynamic>>> notesFuture;

  void _deleteNote(int index) async {
    await NotesProvider().deleteNote(index);
    setState(() {
      notesFuture = NotesProvider().readNotes(); // Refresh the notes list after deletion
    });
  }


  @override
  void initState() {
    super.initState();
    notesFuture = NotesProvider().readNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final notes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                final dateTime = DateTime.parse(note['date']);
                final formattedDate = DateFormat('MMM d, y, h:mm a').format(dateTime);
                final rating = note['emojiRating']; // Accessing the emojiRating value

                return Dismissible(
                  key: Key(note['content']),
                  background: Container(
                    color: AppColors.secondaryLight,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  direction: DismissDirection.endToStart, // Only allow swipe to the left
                  onDismissed: (direction) => _deleteNote(index), // Action on dismiss
                  child: ListTile(
                    title: Text(note['content']),
                    subtitle: Row(
                      children: [
                        getEmojiIcon(rating), // Calling the helper function with the rating
                        SizedBox(width: 8), // Spacing between the icon and the date
                        Text(formattedDate),
                      ],
                    ),
                      onTap: () async {
                        final updatedNote = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetailsScreen(note: note),
                          ),
                        );

                        if (updatedNote != null) {
                          // Update the notes list with the updatedNote data
                          setState(() {
                            // Update the notes list with the new data
                            final noteIndex = notes.indexWhere((n) => n['date'] == updatedNote['date']);
                            if (noteIndex != -1) {
                              notes[noteIndex] = updatedNote;
                            }
                          });
                        }
                      },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(index), // Delete action on button press
                    ),
                  ),
                );
              },
            );

          }
        },
      ),
    );
  }
}
