import 'package:eol/account-1/profile_edite.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  String currentUserEmail = "";
  String userName = "";

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'User';
      currentUserEmail = prefs.getString('email') ?? 'Email';
    });
  }

  @override
  Widget build(BuildContext context) {
    // var isDark =MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 25.0, right: 25, top: 60, bottom: 90),
          child: Column(
            children: [
              const Text(
                "profile",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: AutofillHints.addressCityAndState),
              ),
              const SizedBox(
                height: 10,
              ),
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
                          LineAwesomeIcons.alternate_pencil,
                          color: Color.fromARGB(255, 245, 244, 244),
                          size: 20,
                        ),
                      ))
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              Text(userName),
              Text(
                currentUserEmail,
                maxLines: 1,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => profile_edite()));
                    },
                    child: const Text(
                      "edite",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 20, 94, 1),
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),

              //menu
              // profilemenuwidget(title: "setting",icon: LineAwesomeIcons.cog,onPressed: (){},),
              profilemenuwidget(
                title: "billing details",
                icon: LineAwesomeIcons.wallet,
                onPressed: () {},
              ),
              profilemenuwidget(
                title: "user management",
                icon: LineAwesomeIcons.user_check,
                onPressed: () {},
              ),
              profilemenuwidget(
                title: "delete account",
                icon: Icons.delete,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class profilemenuwidget extends StatelessWidget {
  const profilemenuwidget({
    required this.title,
    required this.onPressed,
    required this.icon,
    this.endicon = true,
    this.textcolor,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endicon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(255, 108, 163, 226).withOpacity(0.2),
        ),
        child: Icon(icon),
      ),
      title: Text(
        title,
      ),
      trailing: endicon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18.0,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
