import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/config/bases/base_response.dart';
import 'package:poke_vault_mobile_app/features/common/domain/models/request/pagination_req.dart';
import 'package:poke_vault_mobile_app/shared/utils/handler_api_mixin.dart';
import 'package:get/get.dart';

abstract class ApiPagination<T> extends GetxController with HandlerApiMixin {
  var _keyword = '';
  var _currentPage = 1;
  var _offset = 0;
  final _rowsPerPage = 20;
  final _noData = true.obs;
  final _isError = false.obs;
  final _isLoading = false.obs;
  final _data = <T>[].obs;

  List<T> get data => _data();

  bool get noData => _noData.value;
  bool get isError => _isError.value;
  bool get isLoading => _isLoading.value;

  @protected
  Future<void> runRequest(
    Future<DataState<dynamic>> Function(PaginationReq) request,
    bool isLoad,
    String? keyword,
  ) async {
    if (!isLoad) {
      _currentPage = 1;
      _offset = 0;
      _noData.value = false;
      _isError.value = false;
      _isLoading.value = true;
    }
    _keyword = keyword ?? _keyword;

    final result = await request(
      PaginationReq(
        page: _currentPage,
        offset: _offset,
        limit: _rowsPerPage,
        search: _keyword,
      ),
    );
    _isLoading.value = false;

    handleApiResult(
      result,
      onSuccess: (v) {
        final dataTmp = ((v as BaseResponse).data as List<T>?) ?? [];
        _noData.value = dataTmp.length < _rowsPerPage;
        _data.value = !isLoad ? dataTmp : [..._data(), ...dataTmp];
        _currentPage++;
        _offset = _rowsPerPage * (_currentPage - 1);
      },
      onError: (_) {
        _isError.value = true;
        _noData.value = true;
      },
    );
  }

  @protected
  Future<void> getData({bool isLoad = false, String? keyword});

  @protected
  Future<void> refreshData();

  @protected
  Future<void> loadData();
}
