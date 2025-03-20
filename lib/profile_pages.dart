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

  void addTask() {
    setState(() {
      tasks.add({
        'name': taskController.text,
        'deadline': _selectedDate != null
            ? "${_selectedDate!.toLocal()}".split(' ')[0]
            : 'No deadline',
        'done': false,
      });
      taskController.clear();
      _selectedDate = null;
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

                // spacing: 15,
                // children: [
                //   CircleAvatar(
                //     radius: 35,
                //     backgroundImage: AssetImage('assets/images/adan.jpg'),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(' ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                //         Text('',)
                //       ],
                //     )
                // ],
              ),
              Row(
                children: [Text("Task Date: ", style: TextStyle(fontSize: 18))],
              ),
              Row(
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
                        controller: songController,
                        decoration: InputDecoration(
                          label: Text('First Name'),
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          addData();
                        }
                      },
                      child: Text('Submit'),
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
              Text(
                "List Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarLagu.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.indigo[100],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tasks[index]['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
