import "package:flutter/material.dart" hide badge;
import 'package:freelance_app/utils/colors.dart';

import '../homescreen/sidebar.dart';

class FieldModel {
  String? job_title;
  String? company_name;
  FieldModel(this.job_title, this.company_name);
}

class Search extends StatefulWidget {
  static const routename = "search";

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
// sample lists for filtering

  static List<FieldModel> main_field_list = [
    FieldModel("Network Security", "Cyber Security"),
    FieldModel("Software Security developer", " Cyber Security "),
    FieldModel("Computer Forensic Engineer", "Cyber Security "),
    FieldModel("Security Consultant", "Cyber Security"),
    FieldModel("Ethical Hacker", "Cyber Security"),
  ];
  List<FieldModel> display_list = List.from(main_field_list);
  void Updatelist(String value) {
// for filtering the list
    setState(() {
      display_list = main_field_list
          .where((element) =>
              element.job_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideBar(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 180),
            child: Image(image: AssetImage("assets/images/logo.png"))
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 40),
                child: Text("Search For A Job",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                        color: black)),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  onChanged: (value) => Updatelist(value),
                  style: TextStyle(color: Colors.deepPurple),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: "Security Software Development",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Color.fromRGBO(97, 68, 152, 1.0),
                    suffixIcon: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        //fixedSize: const Size.fromWidth(100),
                        padding: const EdgeInsets.all(22),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.search),
                    ),
                    suffixIconColor: yellow,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 200,
                child: display_list.isEmpty
                    ? const Center(
                        child: Text("No result found",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: display_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('${display_list[index].job_title!}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle:
                                Text('${display_list[index].company_name!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    )),
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
