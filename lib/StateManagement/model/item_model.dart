// first

// class ItemModel{
//   List<_ItemModel> _list = [];
//   ItemModel.fromProvider(Map parsedJson){
//     List<_ItemModel> temp = [];
//     _ItemModel result = _ItemModel(parsedJson);
//     temp.add(result);
//     _list = temp;
//   }
//   List<_ItemModel> get docketData => _list;
// }
//
// class _ItemModel {
//   Map _data = {};
//   _ItemModel(response){
//     _data = {
//       "blogs": [
//         {
//           "id": response['id']??"",
//           "image_url": response["image_url"]??"",
//           "title": response["title"]??""
//         }
//       ]
//     };
//   }
//   Map get itemData => _data;
// }


class ItemModel {
  List<Blog> blogs = [];

  ItemModel.fromProvider(Map<String, dynamic> parsedJson) {
    if (parsedJson['blogs'] != null) {
      blogs = List<Blog>.from(parsedJson['blogs'].map((blog) => Blog.fromJson(blog)));
    }
  }
}

class Blog {
  String id;
  String imageUrl;
  String title;
  bool isFavorite;

  Blog({required this.id, required this.imageUrl, required this.title,  this.isFavorite = false});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      imageUrl: json['image_url'],
      title: json['title'],
    );
  }
}
