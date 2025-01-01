import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inv_management_app/models/base_model.dart';
import 'package:inv_management_app/models/item_model.dart';
import 'package:inv_management_app/models/new_base_model.dart';
import 'package:inv_management_app/models/sales_model.dart';
import 'package:inv_management_app/network/new_dio.dart';

import 'package:inv_management_app/network/rest_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/storage_service.dart';

class NetworkService {
  /*
  late final RestClient _restClient;
  final storageService = Get.find<StorageService>();

  Future<NetworkService> init() async {
    Dio dio = Dio();
    /* dio.options.headers['apikey'] =
        '18lFEyq2kgryn/6LrKnCPuMEB3MBntdBcKjXf2geSGM='; */
    //dio.interceptors.add(LogInterceptor()
    /*  DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ), */
    //  );
    // dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _restClient = RestClient(dio);
    return this;
  }

*/

  Future<bool> addProductService(Map<String, dynamic> body) async {
    try {
      Response response = await connect().post(
        "inventory",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);
        log("Parsed JSON: $jsonResponse");
        return true;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        return false;
      }
    } on DioException catch (err) {
      log("Error reporting feed ::: ${err.toString()}");
      throw Exception("Error reporting feed ::: ${err.toString()}");
    }
  }

  Future<Response> predictProduct(Map<String, dynamic> body) async {
    try {
      Response response = await connect().post(
        "predict_quantity",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);

        return response;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        return response;
      }
    } on DioException catch (err) {
      log("Error reporting feed ::: ${err.toString() ?? ''}");
      return Response(requestOptions: RequestOptions());
    }
  }

  Future<Response> makeSales(Map<String, dynamic> body) async {
    try {
      Response response = await connect().post(
        "make_sales",
        data: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);

        return response;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        return response;
      }
    } on DioException catch (err) {
      log("Error reporting feed ::: ${err.toString() ?? ''}");
      return Response(requestOptions: RequestOptions());
    }
  }

/*  Future<BaseResponse<List<ItemModel>>> getProductService() async {
    try {
      Response response = await connect().get(
        "inventory",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);
        log("Parsed JSON: $jsonResponse");
        return jsonResponse;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        return response;
      }
    } catch (err) {
      log("Error reporting feed ::: ${err.toString()}");
      throw Exception("Error reporting feed ::: ${err.toString()}");
    }
  }*/

  Future<BaseResponse<List<ItemModel>>> getProductService() async {
    try {
      Response response = await connect().get("inventory");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);

        // Parse the JSON into a BaseResponse containing a List of ItemModel
        var baseResponse = BaseResponse<List<ItemModel>>.fromJson(
            jsonResponse,
            (data) => (data as List)
                .map((item) => ItemModel.fromJson(item))
                .toList());

        log("Parsed JSON: $baseResponse");
        return baseResponse;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        throw Exception('Failed to fetch products: ${response.data}');
      }
    } on DioException catch (err) {
      log("Error reporting feed ::: ${err.toString()}");
      throw Exception("Error reporting feed ::: ${err.toString()}");
    }
  }


  Future<BaseResponse<List<SalesModel>>> getSalesService() async {
    try {
      Response response = await connect().get("make_sales");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.data);

        // Parse the JSON into a BaseResponse containing a List of ItemModel
        var baseResponse = BaseResponse<List<SalesModel>>.fromJson(
            jsonResponse,
            (data) => (data as List)
                .map((item) => SalesModel.fromJson(item))
                .toList());

        log("Parsed JSON: $baseResponse");
        return baseResponse;
      } else {
        log('Request failed with status: ${response.statusCode}');
        log('Request failed with: ${response.data}');
        throw Exception('Failed to fetch products: ${response.data}');
      }
    } on DioException catch (err) {
      log("Error reporting feed ::: ${err.toString()}");
      throw Exception("Error reporting feed ::: ${err.toString()}");
    }
  }

