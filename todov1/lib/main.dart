import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Todoapp(),
    );
  }
}

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});
  @override
  State createState() => _TodoappState();
}

class Tasksmodelclass {
  String? title;
  String? description;
  String? date;

  Tasksmodelclass({this.title, this.description, this.date});
}

class User {
  final String? userid;
  final String? password;
  const User({this.userid, this.password});
}

class _TodoappState extends State {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  bool isempty = false;
  // bool editing = false;
  void showBottomSheet(bool isediting, [Tasksmodelclass? obj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Task",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    TextField(
                      controller: title,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    TextField(
                      controller: description,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    TextField(
                      controller: date,
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.date_range_rounded),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12))),
                      onTap: () async {
                        DateTime? pickdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));
                        String formatedDate =
                            DateFormat.yMMMd().format(pickdate!);
                        setState(() {
                          date.text = formatedDate;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    if (!isediting) {
                      addCard(isediting);
                    } else {
                      // editttask(obj);
                      addCard(isediting, obj);
                    }

                    setState(() {
                      title.clear();
                      description.clear();
                      date.clear();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    "submit",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          );
        });
  }

  void addCard(bool isediting, [Tasksmodelclass? obj]) {
    if (title.text.trim().isNotEmpty &&
        description.text.trim().isNotEmpty &&
        date.text.trim().isNotEmpty) {
      if (!isediting) {
        tasks.add(Tasksmodelclass(
            title: title.text, description: description.text, date: date.text));
      } else {
        obj!.title = title.text;
        obj.description = description.text;
        obj.date = date.text;
      }
    }
  }
 

  void editttask(int index) {
    title.text = tasks[index].title;
    description.text = tasks[index].description!;
    date.text = tasks[index].date;

    setState(() {});
    // showBottomSheet(true);
  }

  void deletecard(int index) {
    tasks.remove(tasks[index]);
    setState(() {});
  }

  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Color> getcolor = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];
  List userbase = [const User(userid: "lalit", password: "lalitahire")];

  List tasks = [];
  bool isLogged = false;
  Scaffold getScaffold() {
    if (isLogged) {
      return Scaffold(
        appBar: AppBar(
          title: Text("To-Do App",
              style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 30))),
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
        body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(82, 84, 84, 0.529),
                            offset: Offset(10, 10),
                            spreadRadius: 2,
                            blurRadius: 3)
                      ],
                      color: getcolor[index % getcolor.length],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Image.asset("assets/Group42.png"),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${tasks[index].title}",
                                    style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${tasks[index].description}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color:
                                                Color.fromRGBO(84, 84, 84, 1))),
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${tasks[index].date}",
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(132, 132, 132, 1))),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      editttask(index);
                                      showBottomSheet(true, tasks[index]);
                                    },
                                    child: const Icon(Icons.edit_outlined),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deletecard(index);
                                    },
                                    child: const Icon(Icons.delete_outline),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheet(false);
          },
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(227, 245, 247, 1),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                  width: 330,
                  child: Text(
                    "welcome user",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 40, left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 8,
                          blurRadius: 8,
                          color: Color.fromRGBO(207, 233, 235, 1))
                    ],
                    border: Border.all(
                        width: 2,
                        color: const Color.fromRGBO(151, 223, 228, 1)),
                    color: const Color.fromRGBO(247, 250, 250, 1)),
                child: Column(
                  children: [
                    TextFormField(
                        controller: userId,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "enter your username",
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "please enter username!!";
                          } else {
                            return null;
                          }
                        })),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "enter your password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: const Icon(Icons.remove_red_eye)),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "please enter password!!";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    backgroundColor: const Color.fromARGB(255, 110, 220, 226),
                  ),
                  onPressed: () {
                    bool loginvalidate = _formKey.currentState!.validate();
                    if (loginvalidate) {
                      if (userId.text == userbase[0].userid &&
                          password.text == userbase[0].password) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Login Successful!!"),
                        ));
                        isLogged = true;
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Login failed!!"),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Login failed!!"),
                      ));
                    }
                  },
                  child: const Text("log in"))
            ]),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getScaffold();
  }
}
