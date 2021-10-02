import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_companion/models/maps/map_list_item.dart';
import 'package:valorant_companion/screens/maps/map_details.dart';
import 'package:valorant_companion/utils/api_handler.dart';

class AllMaps extends StatefulWidget {
  const AllMaps({ Key? key }) : super(key: key);

  @override
  _AllMapsState createState() => _AllMapsState();
}

class _AllMapsState extends State<AllMaps> {
  final apiHandler = APIHandler();

  List<MapListItem> maps = [];

  void getMaps() async{
    var temp = await apiHandler.getAllMaps();

    setState(() {
      maps = temp;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.only(left : 25, right: 20),
                child : const Text(
                  "MAPS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Valorant'
                  ),
                )
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: maps.length * 120,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: maps.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        String id = maps[index].id;
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MapDetails(id: id)));
                      },
                      child: Container(
                        height: 120,
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              maps[index].icon,
                              height: 100,
                              width: 160,
                            ),

                            const SizedBox(
                              width: 20,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    maps[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Valorant'
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    maps[index].coordinates,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Valorant'
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      )
                    );
                  }
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )
    );
  }
}