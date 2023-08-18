import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'colors.dart';
import 'notes_provider.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> note;

  NoteDetailsScreen({required this.note});

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _contentController;
  int _emojiRating = 0; // Initialize with the default emojiRating

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.note['content']);
    _emojiRating = widget.note['emojiRating'] ?? 0;
  }

  void _shareNote() {
    Share.share(widget.note['content']);
  }

  void _saveEditedNote() async {
    final updatedNote = {
      'content': _contentController.text,
      'date': widget.note['date'],
      'emojiRating': _emojiRating,
    };

    await NotesProvider().updateNote(
      widget.note['date'], // Use the old date as the identifier
      _contentController.text, // New content
      _emojiRating, // New emoji rating
    );

    Navigator.pop(context, updatedNote); // Pass updatedNote back
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        backgroundColor: AppColors.primaryDark,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${widget.note['date']}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                    (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _emojiRating = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _emojiRating == index ? AppColors.primaryLight : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Icon(
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
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Edit your note here...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveEditedNote,
        child: Icon(Icons.save),
        backgroundColor: AppColors.primaryDark,
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
