import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ToDo> dataList = [];
  List<ToDo> searchDataList = [];
  Future<List<ToDo>> fetchToDo() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object ToDo
    List<ToDo> listToDo = [];
    for (var d in data) {
      if (d != null) {
        listToDo.add(ToDo.fromJson(d));
      }
    }
    setState(() {
      dataList = listToDo;
    });
    return listToDo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search'),
                onChanged: (value) {
                  setState(() {
                    searchDataList = dataList
                        .where((element) => element.title!.contains(value))
                        .toList();
                  });
                },
              ),
            ),
            searchDataList.isNotEmpty
                ? Text('result ${searchDataList.length}')
                : const SizedBox.shrink(),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchDataList.isNotEmpty
                      ? searchDataList.length
                      : dataList.length,
                  itemBuilder: (_, index) {
                    ToDo data = searchDataList.isNotEmpty
                        ? searchDataList[index]
                        : dataList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 2.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${data.id}"),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        )
        // body: FutureBuilder(
        //     future: fetchToDo(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.data == null) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else {
        //         if (!snapshot.hasData) {
        //           return const Column(
        //             children: [
        //               Text(
        //                 "Tidak ada to do list :(",
        //                 style:
        //                     TextStyle(color: Color(0xff59A5D8), fontSize: 20),
        //               ),
        //               SizedBox(height: 8),
        //             ],
        //           );
        //         } else {
        //           return Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(20),
        //                 child: TextFormField(
        //                   decoration: const InputDecoration(
        //                       border: OutlineInputBorder(), hintText: 'Search'),
        //                   onChanged: (value) {},
        //                 ),
        //               ),
        //               Expanded(
        //                 child: ListView.builder(
        //                     shrinkWrap: true,
        //                     itemCount: snapshot.data!.length,
        //                     itemBuilder: (_, index) => Container(
        //                           margin: const EdgeInsets.symmetric(
        //                               horizontal: 16, vertical: 12),
        //                           padding: const EdgeInsets.all(20.0),
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               borderRadius: BorderRadius.circular(15.0),
        //                               boxShadow: const [
        //                                 BoxShadow(
        //                                     color: Colors.black,
        //                                     blurRadius: 2.0)
        //                               ]),
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 "${snapshot.data![index].title}",
        //                                 style: const TextStyle(
        //                                   fontSize: 18.0,
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                               ),
        //                               const SizedBox(height: 10),
        //                               Text("${snapshot.data![index].id}"),
        //                             ],
        //                           ),
        //                         )),
        //               ),
        //             ],
        //           );
        //         }
        //       }
        //     }),
        );
  }
}

Mobil mobilFromJson(String str) => Mobil.fromJson(json.decode(str));
String mobilToJson(Mobil data) => jsonEncode(data.toJson());

class Mobil {
  Mobil({
    required this.id,
    required this.brand,
    required this.model,
    required this.color,
  });

  int id;
  String brand;
  String model;
  String color;

  factory Mobil.fromJson(Map<String, dynamic> json) => Mobil(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "color": color,
      };
}

class ToDo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ToDo({this.userId, this.id, this.title, this.completed});

  ToDo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }
}
