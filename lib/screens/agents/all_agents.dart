import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/agents/agent_list_item.dart';
import '/utils/api_handler.dart';
import '/widgets/agent_tile.dart';

class AllAgents extends StatefulWidget {
  const AllAgents({ Key? key }) : super(key: key);

  @override
  _AllAgentsState createState() => _AllAgentsState();
}

class _AllAgentsState extends State<AllAgents> {
  final apiHandler = APIHandler();

  List<AgentListItem> agents = [];

  void getAgents() async{
    var temp = await apiHandler.getAllAgentsData();

    setState(() {
      agents = temp;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getAgents();
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
                  "AGENTS",
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
                height: agents.length * 100,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: agents.length,
                  itemBuilder: (context, index){
                    return AgentTile(agents: agents[index]);
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