import 'package:devcolorguide/api_provider/api_provider.dart';
import 'package:devcolorguide/models/thecolors.dart';
import 'package:http/http.dart';
import 'package:rxdart/subjects.dart';

class ColorBloc {
  ApiProvider _apiProvider = ApiProvider();
  PublishSubject<TheColor> colorFetcher = PublishSubject<TheColor>();

  Stream<TheColor> get theColor => colorFetcher.stream;

  fetchColorInfo() async {
    Response response = await _apiProvider.getColorInfo();
    if (response.statusCode == 200) {
      TheColor theColor = theColorFromJson(response.body);
      colorFetcher.sink.add(theColor);
    }
  }

  void dispose() {
    colorFetcher.close();
  }
}

final colorBloc = ColorBloc();
