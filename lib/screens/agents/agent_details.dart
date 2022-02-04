import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_companion/models/agents/agent_data.dart';
import 'package:valorant_companion/utils/api_handler.dart';
import 'package:valorant_companion/widgets/agent_ability_data.dart';

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
  AudioPlayer audioPlayer = AudioPlayer();
  final apiHandler = APIHandler();

  late AgentData agent;

  bool loading = true;

  int selectedAbility = 0;

  bool isPlaying = false;

  List<String> abilities = ['Q', 'E', 'C', 'X'];

  void getAgentData() async{
    var temp = await apiHandler.getAgentData(widget.id);

    setState(() {
      agent = temp;
      loading = false;
    });

    await audioPlayer.setUrl(agent.voice[0].audio); // prepare the player with this audio but do not start playing
    await audioPlayer.setReleaseMode(ReleaseMode.STOP); 
  }

  showRoleData() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: const Color(0XFF1a1a1a),
          title: Row(
            children: [
              Image.network(
                agent.roleIcon,
                height: 20,
              ),

              const SizedBox(
                width: 10,
              ),

              Text(
                agent.role,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Valorant'
                ),
              ),
            ],
          ),

          content: Text(
            agent.roleDescription,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.justify,
          ),
        );
      }
    );
  } 

  releaseAuido() async{
    await audioPlayer.stop();
    await audioPlayer.release();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getAgentData();
  }

  @override
  void dispose() {
    super.dispose();
    releaseAuido();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Image.network(
                              agent.image,
                              height: 150,
                              scale: 1,
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  agent.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontFamily: 'Valorant'
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              GestureDetector(
                                onTap: (){
                                  showRoleData();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left : 20),
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
                                          fontSize: 20,
                                          fontFamily: 'Valorant'
                                        ),
                                      ),
                                    ],
                                  )
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
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            for(int i = 0; i < abilities.length; i++)
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedAbility = i;
                                });
                              },
                              child: Text(
                                abilities[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Valorant'
                                ),
                              ),
                              style: TextButton.styleFrom(
                                fixedSize: Size(((width - 20 - 15)/4), 20),
                                backgroundColor: (selectedAbility == i)? Colors.grey: null
                              ),
                            ),
                          ],
                        )
                      ),

                      AgentAbilityData(
                        abilityIcon: agent.abilities[selectedAbility].icon, 
                        abilityName: agent.abilities[selectedAbility].name,
                        abilityData: agent.abilities[selectedAbility].description
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 15, right: 15, top: 40),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              "AGENT VOICE LINE : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Valorant'
                              ),
                            ),

                            const SizedBox(
                              width: 20,
                            ),

                            IconButton(
                              onPressed: () async{
                                bool temp = !isPlaying;

                                if(isPlaying){
                                  await audioPlayer.pause();
                                }
                                else{
                                  await audioPlayer.resume();
                                }

                                setState(() {
                                  isPlaying = temp;
                                });
                              }, 
                              icon: (isPlaying)? const Icon(Icons.pause_circle_filled_rounded) : const Icon(Icons.play_circle_filled_rounded),
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                            ),
                          ],
                        )
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