import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NotesProvider {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.json');
  }
  Future<void> deleteNote(int index) async {
    final notes = await readNotes();
    notes.removeAt(index); // Remove the note at the specified index
    final file = await _localFile;
    await file.writeAsString(json.encode(notes));
  }

  Future<void> updateNote(
      String oldDate, String newContent, int newEmojiRating) async {
    final notes = await readNotes();
    final noteIndex = notes.indexWhere((note) => note['date'] == oldDate);

    if (noteIndex != -1) {
      notes[noteIndex]['content'] = newContent;
      notes[noteIndex]['emojiRating'] = newEmojiRating;
      final file = await _localFile;
      await file.writeAsString(json.encode(notes));
    }
  }

  Future<List<double>> weeklyEmojiAverages() async {
    List<Map<String, dynamic>> notes = await readNotes();

    // Assuming notes are sorted by date, we can group them by week
    Map<int, List<double>> weeklyRatings = {};
    for (var note in notes) {
      final date = DateTime.parse(note['date']);
      final weekNumber = (date.day + date.weekday - 1) ~/ 7;
      final rating = double.parse(note['emojiRating'].toString());

      weeklyRatings.putIfAbsent(weekNumber, () => []).add(rating);
    }

    List<double> weeklyAverages = [];
    weeklyRatings.forEach((week, ratings) {
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      weeklyAverages.add(average);
    });

    return weeklyAverages;
  }


  Future<List<Map<String, dynamic>>> readNotes() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      // If there's an error reading the file, return an empty list
      return [];
    }
  }

  Future<void> writeNote(Map<String, dynamic> note) async {
    final notes = await readNotes();
    notes.add(note);
    final file = await _localFile;
    await file.writeAsString(json.encode(notes)); // Removed the return statement here
  }


// Additional methods to update, delete notes if needed
}
