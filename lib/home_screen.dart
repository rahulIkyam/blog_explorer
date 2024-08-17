import 'package:blog_explorer/detailed_blog.dart';
import 'package:flutter/material.dart';

import 'StateManagement/bloc/item_bloc.dart';
import 'StateManagement/model/item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
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
      body: StreamBuilder<ItemModel>(
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
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => DetailedBlog(
                                      postNo: index,
                                      image: blogs[index].imageUrl,
                                      title: blogs[index].title,
                                      id: blogs[index].id
                                  ),
                                )
                            );
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
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              print('------ like -----');
                                              print(index);
                                              setState(() {
                                                blogs[index].isFavorite = !blogs[index].isFavorite;
                                              });
                                            },
                                            icon: blogs[index].isFavorite ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_border)
                                        ),
                                        Expanded(
                                          child: Text(
                                            blogs[index].title,
                                            style: const TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ],
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
      ),
    );
  }
}
