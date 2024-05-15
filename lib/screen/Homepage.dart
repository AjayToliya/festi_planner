import 'package:flutter/material.dart';
import '../utils/String.dart';
import '../utils/data.dart';
import '../utils/fac.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.festivals = festivalList.map((e) => Festivals.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Festivals",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: Global.festivals
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('details');
                        },
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(e.image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