/*
  Future<BaseResponse<LoginResponse>> loginUser(LoginModel request) async {
    final response = await _restClient.login(request);
    if (response.status != 200) throw Exception(response.message);
    storageService.saveToken(response.data!.accessToken);
    log('  Login   ${response.data!.user.email!}');
    storageService.saveEmail(response.data!.user.email!);
    storageService.saveFirstName(response.data!.user.first_name!);
    storageService.saveLastName(response.data!.user.last_name!);
    storageService.savePhoneNumber(response.data!.user.phone_number!);
    return response;
  }

  Future<BaseResponse> registerUser(Map<String, dynamic> request) async {
    final response = await _restClient.register(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<BaseResponse> verifyAccount(PinModel request) async {
    final response = await _restClient.verifyAccount(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<BaseResponse> addCompany(Map<String, dynamic> request) async {
    final response = await _restClient.addCompany(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<BaseResponse> resendVerification(
      ResendVerificationModel request) async {
    final response = await _restClient.resendVerification(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<BaseResponse> sendRecoveryPin(ResendVerificationModel request) async {
    final response = await _restClient.sendPinRecovery(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<BaseResponse> sendRestPin(ResetPinModel request) async {
    final response = await _restClient.sendPinPin(request);
    BaseResponse mResponse = response;
    if (response.status != 200) throw Exception(response.message);
    return mResponse;
  }

  Future<List<CompanyModel>?> getAllCompany() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllCompany(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<bool> createCompany(String companyName) async {
    final token = storageService.getToken();
    final response =
        await _restClient.createCompany(token, {'name': companyName});
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<List<CustomerModel>?> getCustomer() async {
    final token = storageService.getToken();
    final response = await _restClient.getCustomers(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<CompanyModel?> getDefaultCompany() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchDefaultComany(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<List<PaymentTypeModel>?> getPaymentType() async {
    final token = storageService.getToken();
    final response = await _restClient.getPaymentTypes(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<TransactionModel?> getTransaction() async {
    final token = storageService.getToken();
    final response = await _restClient.getTransactionBalance(token);

    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<TransactionListModel?> getAllTransactionList() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllTransaction(token);
    if (response.status != 200) throw Exception(response.message);

    return response.data;
  }

  Future<TransactionListModel?> getAllTransactionListFilter(
      String value) async {
    final token = storageService.getToken();
    final response = await _restClient.getAllTransactionFilter(token, value);
    if (response.status != 200) throw Exception(response.message);

    return response.data;
  }

  Future<TransactionListModel?> getAllTransactionListFilterRange(
      String start, String end) async {
    final token = storageService.getToken();
    final response =
        await _restClient.getAllTransactionFilterRange(token, start, end);
    if (response.status != 200) throw Exception(response.message);

    return response.data;
  }

  Future<List<CustomerModel>?> getAllCustomer() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllCustomer(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<List<CategoryModel>?> getCategory() async {
    final token = storageService.getToken();
    final response = await _restClient.getCategory(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<bool> deleteSingleCustomer(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.deleteSingleCustomer(token, id);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> deleteMultipleCustomer(List<String> ids) async {
    final token = storageService.getToken();
    final response =
        await _restClient.deleteMultipleCustomer(token, {"ids": ids});

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> createCustomer(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createCustomer(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> updateCustomer(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateCustomer(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }
//Supplier

  Future<List<SupplierModel>?> getAllSupplier() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllSupplier(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<bool> deleteSingleSupplier(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.deleteSingleSupplier(token, id);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> deleteMultipleSupplier(List<String> ids) async {
    final token = storageService.getToken();
    final response =
        await _restClient.deleteMultipleSupplier(token, {"ids": ids});

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> createSupplier(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createSupplier(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> updateSupplier(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateSupplier(token, map);
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> recordMoneyIn(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.recordMoneyIn(token, map);
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> recordMoneyOut(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.recordMoneyOut(token, map);
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<DebtModel?> getAllDebt() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllDebt(token);
    if (response.status != 200) throw Exception(response.message);

    return response.data;
  }

  Future<ProductBaseModel?> getAllProducts(int page) async {
    final token = storageService.getToken();
    final response = await _restClient.getAllProducts(token, page);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<bool> deleteSingleProduct(List<String> id) async {
    final token = storageService.getToken();
    final response = await _restClient.deleteProduct(token, {"ids": id});

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> deleteSingleService(List<String> id) async {
    final token = storageService.getToken();
    final response = await _restClient.deleteService(token, {"ids": id});

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> createProduct(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createProduct(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> createService(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createService(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> updateService(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateService(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> updateProduct(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateProduct(token, map);
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<bool> addStock(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.addStock(token, map);

    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  //
  Future<DebtModel2?> getSpecificCustomerDebt(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.getSpecificCustomerDebt(token, id);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<DebtModel2?> getSpecificSupplierDebt(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.getSpecificSupplierDebt(token, id);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<bool> payDebt(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.payDebt(token, map);
    if (response.status != 200) throw Exception(response.message);
    return true;
  }

  Future<DebtHistoryModel?> getDebtHistory(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.getDebtHistory(token, id);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<AllEntriesModel?> getAllEntriesReport(String filter, int page) async {
    final token = storageService.getToken();
    final response = await _restClient.getAllEntryReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<PaymentModeReportModel?> getPaymentModeReport(String filter) async {
    final token = storageService.getToken();
    final response = await _restClient.getPaymentModeReport(token, filter);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<BaseResponse> changePin(Map<String, dynamic> body) async {
    final token = storageService.getToken();
    final response = await _restClient.changeUserPin(token, body);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> changePhoneNumber(Map<String, dynamic> body) async {
    final token = storageService.getToken();
    final response = await _restClient.changePhoneNumber(token, body);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> changeEmail(Map<String, String> map) async {
    final token = storageService.getToken();
    final response = await _restClient.changeEmail(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> confirmChangePhoneNumber(Map<String, String> map) async {
    final token = storageService.getToken();
    final response = await _restClient.confirmChangeNumber(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> createBankDetails(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createBank(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> updateBankDetails(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateBank(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> confirmChangeEmail(Map<String, String> map) async {
    final token = storageService.getToken();
    final response = await _restClient.confirmChangeEmail(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<List<FaqsModel>?> fetchFaqs() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchFaq(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<ExpenseReportModel?> getAllExpensesReport(
      String filter, int page) async {
    final token = storageService.getToken();
    final response =
        await _restClient.getAllExpensesReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<BaseResponse> defaultACompany(String id) async {
    final token = storageService.getToken();
    final response = await _restClient.setDefaultCompany(token, id);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> updateCompany(
      Map<String, dynamic> map, Stream<File?> logo) async {
    final token = storageService.getToken();
    final response = await _restClient.updateCompany(token, map, logo);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<BaseResponse> createCategory(Map<String, dynamic> map) async {
    final token = storageService.getToken();
    final response = await _restClient.createCategory(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }

  Future<List<ProductModel>?> fetchProducts() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchProducts(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<CustomerReportModel?> getCustomerReport(
      String filter, int page) async {
    final token = storageService.getToken();
    final response = await _restClient.getCustomerReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<SupplierReportModel?> getSupplierReport(
      String filter, int page) async {
    final token = storageService.getToken();
    final response = await _restClient.getSupplierReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<IncomeReportModel?> getIncomeReport(String filter, int page) async {
    final token = storageService.getToken();
    final response = await _restClient.getIncomeReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<DailyReportModel?> getDailyEntriesReport(
      String filter, int page) async {
    final token = storageService.getToken();
    final response =
        await _restClient.getDailyEntriesReport(token, filter, page);
    if (response.status != 200) throw Exception(response.message);

    return response.data!;
  }

  Future<List<ServiceModel>?> fetchServices() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchService(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  Future<List<BankModel>?> getAllBank() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchBank(token);
    if (response.status != 200) throw Exception(response.message);
    return response.data;
  }

  // updateUser(Map<String, String> map) {}

    Future<BaseResponse> updateUser(Map<String, String> map) async {
    final token = storageService.getToken();
    final response = await _restClient.updateCurrentUser(token, map);
    if (response.status != 200) throw Exception(response.message);
    return response;
  }
  */

