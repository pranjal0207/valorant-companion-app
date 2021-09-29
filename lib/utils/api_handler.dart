import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:valorant_companion/models/agents/agent_data.dart';
import 'package:valorant_companion/models/agents/agent_list_item.dart';
import 'package:valorant_companion/models/weapons/weapon_list_item.dart';

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

    var data = await json["data"];
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
      name: data['displayName'], 
      description: data['description'], 
      image: data['bustPortrait'], 
      role: data['role']['displayName'], 
      roleDescription: data['role']['description'], 
      roleIcon: data['role']['displayIcon'], 
      abilities: allAbilities
    );

    return agent;
  }

  getAllWeapons() async{
    var uri = Uri.https("valorant-api.com", "v1/weapons");
    var response = await http.get(uri);
    var json = jsonDecode(response.body); 

    var data = await json["data"];

    List<WeapontListItem> weapons = [];

    for(int i = 0; i < data.length; i++){
      WeapontListItem weapon = WeapontListItem(
        name: data[i]["displayName"], 
        icon: data[i]["displayIcon"], 
        id: data[i]["uuid"]
      );

      weapons.add(weapon);
    }

    return weapons;
  }
}