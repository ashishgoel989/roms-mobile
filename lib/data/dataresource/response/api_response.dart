
import 'package:get/get.dart';

class ApiResponse {
   late Response response;
   dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue,)
      : error = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        error = null;
}
