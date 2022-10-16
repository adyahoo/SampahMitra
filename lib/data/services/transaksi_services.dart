part of 'services.dart';

class TransaksiServices {
  static Future<ApiReturnValue<List<TransaksiModel>>> getAllTransaction(
      {http.Client? client}) async {
    client = http.Client();

    String url = baseUrl + '/penjemputan/get-penjemputan';
    String? token = await getUserToken();

    var response = await client
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

    var data = jsonDecode(response.body);

    if (data['success'] != true) {
      return ApiReturnValue(status: false, message: data['message']);
    }

    List<TransaksiModel> transaksis = data['request_penjemputan'] != null
        ? (data['request_penjemputan'] as Iterable)
            .map((e) => TransaksiModel.fromJson(e))
            .toList()
        : [];

    return ApiReturnValue(
        status: true, value: transaksis, message: data['message']);
  }

  static Future<ApiReturnValue<TransaksiModel>> getDetailTransaction(int id,
      {http.Client? client}) async {
    client = http.Client();

    String url = baseUrl + '/penjemputan/detail?id=$id';
    String? token = await getUserToken();

    var response = await client
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

    var data = jsonDecode(response.body);

    if (data['success'] != true) {
      return ApiReturnValue(status: false, message: data['message']);
    }

    TransaksiModel transaksi =
        TransaksiModel.fromJson(data['request_penjemputan']);

    return ApiReturnValue(
        status: true, value: transaksi, message: data['message']);
  }

  static Future<ApiReturnValue<String>> confirmRequest(int id,
      {http.Client? client}) async {
    client = http.Client();

    String url = baseUrl + '/penjemputan/konfirmasi?id=$id';
    String? token = await getUserToken();

    var response = await client
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

    var data = jsonDecode(response.body);

    if (data['success'] != true) {
      return ApiReturnValue(status: false, message: data['message']);
    }

    return ApiReturnValue(status: true, message: data['message']);
  }

  static Future<ApiReturnValue<String>> declineRequest(int id,
      {http.Client? client}) async {
    client = http.Client();

    String url = baseUrl + '/penjemputan/tolak?id=$id';
    String? token = await getUserToken();

    var response = await client
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

    var data = jsonDecode(response.body);

    if (data['success'] != true) {
      return ApiReturnValue(status: false, message: data['message']);
    }

    return ApiReturnValue(status: true, message: data['message']);
  }
}
