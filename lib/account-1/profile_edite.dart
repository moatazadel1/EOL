import 'package:eol/account-1/account.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class profile_edite extends StatefulWidget {
  const profile_edite({super.key});

  @override
  State<profile_edite> createState() => _profile_editeState();
}

class _profile_editeState extends State<profile_edite> {
  TextEditingController fullName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => account()));
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text("edite"),
        actions: [
          //IconButton(onPressed: (){}, icon: Icon(isDark? LineAwesomeIcons.sun:LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 25.0, right: 25, top: 60, bottom: 90),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'images/face.PNG',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 20, 94, 1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Color.fromARGB(255, 245, 244, 244),
                          size: 20,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  TextField(
                    controller: fullName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 20, 94, 1),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        label: Text("Full Name",
                            style: Theme.of(context).textTheme.bodySmall)),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 20, 94, 1),
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                      )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
