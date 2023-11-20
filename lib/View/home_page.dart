import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_crud/Controller/home_controller.dart';
import 'package:simple_crud/Utils/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  var formKey = GlobalKey<FormState>();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Sqflite",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        leading: const Icon(Icons.menu_open),
        backgroundColor: Colors.black,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtname,
                  validator:
                      ValidationBuilder().required().maxLength(30).build(),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    label: Text(
                      "Enter Name",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: txtmobile,
                  validator: ValidationBuilder().required().phone().build(),
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      "Enter Mobile",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            DBHelper.dbHelper.insertData(
                                name: txtname.text, mobile: txtmobile.text);
                          }
                        },
                        child: Text('Insert')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          Get.toNamed('/read');
                        },
                        child: Text('Read Data')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
