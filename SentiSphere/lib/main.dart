import 'colors.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'new_note_screen.dart';
import 'notes_list_screen.dart'; // Your notes list screen file
import 'emotional_tracking_screen.dart'; // Your emotional tracking screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Gratitude Journal'), backgroundColor: AppColors.primaryDark),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                text: 'Write a New Gratitude Note',
                icon: Icons.edit,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewNoteScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                text: 'View Previous Notes',
                icon: Icons.note,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotesListScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                text: 'See Weekly Emotional Averages',
                icon: Icons.show_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmotionalTrackingScreen()),
                  );
                },
              ),
            ),
            // Add more buttons for other options
          ],
        ),
      ),
    );
  }
}