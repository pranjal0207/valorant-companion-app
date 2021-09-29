import 'package:flutter/material.dart';
import 'package:valorant_companion/models/agent_list_item.dart';
import 'package:valorant_companion/screens/agent_details.dart';
import 'package:valorant_companion/utils/api_handler.dart';

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
    super.initState();
    getAgents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: agents.length * 100,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: agents.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        String id = agents[index].id;
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AgentDetails(id: id)));
                      },
                      child: Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              agents[index].icon,
                              height: 50,
                              width: 50,
                            ),

                            const SizedBox(
                              width: 40,
                            ),

                            Expanded(
                              child: Text(
                                agents[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: null,
                              icon: Image.network(
                                agents[index].roleIcon
                              ),
                              tooltip: agents[index].role,
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