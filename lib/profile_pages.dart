import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController songController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<Map<String, dynamic>> tasks = [];
  bool _showDateError = false;

  void addTask() {
    if (_selectedDate == null) {
      setState(() {
        _showDateError = true;
      });
      return;
    }

    setState(() {
      tasks.add({
        'name': taskController.text,
        'deadline': "${_selectedDate!.toLocal()}".split(' ')[0],
        'done': false,
      });
      taskController.clear();
      _selectedDate = null;
      _showDateError = false;
    });
  }

  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Form Page",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [Text("Task Date: ", style: TextStyle(fontSize: 18))],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Select a date"
                                  : "${_selectedDate!.toLocal()}".split(' ')[0],
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () => _pickDate(context),
                            ),
                          ],
                        ),
                        if (_showDateError && _selectedDate == null)
                          Text(
                            'Please select a date',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: taskController,
                        decoration: InputDecoration(
                          label: Text('First Name'),
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          if (_selectedDate == null) {
                            setState(() {
                              _showDateError = true;
                            });
                          } else {
                            addTask();
                            setState(() {
                              _showDateError = false;
                            });
                          }
                        }
                      },
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 61, 14, 136),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "List Task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 219, 219, 219),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tasks[index]['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text('Deadline: ${tasks[index]['deadline']}'),
                                if (tasks[index]['done'])
                                  Text(
                                    'Done',
                                    style: TextStyle(color: Colors.green),
                                  )
                                else
                                  Text(
                                    'Not Done',
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: tasks[index]['done'],
                            onChanged: (bool? value) {
                              toggleTaskStatus(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}