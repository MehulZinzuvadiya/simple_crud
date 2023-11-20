import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_crud/Controller/home_controller.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  HomeController controller = Get.put(HomeController());
  TextEditingController updateName = TextEditingController();
  TextEditingController updateMobile = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'ReadScreen',
                style: GoogleFonts.poppins(),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Obx(
              () => ListView.builder(
                itemCount: controller.dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green.shade300,
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      title: Text("${controller.dataList[index]['name']}"),
                      subtitle: Text("${controller.dataList[index]['mobile']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                updateName = TextEditingController(
                                    text:
                                        "${controller.dataList[index]['name']}");
                                updateMobile = TextEditingController(
                                    text:
                                        "${controller.dataList[index]['mobile']}");
                                UpdateDialog(index);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black87,
                              )),
                          IconButton(
                              onPressed: () {
                                controller.deleteData(
                                    id: "${controller.dataList[index]['id']}");
                                controller.ReadData();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )));
  }

  void UpdateDialog(int index) {
    Get.defaultDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: updateName,
            validator: ValidationBuilder().required().maxLength(30).build(),
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
            controller: updateMobile,
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    controller.updateData(
                        id: controller.dataList[index]['id'],
                        name: updateName.text,
                        mobile: updateMobile.text);
                    Get.back();
                  },
                  child: Text('Update')),
            ],
          ),
        ],
      ),
    );
  }
}
