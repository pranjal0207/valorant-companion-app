import 'package:flutter/material.dart';
import 'package:valorant_companion/models/maps/map_list_item.dart';
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
    super.initState();
    getMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
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
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AgentDetails(id: id)));
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
                                      fontSize: 20
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    maps[index].coordinates,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
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