import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devcolorguide/bloc/colorsBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants/textStyle.dart';
import 'models/thecolors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color currentColor = Color(0xFFFFF4CE);

  FirebaseFirestore firestorReference = FirebaseFirestore.instance;
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Developer's Color Guide",
          style: whiteS30W700Underlined,
        ),
        centerTitle: false,
      ),
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
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
              colorPickerWidth: MediaQuery.of(context).size.width / 2.5,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          StreamBuilder<TheColor>(
              stream: colorBloc.theColor,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20.0),
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width / 2.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: currentColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                snapshot.data!.name!.value ??
                                    "No Name Assigned",
                                style: whiteS20W700,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width / 2.1,
                              color: currentColor,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(
                              height: 1,
                              thickness: 2,
                              color: currentColor,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Your Color",
                                    style: whiteS20W700,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.30),
                                    ),
                                    child: TextFormField(
                                      controller: _textEditingController,
                                      onChanged: (colorString) {
                                        if (_textEditingController
                                                .text.length <=
                                            6) {
                                          colorBloc.fetchColorInfo(
                                              _textEditingController.text);
                                        }
                                      },
                                      style: whiteS20W700,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.color_lens,
                                          color: Colors.white,
                                        ),
                                        prefixText: "#",
                                        prefixStyle: whiteS20W700,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: currentColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width / 2.1,
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: supportedLanguage.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            selectedSupportLanguageIndex ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedSupportLanguageIndex =
                                                index;
                                          });
                                        },
                                        child: Text(
                                          supportedLanguage[index],
                                          style: selectedSupportLanguageIndex ==
                                                  index
                                              ? blackS15W700
                                              : whiteS15W700,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Divider(
                              color: currentColor,
                              thickness: 2,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DartClipBoardView(
                                    currentColorCamelCaseName: snapshot
                                        .data!.name!.value!
                                        .replaceFirst(
                                            snapshot.data!.name!.value![0],
                                            snapshot.data!.name!.value![0]
                                                .toLowerCase())
                                        .replaceAll(" ", ""),
                                    currentColor: currentColor,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      FlutterClipboard.copy(
                                              "const Color ${snapshot.data!.name!.value!.replaceFirst(snapshot.data!.name!.value![0], snapshot.data!.name!.value![0].toLowerCase()).replaceAll(" ", "")} =  Color(0xFF${currentColor.toString().substring(10, 16).toUpperCase()});")
                                          .then((value) {
                                        FToast fToast = FToast();
                                        fToast.init(context);
                                        Widget toast = Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 12.0,
                                          ),
                                          margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            color: Colors.black,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
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
                                          gravity: ToastGravity.BOTTOM,
                                          toastDuration: Duration(seconds: 2),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox();
              }),
        ],
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
    return Row(
      children: [
        Text(
          " const ",
          style: havelockBlueS15W700,
        ),
        Text(
          " Color ",
          style: whiteS15W700,
        ),
        Text(
          currentColorCamelCaseName,
          style: whiteS15W700,
        ),
        Text(
          " = ",
          style: whiteS15W700,
        ),
        Text(
          " Color(",
          style: whiteS15W700,
        ),
        Text(
          "0xFF${currentColor.toString().substring(10, 16).toUpperCase()}",
          style: corianderS15W700,
        ),
        Text(
          "); ",
          style: whiteS15W700,
        ),
      ],
    );
  }
}
