
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sanaa_fi_saas/data/api/api_client.dart';
import 'package:sanaa_fi_saas/utils/app_constants.dart';

class AddMoneyRepo {
  final ApiClient apiClient;
  AddMoneyRepo({required this.apiClient});

  Future<Response>  addMoneyApi({required double amount, required String paymentMethod}) async {
    Map<String, Object> body = {
      'amount': '$amount',
      'payment_method': paymentMethod,
    };
    return await apiClient.postData(AppConstants.customerAddMoney,body);
  }



}