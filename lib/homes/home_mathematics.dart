import 'package:eol/Subjects/sub-math/subject_math.dart';
import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/account-1/account.dart';
import 'package:eol/componet/crud.dart';
import 'package:eol/constant/link.dart';
import 'package:eol/contact_view.dart';
import 'package:eol/login/sign/login.dart';
import 'package:eol/main.dart';
import 'package:eol/models/subject_model.dart';
import 'package:eol/plan/cardnote.dart';
import 'package:eol/plan/note/editenote.dart';
import 'package:eol/plan/plan_note_showbottom.dart';
import 'package:eol/plan/planonly/staticplan.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMathematics extends StatefulWidget {
  final int? departmentId;

  const HomeMathematics({super.key, this.departmentId});

  @override
  State<HomeMathematics> createState() => _HomeMathematicsState();
}

class _HomeMathematicsState extends State<HomeMathematics> with Crud {
  String currentUserEmail = "";
  String userName = "";

  List<SubjectModel> subjects = [];

  Future<List<SubjectModel>> getSubjects() async {
    var response = await postRequest(linkSubject, {
      "departmentid": widget.departmentId.toString(),
    });

    if (response['status'] == 'success') {
      List subjectsData = response['data'];
      subjects = subjectsData.map((data) {
        return SubjectModel(
          subjectName: data['subjects_name'],
          subjectImg: data['subjects_image'],
          subjectsId: data['subjects_id'],
          departmentsId: data['departments_id'],
          departmentsName: data['departments_name'],
          subjectsDepartmentsId: data['subjects_departments'],
        );
      }).toList();
      return subjects;
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  _HomeMathematicsState();

  getNote() async {
    var response = await postRequest(linkViewNote, {
      "id": sharepref.getString("id"),
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    getSubjects();
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.bluelight,
      drawer: _buildDrawer(context),
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bluelight,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'EOL',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
          fontFamily: 'Smooch-Regular',
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.search),
        ),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildDrawerHeader(),
            _buildDrawerItem(
              title: "Account",
              icon: Icons.account_balance_rounded,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const account())));
              },
            ),
            _buildDrawerItem(
              title: "Order",
              icon: Icons.check_box,
              onTap: () {},
            ),
            _buildDrawerItem(
              title: "Contact Us",
              icon: Icons.phone_android_outlined,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const ContactView())));
              },
            ),
            _buildDrawerItem(
              title: "Logout",
              icon: Icons.exit_to_app,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset('images/face.PNG', fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(userName),
            subtitle: Text(
              currentUserEmail,
              maxLines: 1,
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  ListTile _buildDrawerItem(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 60, bottom: 90),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowItems(context),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: Lottie.asset('images/Animation - 1701549531524.json',
                      width: 200, height: 80)),
              _buildBottomRowItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowItems(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 30),
          child: _buildMenuItem(
            title: "Subject",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SubjectViewMath(
                        subjects: subjects,
                      )));
            },
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 15),
          child: _buildMenuItem(
            title: "Community",
            onTap: () {
              Navigator.of(context).pushNamed("community");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRowItems(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30),
          child: _buildMenuItem(
            title: "Plan/Note",
            onTap: () {
              scaffoldKey.currentState!.showBottomSheet(
                (context) => _buildBottomSheet(context),
              );
            },
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 15),
          child: _buildMenuItem(
            title: "Make your plan/ask",
            onTap: () {
              Navigator.of(context).pushNamed("chooseplan_and_ask");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({required String title, required VoidCallback onTap}) {
    bool isHovered = false;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isHovered ? 160 : 140,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          width: 120,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      color: const Color.fromARGB(255, 250, 250, 248),
      child: Column(
        children: [
          const SizedBox(height: 30),
          plan_note(
            title: "Plan",
            icon: Icons.calendar_today,
            onpress: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StaticPaln()));
            },
          ),
          const SizedBox(height: 10),
          plan_note(
            title: "Note",
            icon: Icons.article,
            onpress: () {
              Navigator.of(context).pushNamed("addnote");
            },
          ),
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder(
              future: getNote(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail' ||
                      snapshot.data['data'] == null) {
                    return const Center(
                      child: Text(
                        "There are no notes",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data['data']?.length ?? 0,
                    itemBuilder: (context, i) {
                      return Container(
                        width: 200, // Adjust width as needed
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: cardnote(
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditNote(
                                notes: snapshot.data['data'][i],
                              ),
                            ));
                          },
                          title: "${snapshot.data['data'][i]['notes_title']}",
                          content:
                              "${snapshot.data['data'][i]['notes_content']}",
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text("Loading . . ."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
