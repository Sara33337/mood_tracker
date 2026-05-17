import 'package:flutter/material.dart';
import 'package:painter/features/home/presentation/widgets/moodButton.dart';
import 'package:painter/features/home/presentation/widgets/moodCard.dart';
import 'package:painter/features/home/data/models/moodModel.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  // Mock initial data representing some past entries
  final List<MoodEntry> _timelineEntries = [
    MoodEntry(type: MoodType.happy, date: DateTime.now().subtract(const Duration(days: 6)), color: Colors.green),
    MoodEntry(type: MoodType.neutral, date: DateTime.now().subtract(const Duration(days: 5)), color: Colors.amber),
    MoodEntry(type: MoodType.sad, date: DateTime.now().subtract(const Duration(days: 4)), color: Colors.blue),
    MoodEntry(type: MoodType.happy, date: DateTime.now().subtract(const Duration(days: 3)), color: Colors.green),
    MoodEntry(type: MoodType.happy, date: DateTime.now().subtract(const Duration(days: 2)), color: Colors.green),
  ];

  void _logMood(MoodType type, Color color) {
    setState(() {
      _timelineEntries.add(MoodEntry(type: type, date: DateTime.now(), color: color));
      
      if (_timelineEntries.length > 7) {
        _timelineEntries.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mood Tracker App', style: TextStyle(color: Colors.green , fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                "How are you feeling right now?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.green),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildLogButton(type : MoodType.happy, color: Colors.green, label: "Happy", onPressed: () => _logMood(MoodType.happy, Colors.green)),
                  const SizedBox(width: 24),
                  BuildLogButton(type : MoodType.neutral, color: Colors.amber, label: "Neutral", onPressed: () => _logMood(MoodType.neutral, Colors.amber)),
                  const SizedBox(width: 24),
                  BuildLogButton(type : MoodType.sad, color: Colors.blue, label: "Sad", onPressed: () => _logMood(MoodType.sad, Colors.blue)),
                ],
              ),
            ],
          ),

    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text("Your Last 7 Entries", style: TextStyle( fontWeight: FontWeight.w500)),
       
                  
                ),
                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
              ],
            ),
          ),

          SizedBox(
            height: 160,
            child: _timelineEntries.isEmpty
                ? const Center(child: Text("No entries logged yet."))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _timelineEntries.length,
                    itemBuilder: (context, index) {
                      return MoodCard(entry: _timelineEntries[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}