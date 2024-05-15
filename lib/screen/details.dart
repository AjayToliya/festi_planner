import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color fontColor = Colors.black;
  Color backgroundColor = Colors.white;
  String backgroundImage = "";
  FontWeight fontWeight = FontWeight.w500;
  TextEditingController quoteController = TextEditingController();
  GlobalKey repaintBoundry = GlobalKey();
  double fontw = 5;
  double fonts = 18;
  late String selFont;
  String? selImage;
  double dx = 0;
  double dy = 0;
  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();
  @override
  void initState() {
    super.initState();
    selFont = fontFamilies[0];
  }

  void contentCopy() async {
    await Clipboard.setData(ClipboardData(text: quoteController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Quote copied"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> shareImage() async {
    RenderRepaintBoundary renderRepaintBoundary = repaintBoundry.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List fetchImage = byteData!.buffer.asUint8List();

    Directory directory = await getApplicationCacheDirectory();

    String path = directory.path;

    File file = File('$path.png');

    file.writeAsBytes(fetchImage);

    ShareExtend.share(file.path, "Image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        actions: [
          IconButton(
            onPressed: contentCopy,
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: shareImage,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: repaintBoundry,
              child: Card(
                child: Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: backgroundImage.isNotEmpty
                        ? DecorationImage(
                            image: AssetImage(backgroundImage),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: ClipRRect(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0),
                      ),
                      alignment: Alignment(dx, dy),
                      child: Text(
                        quoteController.text.isEmpty
                            ? "Add a message"
                            : quoteController.text,
                        style: GoogleFonts.getFont(
                          selFont,
                          textStyle: TextStyle(
                              color: fontColor,
                              fontWeight: fontWeight,
                              fontSize: fonts),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Font Weight"),
                      ],
                    ),
                  ),
                  Slider(
                    value: fontw,
                    min: 1,
                    max: 9,
                    divisions: 9,
                    onChanged: (val) {
                      setState(() {
                        if (val == 1) {
                          fontw = val;
                          fontWeight = FontWeight.w100;
                        } else if (val <= 2) {
                          fontw = val;
                          fontWeight = FontWeight.w200;
                        } else if (val <= 3) {
                          fontw = val;
                          fontWeight = FontWeight.w300;
                        } else if (val <= 4) {
                          fontw = val;
                          fontWeight = FontWeight.w400;
                        } else if (val <= 5) {
                          fontw = val;
                          fontWeight = FontWeight.w500;
                        } else if (val <= 6) {
                          fontw = val;
                          fontWeight = FontWeight.w600;
                        } else if (val <= 7) {
                          fontw = val;
                          fontWeight = FontWeight.w700;
                        } else if (val <= 8) {
                          fontw = val;
                          fontWeight = FontWeight.w800;
                        } else if (val == 9) {
                          fontw = val;
                          fontWeight = FontWeight.w900;
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Font Size"),
                      ],
                    ),
                  ),
                  Slider(
                    value: fonts,
                    min: 15,
                    max: 30,
                    onChanged: (val) {
                      setState(() {
                        fonts = val;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Alignment left-right"),
                      ],
                    ),
                  ),
                  Slider(
                    value: dx,
                    min: -0.95,
                    max: 0.95,
                    onChanged: (val) {
                      setState(() {
                        dx = val;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Alignment up-down"),
                      ],
                    ),
                  ),
                  Slider(
                    value: dy,
                    min: -0.95,
                    max: 0.95,
                    onChanged: (val) {
                      setState(() {
                        dy = val;
                      });
                    },
                  ),
                  InkWell(
                    focusColor: Colors.blue,
                    onTap: () {
                      openImagePicker();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Choose Background Image",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Choose Font Color",
                    style: TextStyle(fontSize: 18),
                  ),
                  Wrap(
                    children: List.generate(
                      Colors.primaries.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            fontColor = Colors.primaries[index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: 50,
                          width: 50,
                          color: Colors.primaries[index],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Choose Background Color",
                    style: TextStyle(fontSize: 18),
                  ),
                  Wrap(
                    children: List.generate(
                      Colors.primaries.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              backgroundImage = "";
                              backgroundColor = Colors.primaries[index];
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          height: 50,
                          width: 50,
                          color: Colors.primaries[index],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Change Font",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: fontFamilies
                                .map(
                                  (e) => (fontFamilies.indexOf(e) <= 20)
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selFont = e;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10, top: 10),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black87,
                                                width: 3,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Aa",
                                              style: GoogleFonts.getFont(
                                                e,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Quote"),
                content: TextField(
                  controller: quoteController,
                  decoration:
                      const InputDecoration(hintText: "Enter your quote"),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text("Done"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void backgroundColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Colors.accents.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // backgroundImage = null;
                      backgroundColor = color;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    width: 50,
                    height: 50,
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  List<String> customImages = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
    "assets/images/6.jpg",
  ];

  void openImagePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: customImages.map((imagePath) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    backgroundImage = imagePath;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Image.asset(
                  //   imagePath,
                  //   width: 80,
                  //   height: 80,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
