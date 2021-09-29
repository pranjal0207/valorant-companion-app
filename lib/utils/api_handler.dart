import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:valorant_companion/models/agent_data.dart';
import 'package:valorant_companion/models/agent_list_item.dart';

class APIHandler{

  getAllAgentsData() async{
    var uri = Uri.https("valorant-api.com", "v1/agents");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    List<AgentListItem> agents = [];

    for(int i = 0; i < json["data"].length; i++) {
      if(i == 5){
        continue;
      }

      AgentListItem agent = AgentListItem(
        name: json["data"][i]['displayName'], 
        icon: json["data"][i]['displayIconSmall'], 
        id: json["data"][i]['uuid'],
        role: json["data"][i]['role']['displayName'],
        roleIcon: json["data"][i]['role']['displayIcon']
      );

      agents.add(agent);
    }

    return agents;
  }

  getAgentData(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/agents/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var abilities = await json["data"]["abilities"];

    List<AbilityData> allAbilities = [];

    for(int i = 0; i < abilities.length; i++){
      AbilityData ability = AbilityData(
        name: abilities[i]['displayName'], 
        description: abilities[i]['description'], 
        icon: abilities[i]['displayIcon']
      );

      allAbilities.add(ability);
    }

    AgentData agent = AgentData(
      name: json["data"]['displayName'], 
      description: json["data"]['description'], 
      image: json["data"]['bustPortrait'], 
      role: json["data"]['role']['displayName'], 
      roleDescription: json["data"]['role']['description'], 
      roleIcon: json["data"]['role']['displayIcon'], 
      abilities: allAbilities
    );

    return agent;
  }
}