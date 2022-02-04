import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import '../../models/maps/map_data.dart';
import '../../utils/api_handler.dart';

class MapDetails extends StatefulWidget {
  final String id;

  const MapDetails({ 
    required this.id,
    Key? key 
  }) : super(key: key);

  @override
  _MapDetailsState createState() => _MapDetailsState();
}

class _MapDetailsState extends State<MapDetails> {
  final apiHandler = APIHandler();
  late MapData map;

  bool loaded = false;

  getMapData() async{
    var temp = await apiHandler.getMapData(widget.id);

    setState(() {
      map = temp;
      loaded = true;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
    getMapData();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if(loaded){
      return Scaffold(
        body: PinchZoom(
          child: RotatedBox(
            quarterTurns: 6,
            child: Image.network(
              map.mapLayout,
              height: width,
              width: height
            )
          )
        )
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}