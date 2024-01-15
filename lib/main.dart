import 'package:flutter/material.dart';

void main() {
  runApp(SubjectCalculatorApp());
}

class SubjectCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SubjectCalculator(subjectTotalMarks: [100.0, 150.0, 120.0, 200.0]),
    );
  }
}

class SubjectCalculator extends StatefulWidget {
  final List<double> subjectTotalMarks;

  SubjectCalculator({required this.subjectTotalMarks});

  @override
  _SubjectCalculatorState createState() => _SubjectCalculatorState();
}

class _SubjectCalculatorState extends State<SubjectCalculator> {
  List<double> subjectMarks = [0.0, 0.0, 0.0, 0.0];
  double totalMarks = 0.0;
  String result = ''; // Status of pass or fail

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subject Calculator'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter Marks for Each Subject:',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                for (int i = 0; i < subjectMarks.length; i++)
                  _buildTextField(i + 1),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _calculateTotalMarks();
                  },
                  child: Text('Calculate Total'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Total Marks: $totalMarks',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Result: $result',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _resetMarks();
                  },
                  child: Text('Reset Marks'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(int subjectNumber) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Subject $subjectNumber Marks'),
            onChanged: (value) {
              setState(() {
                subjectMarks[subjectNumber - 1] = double.parse(value);
              });
            },
          ),
        ],
      ),
    );
  }

  void _calculateTotalMarks() {
    double totalObtainedMarks = 0.0;

    for (int i = 0; i < subjectMarks.length; i++) {
      totalObtainedMarks += subjectMarks[i];
    }

    setState(() {
      totalMarks = totalObtainedMarks;

      // Determine pass or fail status
      result = totalMarks >= 40.0 ? 'Pass' : 'Fail';
    });
  }

  void _resetMarks() {
    setState(() {
      for (int i = 0; i < subjectMarks.length; i++) {
        subjectMarks[i] = 0.0;
      }
      totalMarks = 0.0;
      result = ''; // Reset result status
    });
  }
}
