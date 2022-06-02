import 'package:clipboard/clipboard.dart';
import 'package:devcolorguide/models/thecolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/colorsBloc.dart';
import '../../constants/textStyle.dart';

class ExtensionHomepage extends StatefulWidget {
  const ExtensionHomepage({Key? key}) : super(key: key);

  @override
  State<ExtensionHomepage> createState() => _ExtensionHomepageState();
}

class _ExtensionHomepageState extends State<ExtensionHomepage> {
  Color currentColor = Color(0xFFFFF4CE);
  List<String> supportedLanguage = ["Dart"];
  TextEditingController _textEditingController = TextEditingController();
  int selectedSupportLanguageIndex = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController.text =
        "${currentColor.toString().substring(10, 16).toUpperCase()}";
    colorBloc.fetchColorInfo(_textEditingController.text);

    _textEditingController.addListener(() {
      try {
        if (_textEditingController.text.length <= 6) {
          setState(() {
            colorBloc.fetchColorInfo(_textEditingController.text);
            currentColor = Color(
                int.parse("0xFF${_textEditingController.text.toUpperCase()}"));
          });
        }
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              height: 350,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              padding: EdgeInsets.all(20),
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: (selectedColor) {
                  setState(() {
                    currentColor = selectedColor;
                    _textEditingController.text =
                        "${currentColor.toString().substring(10, 16).toUpperCase()}";
                  });
                },
                portraitOnly: true,
                pickerAreaHeightPercent: 0.7,
                colorPickerWidth: 200,
                enableAlpha: true,
                displayThumbColor: true,
                paletteType: PaletteType.hsv,
                pickerAreaBorderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _textEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixText: '#',
                          prefixIcon: Icon(
                            Icons.color_lens_outlined,
                            color: Colors.redAccent,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.info,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              FToast fToast = FToast();
                              fToast.init(context);
                              Widget toast = Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.color_lens_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                      "Enter color code here!",
                                      style: whiteS20W700,
                                    ),
                                  ],
                                ),
                              );
                              fToast.showToast(
                                child: toast,
                                gravity: ToastGravity.TOP_RIGHT,
                                toastDuration: Duration(seconds: 2),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: currentColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            StreamBuilder<TheColor>(
                              stream: colorBloc.theColor,
                              builder:
                                  ((context, AsyncSnapshot<TheColor> snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                } else
                                  return Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data?.name?.value}",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            DartClipBoardView(
                                              currentColorCamelCaseName:
                                                  snapshot.data!.name!.value!
                                                      .replaceFirst(
                                                          snapshot.data!.name!
                                                              .value![0],
                                                          snapshot.data!.name!
                                                              .value![0]
                                                              .toLowerCase())
                                                      .replaceAll(" ", ""),
                                              currentColor: currentColor,
                                            ),
                                            Spacer(),
                                            IconButton(
                                              icon: Icon(
                                                Icons.copy,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {});
                                                FlutterClipboard.copy(
                                                        "const Color ${snapshot.data!.name!.value!.replaceFirst(snapshot.data!.name!.value![0], snapshot.data!.name!.value![0].toLowerCase()).replaceAll(" ", "")} =  Color(0xFF${currentColor.toString().substring(10, 16).toUpperCase()});")
                                                    .then((value) {
                                                  FToast fToast = FToast();
                                                  fToast.init(context);
                                                  Widget toast = Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 12.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      color: Colors.black,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 12.0,
                                                        ),
                                                        Text(
                                                          "Copied Successfully",
                                                          style: whiteS20W700,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  fToast.showToast(
                                                    child: toast,
                                                    gravity: ToastGravity
                                                        .BOTTOM_RIGHT,
                                                    toastDuration:
                                                        Duration(seconds: 2),
                                                  );
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                              }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DartClipBoardView extends StatelessWidget {
  const DartClipBoardView({
    Key? key,
    required this.currentColorCamelCaseName,
    required this.currentColor,
  }) : super(key: key);

  final String currentColorCamelCaseName;
  final Color currentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Wrap(
        children: [
          Text(
            " const ",
            style: havelockBlueS15W700,
          ),
          Text(
            " Color ",
            style: whiteS15W700.copyWith(color: Colors.blueGrey),
          ),
          Text(
            currentColorCamelCaseName,
            style: whiteS15W700.copyWith(color: Colors.blueGrey),
          ),
          Text(
            " = ",
            style: whiteS15W700.copyWith(color: Colors.blueGrey),
          ),
          Text(
            " Color(",
            style: whiteS15W700.copyWith(color: Colors.blueGrey),
          ),
          Text(
            "0xFF${currentColor.toString().substring(10, 16).toUpperCase()}",
            style: corianderS15W700,
          ),
          Text(
            "); ",
            style: whiteS15W700.copyWith(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
