import 'package:http/http.dart' as http;

class ApiProvider {
  Future<http.Response> getColorInfo(String colorText) async {
    http.Response response = await http.get(
      Uri.parse("https://www.thecolorapi.com/id?hex=$colorText&format=json"),
    );
    return response;
  }
}
