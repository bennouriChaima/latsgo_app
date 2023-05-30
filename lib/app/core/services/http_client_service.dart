import 'dart:async';
import 'dart:io';

import 'package:urban_app/app/core/constants/end_points_constants.dart';
import 'package:urban_app/app/core/constants/storage_keys_constants.dart';
import 'package:urban_app/app/core/services/local_storage_service.dart';
import 'package:urban_app/app/models/api_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class HttpClientService {
  static final String _baseUrl = Uri.encodeFull(EndPointsConstants.baseUrl);

  static Future<ApiResponse?> sendRequest({
    required String endPoint,
    required HttpRequestTypes requestType,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? header,
    Function? onLoading,
    Function(ApiResponse response)? onSuccess,
    Function(String errorsMessage, ApiResponse response)? onError,
    Function? onFinal,
    Function(int sent, int total)? onProgress,
  }) async {
    ApiResponse? response;
    if (onLoading != null) onLoading();
    try {
      if (requestType == HttpRequestTypes.post) {
        response = await post(endPoint, formData: data, header: header, onProgress: onProgress);
      } else if (requestType == HttpRequestTypes.get) {
        response = await get(
          endPoint,
          queryParameters: queryParameters,
          header: header,
        );
      } else if (requestType == HttpRequestTypes.delete) {
        response = await delete(endPoint, formData: data, header: header);
      } else if (requestType == HttpRequestTypes.put) {
        response = await put(endPoint, formData: data, header: header);
      }
      if ((response?.statusCode == 200 || response?.statusCode == 201) && response?.successFlag == true) {
        print(response?.body);
        if (onSuccess != null) onSuccess(response!);
        return response;
      } else {
        onError!(convertResponseErrorsToString(response!), response);
        print('error in api:::: ${response.toString()}');

        if (response.statusCode == 401) {
          //Get.find<UserController>().clearUser();
        }
        //showToast(context, response?.message);
      }
    } catch (error) {
      print('exception in converting to model::: ${error.toString()}');
      //showToast(context, AppConstants.ApiResponseMessages[2]);
    } finally {
      if (onFinal != null) onFinal();
    }
  }

  static Future<dio.BaseOptions> getBaseOptions({Map<String, String>? header, int? timeout}) async {
    header ??= <String, String>{};
    header.addAll({
      "Accept": "application/json",
      "Content-type": "application/json",
      "Accept-Language": Get.locale?.languageCode ?? "ar",
      "Authorization":
          "Bearer ${await LocalStorageService.loadData(key: StorageKeysConstants.userToken, type: DataTypes.string)}"
    });
    return dio.BaseOptions(
      baseUrl: Uri.encodeFull(_baseUrl),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: header,
    );
  }

  static Future<ApiResponse> get(String endPoint,
      {int? timeout, Map<String, String>? header, Map<String, dynamic>? queryParameters}) async {
    try {
      dio.Response response = await dio.Dio(
        await getBaseOptions(timeout: timeout, header: header),
      ).get(
        Uri.encodeFull(endPoint),
        queryParameters: queryParameters,
      );
      //print(response);
      return _buildOut(response);
    } catch (_error) {
      //print(_error.toString());
      dio.DioError error = _error as dio.DioError;
      if (error.response == null) {
        return _errorNoResponse(error);
      } else {
        return _buildOut(error.response!);
      }
    }
  }

  static Future<ApiResponse> post(String endPoint,
      {dynamic formData,
      Map<String, String>? header,
      int? timeout,
      Map<String, String>? queryParameters,
      Function(int sent, int total)? onProgress}) async {
    try {
      dio.Response response = await dio.Dio(
        await getBaseOptions(
          timeout: timeout,
          header: header,
        ),
      ).post(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
        onSendProgress: onProgress,
      );
      return _buildOut(response);
    } catch (_error) {
      print(_error.toString());

      dio.DioError error = _error as dio.DioError;
      if (error.response == null) {
        return _errorNoResponse(error);
      } else {
        print(_error.response);
        return _buildOut(error.response!);
      }
    }
  }

  static Future<ApiResponse> delete(String endPoint,
      {dynamic formData, Map<String, String>? header, int? timeout, Map<String, String>? queryParameters}) async {
    try {
      dio.Response response = await dio.Dio(
        await getBaseOptions(
          timeout: timeout,
          header: header,
        ),
      ).delete(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
      );
      return _buildOut(response);
    } catch (_error) {
      dio.DioError error = _error as dio.DioError;
      if (error.response == null) {
        return _errorNoResponse(error);
      } else {
        return _buildOut(error.response!);
      }
    }
  }

  static Future<ApiResponse> put(String endPoint,
      {dynamic formData, Map<String, String>? header, int? timeout, Map<String, String>? queryParameters}) async {
    try {
      dio.Response response = await dio.Dio(
        await getBaseOptions(
          timeout: timeout,
          header: header,
        ),
      ).put(
        Uri.encodeFull(endPoint),
        data: formData,
        queryParameters: queryParameters,
      );
      return _buildOut(response);
    } catch (_error) {
      dio.DioError error = _error as dio.DioError;
      if (error.response == null) {
        return _errorNoResponse(error);
      } else {
        return _buildOut(error.response!);
      }
    }
  }

  static ApiResponse _buildOut(dio.Response response) {
    ApiResponse apiResponse = ApiResponse();
    if (response.statusCode == 200 || response.statusCode == 201) {
      apiResponse.statusCode = response.statusCode;
      apiResponse.successFlag = response.data['success'];
      apiResponse.message = response.data['message'] == null || response.data['message'] == ""
          ? "operationSuccess".tr
          : response.data['message'];
      apiResponse.body = response.data['Result'] ?? response.data['result'];
    } else if (response.statusCode == 422) {
      if (response.data is Map<String, dynamic>) {
        apiResponse.statusCode = response.statusCode;
        apiResponse.successFlag = response.data['success'];
        apiResponse.message = response.data['message'];
        apiResponse.error = response.data['errors'];
      } else {
        apiResponse.statusCode = response.statusCode;
        apiResponse.message = response.data.toString();
      }
    } else if (response.statusCode == 403) {
      apiResponse.statusCode = response.statusCode;
      apiResponse.message = response.data["message"];
      apiResponse.message = response.data["errors"];
    } else if (response.statusCode == 401) {
      apiResponse.statusCode = response.statusCode;
      apiResponse.message = "Unauthorized";
    } else {
      apiResponse.statusCode = response.statusCode;
      apiResponse.message = "There is an error";
    }

    return apiResponse;
  }

  static ApiResponse _errorNoResponse(dio.DioError error) {
    if (error.error is SocketException) {
      return ApiResponse(statusCode: 502, message: "تأكد من إتصالك بالإنترنت");
    } else if (error is TimeoutException) {
      return ApiResponse(statusCode: 504, message: "Request execution time reached the limit");
    } else {
      return ApiResponse(statusCode: 500, message: error.toString());
    }
  }

  static String convertResponseErrorsToString(ApiResponse response) {
    String errorsMessage = '';
    Map<String, dynamic> messagesList = response.message;
    messagesList.forEach((key, value) {
      if (value is List) {
        for (var item in value) {
          errorsMessage += '$item \n';
        }
      } else {
        errorsMessage += '$value \n';
      }
    });
    return errorsMessage;
  }
}

enum HttpRequestTypes {
  post,
  delete,
  put,
  get,
  patch,
}
