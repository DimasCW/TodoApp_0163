import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController songController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarLagu = [];

  void addData(){
    setState(() {
      daftarLagu.add(songController.text);
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
                  Text("Form Page", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
              Form(
                key: key,
                child: Row(
                children: [
                  Expanded(child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Harap Masukan Lagu yang kamu suka';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: songController,
                    decoration: InputDecoration(
                      label: Text('Fav Song'),
                      hintText: 'Masukan Lagu',
                      ),
                    )
                  ),
                  OutlinedButton(onPressed: (){
                    if (key.currentState!.validate()){
                      addData();
                    }
                  }, child: Text('Submit')),
                ],
              )),
              const SizedBox(height: 20),
              Expanded(child: ListView.builder(
                itemCount: daftarLagu.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.indigo[100]),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(daftarLagu[index])],),
                  );
                })
              )
            ],
          ),
        ),
      ),
    );
  }
}