import 'package:flutter_project_template/features/common/domain/models/response/default_res.dart';
import 'package:flutter_project_template/features/products/domain/models/request/create_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/delete_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_category_lookup_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/update_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_category_lookup_res.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_project_template/shared/constants/apis.dart';

part 'products_api_service.g.dart';

@RestApi()
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;

  @GET(Apis.products)
  Future<HttpResponse<ProductRes>> getProducts(@Queries() ProductReq request);

  @POST(Apis.products)
  Future<HttpResponse<DefaultRes>> createProducts(
    @Body() CreateProductReq request,
  );

  @PUT(Apis.products)
  Future<HttpResponse<DefaultRes>> updateproducts(
    @Body() UpdateProductReq request,
  );

  @DELETE(Apis.products)
  Future<HttpResponse<DefaultRes>> deleteProducts(
    @Body() DeleteProductReq request,
  );

  @GET(Apis.productCategoryLookup)
  Future<HttpResponse<ProductCategoryLookupRes>> productCategoryLookup(
    @Queries() ProductCategoryLookupReq request,
  );
}
