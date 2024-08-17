import 'package:flutter/material.dart';

class DetailedBlog extends StatefulWidget {
  final int postNo;
  final String image;
  final String title;
  final String id;
  const DetailedBlog({
    required this.postNo,
    required this.image,
    required this.title,
    required this.id,
    super.key
  });

  @override
  State<DetailedBlog> createState() => _DetailedBlogState();
}

class _DetailedBlogState extends State<DetailedBlog> {
  int num = 0;
  String imageName = "";
  String imageTitle = "";
  String imageId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('------ detailed blog --------');
    print(widget.postNo);
    print(widget.id);
    print(widget.title);
    print(widget.image);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post No: ${widget.postNo+1}"),
        backgroundColor: Colors.black26,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 250,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
                  ),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