// Future<AllEntriesModel?> getAllEntriesReport(String filter, int page) async {
//   final token = storageService.getToken();
//   final response = await _restClient.getAllEntryReport(token, filter, page);
//   if (response.status != 200) throw Exception(response.message);
//   return response.data!;
// }

// Future<PaymentModeReportModel?> getPaymentModeReport(String filter) async {
//   final token = storageService.getToken();
//   final response = await _restClient.getPaymentModeReport(token, filter);
//   if (response.status != 200) throw Exception(response.message);
//   return response.data;
// }
}

/*
  Future<ApiResponse<ResAuth>> registerUser(ReqRegister request) async {
    final response = await _restClient.register(request);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<ResAuth>> loginUser(ReqLogin request) async {
    final response = await _restClient.login(request);
    if (!response.success) throw Exception(response.message);
    _saveUserData(response.data!);
    return response;
  }

  Future<ApiResponse<ResAuth>> loginUserGmail(ReqGmailLogin request) async {
    final response = await _restClient.loginGmail(request);
    if (!response.success) throw Exception(response.message);
    _saveUserData(response.data!);
    return response;
  }

  Future<ApiResponse<Object>> contact(Contact request) async {
    final response = await _restClient.contact(request);
    if (!response.success) throw Exception(response.message);

    return response;
  }

  Future<ApiResponse<LogStatus>> getStatus() async {
    final token = storageService.getToken();
    final response = await _restClient.getRegStatus(token);
    if (!response.success) throw Exception(response.message);

    return response;
  }

  Future<ApiResponse<Object>> forgotPassword(String email) async {
    final Map<String, dynamic> reqBody = {'email': email};
    final response = await _restClient.forgotPassword(reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Booster>>> getUserPurchasedBoosters() async {
    final token = storageService.getToken();
    final response = await _restClient.getUserPurchasedBoosters(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Booster>>> getSingleUserPurchasedBoosters(
      String uuid) async {
    final token = storageService.getToken();
    final response =
        await _restClient.getSingleUserPurchasedBoosters(uuid, token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Booster>>> getAvailableBooster() async {
    final token = storageService.getToken();
    final response = await _restClient.getAvailableBooster(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Booster>>> getBoostersForTrade(
    Set<String> filters,
  ) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {"codes": filters.toList()};
    final response = await _restClient.getBoostersForTrade(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Offer>>> getBoosterOffers() async {
    final token = storageService.getToken();
    final response = await _restClient.getBoosterOffers(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<Offer>>> getBoosterSentOffers() async {
    final token = storageService.getToken();
    final response = await _restClient.getBoosterSentOffers(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> updateOffer(
    String boosterTradeUuid,
    int status,
  ) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {
      "booster_trade_uuid": boosterTradeUuid,
      "accept": status,
    };
    final response = await _restClient.updateOffer(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> makeBoostersTradeOffer(
    String boosterUuid,
    String ownerUuid,
    int coins,
    Set<String> offeredBoosterIds,
  ) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {
      "user_booster_purchase_uuid": boosterUuid,
      "booster_owner_uuid": ownerUuid,
      "offer_coins": coins,
      "booster_trade_exchange": offeredBoosterIds.toList(),
    };
    final response = await _restClient.makeBoostersTradeOffer(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<ResFixtures>> getAllFixtures() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllFixtures(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<ResFixtures>> getAllUpComingFixtures() async {
    final token = storageService.getToken();
    final response = await _restClient.getAllUpComingFixtures(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Profile>> getProfile() async {
    final token = storageService.getToken();
    print(token);
    final response = await _restClient.getProfile(token);
    if (!response.success) throw Exception(response.message);
    _saveProfileData(response.data!);
    return response;
  }

  Future<ApiResponse<Object>> predictFixture(ReqPredictions request) async {
    final token = storageService.getToken();
    final response = await _restClient.predictFixture(token, request);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> resetPredictFixture(
      ReqPredictions request) async {
    final token = storageService.getToken();
    final response = await _restClient.predictFixtureUpdate(token, request);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<ResClub>> fetchLeagus() async {
    final response = await _restClient.fetchLeagus();
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<ResFixtures>> fetchFixturesResults() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchFixturesResults(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<History>>> fetchHistory(int current) async {
    final token = storageService.getToken();
    final response = await _restClient.fetchHistory(token, current);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<History>>> fetchHistoryId(
      int current, String uuid) async {
    final token = storageService.getToken();
    final response = await _restClient.fetchHistoryId(token, uuid, current);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<LeagueResult>> fetchLeagueStanding() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchLeagueStanding(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<List<LeagueResult>>> fetchMyLeagues() async {
    final token = storageService.getToken();
    final response = await _restClient.fetchMyLeagues(token);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> joinLeague(String leagueCode) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {"code": leagueCode};
    final response = await _restClient.joinLeague(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<String>> createLeague(String leagueName) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {"name": leagueName};
    final response = await _restClient.createLeague(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> deleteLeague(String uuid) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {"league_uuid": uuid};
    final response = await _restClient.deleteLeague(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<ApiResponse<Object>> createTeam(
    String teamName,
    Color shirtColor,
    Color shortsColor,
    Color socksColor,
    int leagueId,
  ) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {
      "name": teamName,
      "shirt_color": shirtColor.value,
      "shorts_color": shortsColor.value,
      "socks_color": socksColor.value,
      "league_id": leagueId
    };
    final response = await _restClient.createTeam(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<bool> buyCoins(int coins) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {"coins": coins};
    final response = await _restClient.buyCoins(token, reqBody);
    if (!response.success) return false;
    return true;
  }

  Future<ApiResponse<Object>> buyBooster(String boosterUuid, int coins) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {
      "booster_uuid": boosterUuid,
      "booster_coins": coins,
    };
    final response = await _restClient.buyBooster(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<StripResponse> getIntent(String amount, String currency) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {
      "amount": amount,
      "currency": currency
    };

    final response = await _restClient.getintent(token, reqBody);
    if (response == null) throw Exception('An error occured');
    return response;
  }

   Future<bool> deleteAccount(String uId) async {
    final token = storageService.getToken();
    final Map<String, dynamic> reqBody = {

      "id": uId
    };

    final response = await _restClient.deleteAcount(token, reqBody);
    if (response == null) return false;
    return true;
  }

  Future<ApiResponse<Object>> spinnerGift(String gift, reward) async {
    final token = storageService.getToken();
    final String rewardKey;
    print('gift $gift');
    print('gift $reward');
    if (gift == 'coins') {
      rewardKey = 'coins';
    } else {
      rewardKey = 'booster_code';
    }

    final Map<String, dynamic> reqBody = {
      'gift': gift,
      rewardKey: reward,
    };
    final response = await _restClient.spinnerGift(token, reqBody);
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<bool> resetSpinner() async {
    final token = storageService.getToken();
    final response = await _restClient.resetSpinner(token);
    if (!response.success) false;
    return true;
  }

  Future<ApiResponse<List<Trade>>> confirmTrades() async {
    final response = await _restClient.confirmTrades();
    if (!response.success) throw Exception(response.message);
    return response;
  }

  Future<Advert?> getAdvert() async {
    final response = await _restClient.getAdvert();

    return response;
  }

  void _saveUserData(ResAuth data) async {
    storageService.saveToken(data.token);
    storageService.saveUser(data.user);
  }

  void _saveProfileData(Profile profile) {
    final team = profile.team;
    if (team != null) {
      storageService.saveShirtColor(Color(int.parse(team.shirtColor)));
      storageService.saveTeamName(team.name);
      print('i am teeeeeeeem ${team.name}');
    }
    storageService.saveRemainingPicks(profile.remainingPicks);
    final int coins;
    if (profile.coins is int) {
      coins = profile.coins;
    } else if (profile.coins is String) {
      coins = int.tryParse(profile.coins) ?? 0;
    } else {
      coins = 0;
    }
    storageService.saveCoins(coins);
  } */
