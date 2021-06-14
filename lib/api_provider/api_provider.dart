import 'package:http/http.dart' as http;

class ApiProvider {
  Future<http.Response> getColorInfo() async {
    http.Response response = await http.get(
      Uri.parse("https://www.thecolorapi.com/id?hex=FFFFFF&format=json"),
    );
    return response;
  }
}
