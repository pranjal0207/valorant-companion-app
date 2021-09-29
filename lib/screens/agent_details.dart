import 'package:flutter/material.dart';
import 'package:valorant_companion/models/agent_data.dart';
import 'package:valorant_companion/utils/api_handler.dart';

class AgentDetails extends StatefulWidget {
  final String id;
  const AgentDetails({
    required this.id,
    Key? key 
  }) : super(key: key);

  @override
  _AgentDetailsState createState() => _AgentDetailsState();
}

class _AgentDetailsState extends State<AgentDetails> {
  final apiHandler = APIHandler();
  late AgentData agent;

  bool loading = true;

  void getAgentData() async{
    var temp = await apiHandler.getAgentData(widget.id);

    setState(() {
      agent = temp;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAgentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                child: (loading)?
                  const Center(
                    child: CircularProgressIndicator(),
                  ):

                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            agent.image,
                            height: 150,
                            scale: 1,
                          ),

                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  agent.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              Container(
                                margin: const EdgeInsets.only(left : 15),
                                child: Row(
                                  children: <Widget>[
                                    Image.network(
                                      agent.roleIcon,
                                      height: 20,
                                      width: 20,
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      agent.role,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                      ),
                                    ),
                                  ],
                                )
                              )
                            ],
                          )
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 15, right: 15, top: 20),
                        child: Text(
                          agent.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}