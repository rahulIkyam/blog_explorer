import 'package:blog_explorer/StateManagement/model/item_model.dart';
import 'package:blog_explorer/StateManagement/network/network_provider.dart';
import 'package:rxdart/subjects.dart';

// Third

class ItemBloc {
  final itemDetailsProvider = ItemNetwork();
  final _itemDetailsController = PublishSubject<ItemModel>();

  Stream<ItemModel> get itemDetailsStream => _itemDetailsController.stream;

  fetchItemNetwork() async {
    try {
      ItemModel result = await itemDetailsProvider.fetchItemData();
      _itemDetailsController.sink.add(result);
    } catch (error) {
      _itemDetailsController.sink.addError("Failed to fetch data");
    }
  }

  dispose() {
    _itemDetailsController.close();
  }
}

final itemDetailsBloc = ItemBloc();