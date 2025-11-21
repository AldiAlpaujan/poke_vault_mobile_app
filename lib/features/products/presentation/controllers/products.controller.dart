import 'package:flutter_project_template/app/routes/pages.dart';
import 'package:flutter_project_template/config/bases/base_api_pagination.dart';
import 'package:flutter_project_template/features/products/domain/models/request/delete_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:flutter_project_template/features/products/domain/usecases/delete_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/get_products_uc.dart';
import 'package:flutter_project_template/features/products/presentation/views/product_detail.view.dart';
import 'package:flutter_project_template/shared/utils/main_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends ApiPagination<Product> {
  final _editMode = false.obs;
  final _selectedItem = <int>[].obs;

  bool get editMode => _editMode.value;
  bool get isSelectAll => _selectedItem.length == data.length;
  List<int> get selectedItem => _selectedItem();

  @override
  Future<void> getData({bool isLoad = false, String? keyword}) async {
    final uc = Get.find<GetProductsUc>().call;
    await runRequest(
      (req) => uc(request: ProductReq.fromParent(req)),
      isLoad,
      keyword,
    );
  }

  @override
  Future<void> loadData() async {
    await getData(isLoad: true);
  }

  @override
  Future<void> refreshData() {
    return getData();
  }

  Future<void> bulkDelete() async {
    if (selectedItem.isNotEmpty) {
      await deleteProducts(
        selectedItem,
        onSuccess: () => _selectedItem.value = [],
      );
    } else {
      modalHelper.info(message: 'Silahkan pilih data yang ingin dihapus');
    }
  }

  Future<void> deleteProducts(List<int> ids, {VoidCallback? onSuccess}) async {
    final result = await modalHelper.confirm(
      message: 'Apakah Anda yakin ingin menghapus data?',
    );
    if (result == true) {
      modalHelper.loading();
      final result = await Get.find<DeleteProductsUc>().call(
        request: DeleteProductReq(ids: ids),
      );
      Get.back();
      handleApiResult(
        result,
        onSuccess: (_) {
          getData();
          onSuccess?.call();
        },
      );
    }
  }

  Future<void> openForm({Product? item}) async {
    final result = await Get.toNamed(Routes.productForm, arguments: item);
    if (result == true) {
      if (item != null) {
        Get.back();
        await getData();
        modalHelper.showBottomBar(
          ProductDetailView(item: data.firstWhere((e) => e.id == item.id)),
        );
      } else {
        getData();
      }
      modalHelper.info(
        message: item == null
            ? 'Data berhasil ditambahkan'
            : 'Data berhasil diubah',
      );
    }
  }

  void onCardTap(Product item) {
    if (editMode) {
      setSelectedItem(item.id);
    } else {
      modalHelper.showBottomBar(ProductDetailView(item: item));
    }
  }

  void editModeToggle() {
    _editMode.value = !editMode;
    if (!editMode) {
      _selectedItem.value = [];
    }
  }

  void setSelectedItem(int value) {
    late List<int> newItems;
    if (_selectedItem.contains(value)) {
      newItems = _selectedItem.where((e) => e != value).toList();
    } else {
      newItems = [..._selectedItem, value];
    }
    _selectedItem.value = newItems;
  }

  void selectAllToggle() {
    if (_selectedItem.length == data.length) {
      _selectedItem.value = [];
    } else {
      _selectedItem.value = data.map((e) => e.id).toList();
    }
  }

  bool itemIsSelected(int id) => _selectedItem.contains(id);

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
