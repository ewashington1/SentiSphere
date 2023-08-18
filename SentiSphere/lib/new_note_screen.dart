import 'package:flutter/material.dart';
import 'colors.dart';
import 'notes_provider.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _noteController = TextEditingController();
  int emojiRating = 3;

  void _saveNote() async {
    final note = {
      'content': _noteController.text,
      'date': DateTime.now().toIso8601String(),
      'emojiRating': emojiRating,
    };
    await NotesProvider().writeNote(note);
    Navigator.pop(context); // Return to the previous screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _noteController,
              maxLines: null, // Allows multiple lines
              decoration: InputDecoration(
                hintText: 'Write your gratitude note here...',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Rate your feeling:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                    (index) => Container(
                  decoration: BoxDecoration(
                    color: emojiRating == index ? AppColors.primaryLight : Colors.transparent, // Background color changes based on selection
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: IconButton(
                    icon: Icon(
                      index == 0
                          ? Icons.sentiment_very_dissatisfied
                          : index == 1
                          ? Icons.sentiment_dissatisfied
                          : index == 2
                          ? Icons.sentiment_neutral
                          : index == 3
                          ? Icons.sentiment_satisfied
                          : Icons.sentiment_very_satisfied,
                    ),
                    onPressed: () {
                      setState(() {
                        emojiRating = index;
                      });
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        child: Icon(Icons.save),
      ),
    );
  }
}
