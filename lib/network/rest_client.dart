import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';



part 'rest_client.g.dart';

@RestApi(baseUrl: "https://inventory-app-9i9o.onrender.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  // @POST("/inventry")
  // Future<Map<String, dynamic>> login(@Body() Map<String, dynamic> request);

  /*
  @POST("/auth/register")
  Future<BaseResponse> register(@Body() Map<String, dynamic> request);

  @POST("/auth/verify-account")
  Future<BaseResponse> verifyAccount(@Body() PinModel request);

  @POST("/auth/add-company")
  Future<BaseResponse> addCompany(@Body() Map<String, dynamic> request);

  @POST("/auth/resend-verification-token")
  Future<BaseResponse> resendVerification(
      @Body() ResendVerificationModel request);

  @POST("/auth/send-reset-pin-token")
  Future<BaseResponse> sendPinRecovery(@Body() ResendVerificationModel request);

  @POST("/auth/reset-pin")
  Future<BaseResponse> sendPinPin(@Body() ResetPinModel request);

  @GET("/company/all")
  Future<BaseResponse<List<CompanyModel>>> getAllCompany(
    @Header('Authorization') token,
  );

  @POST("/company/create-company")
  Future<BaseResponse> createCompany(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @GET("/settings/fetch-customers")
  Future<BaseResponse<List<CustomerModel>>> getCustomers(
      @Header('Authorization') token);

  @GET("/utility/fetch-payment-types")
  Future<BaseResponse<List<PaymentTypeModel>>> getPaymentTypes(
      @Header('Authorization') token);

  @GET("/settings/fetch-category")
  Future<BaseResponse<List<CategoryModel>>> getCategory(
      @Header('Authorization') token);

  @GET("/transaction/fetch-balance")
  Future<BaseResponse<TransactionModel>> getTransactionBalance(
    @Header('Authorization') token,
  );

  @GET("/transaction/fetch-transactions")
  Future<BaseResponse<TransactionListModel>> getAllTransaction(
    @Header('Authorization') token,
  );

  @GET("/transaction/fetch-transactions?filter_by={filter}")
  Future<BaseResponse<TransactionListModel>> getAllTransactionFilter(
    @Header('Authorization') token,
    @Path('filter') String filter,
  );

  @GET(
      "/transaction/fetch-transactions?filter_by=date_range&start_date={start}&end_date={end}")
  Future<BaseResponse<TransactionListModel>> getAllTransactionFilterRange(
    @Header('Authorization') token,
    @Path('start') String start,
    @Path('end') String end,
  );

  //Setting

  @GET("/settings/fetch-customers")
  Future<BaseResponse<List<CustomerModel>>> getAllCustomer(
    @Header('Authorization') token,
  );

  @DELETE("/settings/delete-customer/{id}")
  Future<BaseResponse> deleteSingleCustomer(
    @Header('Authorization') String? token,
    @Path('id') String id,
  );

  @POST("/settings/delete-multiple-customer")
  Future<BaseResponse> deleteMultipleCustomer(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/create-customer")
  Future<BaseResponse> createCustomer(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/update-customer")
  Future<BaseResponse> updateCustomer(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  //Suplier

  @GET("/settings/fetch-suppliers")
  Future<BaseResponse<List<SupplierModel>>> getAllSupplier(
    @Header('Authorization') token,
  );

  @DELETE("/settings/delete-supplier/{id}")
  Future<BaseResponse> deleteSingleSupplier(
    @Header('Authorization') String? token,
    @Path('id') String id,
  );

  @POST("/settings/delete-multiple-supplier")
  Future<BaseResponse> deleteMultipleSupplier(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/create-supplier")
  Future<BaseResponse> createSupplier(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/update-supplier")
  Future<BaseResponse> updateSupplier(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  //Money In

  @POST("/transaction/money-in")
  Future<BaseResponse> recordMoneyIn(
      @Header('Authorization') token, @Body() Map<String, dynamic> model);

  //Money Out
  @POST("/transaction/money-out")
  Future<BaseResponse> recordMoneyOut(
      @Header('Authorization') token, @Body() Map<String, dynamic> model);

/*   //Money Out
  @POST("/transaction/money-out")
  Future<BaseResponse> recordMoneyOut(
      @Header('Authorization') token, @Body() Map<String, dynamic> model);
 */
  @GET("/debt/all")
  Future<BaseResponse<DebtModel>> getAllDebt(@Header('Authorization') token);

  @GET("/settings/fetch-banks")
  Future<BaseResponse<List<BankModel>>> fetchBank(
      @Header('Authorization') token);

  @GET("/inventory/fetch-all")
  Future<BaseResponse<ProductBaseModel>> getAllProducts(
    @Header('Authorization') token,
    @Query("page") int current,
  );

  @POST("/inventory/create-product")
  Future<BaseResponse> createProduct(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/create-service")
  Future<BaseResponse> createService(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/delete-product")
  Future<BaseResponse> deleteProduct(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/delete-service")
  Future<BaseResponse> deleteService(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/add-stock")
  Future<BaseResponse> addStock(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/update-product")
  Future<BaseResponse> updateProduct(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/inventory/update-service")
  Future<BaseResponse> updateService(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/create-bank")
  Future<BaseResponse> createBank(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/settings/update-bank")
  Future<BaseResponse> updateBank(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

// new one
  @GET("/debt/customer-debts/{id}")
  Future<BaseResponse<DebtModel2>> getSpecificCustomerDebt(
    @Header('Authorization') token,
    @Path('id') String id,
  );

  @GET("/debt/supplier-debts/{id}")
  Future<BaseResponse<DebtModel2>> getSpecificSupplierDebt(
    @Header('Authorization') token,
    @Path('id') String id,
  );

  @POST("/debt/record-payment")
  Future<BaseResponse> payDebt(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @GET("/debt/payment-history/{id}")
  Future<BaseResponse<DebtHistoryModel>> getDebtHistory(
    @Header('Authorization') token,
    @Path('id') String id,
  );

  @GET("/report/all-entry?filter_by={filter}&page={page}")
  Future<BaseResponse<AllEntriesModel>> getAllEntryReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @GET("/report/payment-mode?filter_by={filter}")
  Future<BaseResponse<PaymentModeReportModel>> getPaymentModeReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
  );

  @GET("/report/expenses?filter_by={filter}&page={page}")
  Future<BaseResponse<ExpenseReportModel>> getAllExpensesReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @POST("/user/change-phone-number")
  Future<BaseResponse> changePhoneNumber(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/user/change-pin")
  Future<BaseResponse> changeUserPin(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @POST("/user/change-email")
  Future<BaseResponse> changeEmail(
      @Header('Authorization') token, @Body() Map<String, dynamic> map);

  @POST("/user/confirm-change-phone-number")
  Future<BaseResponse> confirmChangeNumber(
      @Header('Authorization') token, @Body() Map<String, dynamic> map);

  @POST("/user/confirm-change-email")
  Future<BaseResponse> confirmChangeEmail(
      @Header('Authorization') token, @Body() Map<String, dynamic> map);

  @GET("/settings/fetch-faqs")
  Future<BaseResponse<List<FaqsModel>>> fetchFaq(
      @Header('Authorization') token);

  @GET("/company/default-company/{company_id}")
  Future<BaseResponse> setDefaultCompany(
    @Header('Authorization') token,
    @Path('company_id') String companyId,
  );

  @POST("/company/update-company")
  Future<BaseResponse> updateCompany(@Header('Authorization') token,
      @Body() Map<String, dynamic> body, Stream<File?> logo);

  @POST("/settings/create-category")
  Future<BaseResponse> createCategory(
      @Header('Authorization') token, @Body() Map<String, dynamic> body);

  @GET("/inventory/fetch-products")
  Future<BaseResponse<List<ProductModel>>> fetchProducts(
      @Header('Authorization') token);

  @GET("/inventory/fetch-services")
  Future<BaseResponse<List<ServiceModel>>> fetchService(
      @Header('Authorization') token);

  @GET("/company/fetch-default-company")
  Future<BaseResponse<CompanyModel>> fetchDefaultComany(
      @Header('Authorization') token);

  @GET("/report/customer?filter_by={filter}&page={page}")
  Future<BaseResponse<CustomerReportModel>> getCustomerReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @GET("/report/supplier?filter_by={filter}&page={page}")
  Future<BaseResponse<SupplierReportModel>> getSupplierReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @GET("/report/income?filter_by={filter}&page={page}")
  Future<BaseResponse<IncomeReportModel>> getIncomeReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @GET("/report/daily-entry?filter_by={filter}&page={page}")
  Future<BaseResponse<DailyReportModel>> getDailyEntriesReport(
    @Header('Authorization') token,
    @Path('filter') String filter,
    @Path('page') int page,
  );

  @POST("/user/update-user")
  Future<BaseResponse> updateCurrentUser(
      @Header('Authorization') token, @Body() Map<String, dynamic> map);

  */
  /* @POST("/register")
  Future<ApiResponse<ResAuth>> register(@Body() ReqRegister request);

  @POST("/login")
  Future<ApiResponse<ResAuth>> login(@Body() ReqLogin request);

  @POST("/social/login")
  Future<ApiResponse<ResAuth>> loginGmail(@Body() ReqGmailLogin request);

  @POST("/contact")
  Future<ApiResponse<Object>> contact(@Body() Contact request);

  @POST("/forgot-password")
  Future<ApiResponse<Object>> forgotPassword(
    @Body() Map<String, dynamic> reqBody,
  );

  @GET("/getUserPurchasedBoosters")
  Future<ApiResponse<List<Booster>>> getUserPurchasedBoosters(
    @Header('Authorization') token,
  );
  @GET("/getUserPurchasedBoosters/{uuid}")
  Future<ApiResponse<List<Booster>>> getSingleUserPurchasedBoosters(
    @Path('uuid') String uuid,
    @Header('Authorization') token,
  );

  //@GET("/getBoosters")
  @GET("/getBoosters")
  Future<ApiResponse<List<Booster>>> getAvailableBooster(
    @Header('Authorization') token,
  );

  @POST("/getBoostersForTrade")
  Future<ApiResponse<List<Booster>>> getBoostersForTrade(
    @Header('Authorization') token,
    @Body() Map<String, dynamic> reqBody,
  );

  @GET("/getBoostersTradeOffer")
  Future<ApiResponse<List<Offer>>> getBoosterOffers(
    @Header('Authorization') token,
  );

  @GET("/getMyOffers")
  Future<ApiResponse<List<Offer>>> getBoosterSentOffers(
    @Header('Authorization') token,
  );

  @POST("/acceptBoostersTradeOffer")
  Future<ApiResponse<Object>> updateOffer(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/makeBoostersTradeOffer")
  Future<ApiResponse<Object>> makeBoostersTradeOffer(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @GET("/fixtures/get-next")
  Future<ApiResponse<ResFixtures>> getAllFixtures(
    @Header('Authorization') token,
  );

  @GET("/fixtures/upcoming")
  Future<ApiResponse<ResFixtures>> getAllUpComingFixtures(
    @Header('Authorization') token,
  );

  @GET("/getProfile")
  Future<ApiResponse<Profile>> getProfile(
    @Header('Authorization') String? token,
  );

  @GET("/profile/check")
  Future<ApiResponse<LogStatus>> getRegStatus(
    @Header('Authorization') String? token,
  );

  @POST("/fixtures/save-prediction")
  Future<ApiResponse<Object>> predictFixture(
    @Header('Authorization') String? token,
    @Body() ReqPredictions request,
  );

  @POST("/fixtures/update-prediction")
  Future<ApiResponse<Object>> predictFixtureUpdate(
    @Header('Authorization') String? token,
    @Body() ReqPredictions request,
  );

  @GET("/getLeagues")
  Future<ApiResponse<ResClub>> fetchLeagus();

  @POST("/team/create")
  Future<ApiResponse<Object>> createTeam(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/purchasedCoins")
  Future<ApiResponse<Object>> buyCoins(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/purchasedBooster")
  Future<ApiResponse<Object>> buyBooster(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @GET("/fixtures/past-result")
  Future<ApiResponse<ResFixtures>> fetchFixturesResults(
    @Header('Authorization') String? token,
  );



  //@GET("/fixtures/history")
  @GET("/fixtures/history")
  Future<ApiResponse<List<History>>> fetchHistory(
    @Header('Authorization') String? token,
    @Query("current") int current,
  );

  @GET("/fixtures/history/{uuid}")
  Future<ApiResponse<List<History>>> fetchHistoryId(
    @Header('Authorization') String? token,
    @Path('uuid') String uuid,
    @Query("current") int current,
  );

  @GET("/result/league")
  Future<ApiResponse<LeagueResult>> fetchLeagueStanding(
    @Header('Authorization') String? token,
  );

  //@GET("/my-leagues")
  @GET("/my-leagues")
  Future<ApiResponse<List<LeagueResult>>> fetchMyLeagues(
    @Header('Authorization') String? token,
  );

  @POST("/join-league")
  Future<ApiResponse<Object>> joinLeague(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  //@POST("/create-league")
  @POST("/create-league")
  Future<ApiResponse<String>> createLeague(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/delete-league")
  Future<ApiResponse<Object>> deleteLeague(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/spinnerGift")
  Future<ApiResponse<Object>> spinnerGift(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );

  @POST("/reset/spinner")
  Future<ApiResponse<Object>> resetSpinner(
    @Header('Authorization') String? token,
  );
  @GET("/latest-confirmed-trades")
  Future<ApiResponse<List<Trade>>> confirmTrades();

    @GET("/advert")
  Future<Advert> getAdvert();

  @POST("/payment-intent")
  Future<StripResponse> getintent(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  );
  @POST("/delAccount")
  Future<ApiResponse<Object>> deleteAcount(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> reqBody,
  ); */
}
