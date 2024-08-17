import 'dart:convert';

import 'package:blog_explorer/StateManagement/bloc/item_bloc.dart';
import 'package:blog_explorer/StateManagement/model/item_model.dart';
import 'package:blog_explorer/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  Map responseData = {};
  List blogs = [];
  Future getDetails() async{
    String url = "https://intent-kit-16.hasura.app/api/rest/blogs";
    final response = await http.get(
        Uri.parse(url),
      headers: {
          "x-hasura-admin-secret":"32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6"
      }
    );
    if(response.statusCode == 200){
      responseData = json.decode(response.body);
      if(responseData.isNotEmpty){
        blogs = responseData["blogs"];
        setState(() {
          isLoading = false;
        });
      }
      print('-------- response ---------');
      // print(responseData["blogs"]);
      print(blogs.length);
    }else{
      setState(() {
        isLoading = false;
      });
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    itemDetailsBloc.fetchItemNetwork();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text("Blogs and Articles"),
        centerTitle: true,
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) :
      Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/whatsappbg.jpg")),
          // Center(
          //   child: ListView.builder(
          //     itemCount: blogs.length,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
          //         child: Container(
          //           // width: 250,
          //           color: Colors.transparent,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               InkWell(
          //                 onTap: () {
          //                   print('------- i ------');
          //                   print(index);
          //                 },
          //                 child: SizedBox(
          //                   width: 250,
          //                   child: Card(
          //                     color: Colors.grey[200],
          //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          //                     elevation: 4,
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         ClipRRect(
          //                           borderRadius: const BorderRadius.only(
          //                               topLeft: Radius.circular(3),
          //                               topRight: Radius.circular(3)
          //                           ),
          //                           child: Image.network(
          //                             blogs[index]["image_url"],
          //                             fit: BoxFit.cover,
          //                             height: 200,
          //                           ),
          //                         ),
          //                         Padding(
          //                           padding: const EdgeInsets.all(3.0),
          //                           child: Text(blogs[index]["title"],style: const TextStyle(color: Colors.black,fontSize: 14)),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          StreamBuilder<ItemModel>(
            stream: itemDetailsBloc.itemDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Blog> blogs = snapshot.data!.blogs;
                return ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                print('------- i ------');
                                print(index);
                                print(blogs[index].id);
                              },
                              child: SizedBox(
                                width: 250,
                                child: Card(
                                  color: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          topRight: Radius.circular(3),
                                        ),
                                        child: Image.network(
                                          blogs[index].imageUrl,
                                          fit: BoxFit.cover,
                                          height: 200,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          blogs[index].title,
                                          style: const TextStyle(color: Colors.black, fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          )

        ],
      ),
    );
  }
}

