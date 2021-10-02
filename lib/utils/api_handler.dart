import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:valorant_companion/models/agents/agent_data.dart';
import 'package:valorant_companion/models/agents/agent_list_item.dart';
import 'package:valorant_companion/models/maps/map_data.dart';
import 'package:valorant_companion/models/maps/map_list_item.dart';
import 'package:valorant_companion/models/weapons/weapon_data.dart';
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

  getWeaponData(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/weapons/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var data = await json["data"];
    var shopInfo = await json["data"]["shopData"];
    var stats = await json["data"]["weaponStats"];
    var ads = await json["data"]["weaponStats"]["adsStats"];
    var ranges = await json["data"]["weaponStats"]["damageRanges"];

    List<DamageRange> damageRanges = [];
 
    for (int i = 0; i < ranges.length; i++){
      DamageRange range = DamageRange(
        rangeStarts: ranges[i]["rangeStartMeters"], 
        rangeEnds: ranges[i]["rangeEndMeters"], 
        bodyDamage: double.parse(ranges[i]["bodyDamage"].toString()), 
        headDamage: double.parse(ranges[i]["headDamage"].toString()), 
        legDamage: double.parse(ranges[i]["legDamage"].toString())
      );

      damageRanges.add(range);
    }


    ADSStats adsStats = ADSStats(
      ads: (ads != null)? true : false,
      zoom: (ads != null)? double.parse(ads["zoomMultiplier"].toString()): 0, 
      fireRate: (ads != null)? double.parse(ads["fireRate"].toString()): 0, 
      runSpeedMultiplier: (ads != null)? double.parse(ads["runSpeedMultiplier"].toString()): 0,
      burstCount: (ads != null)? ads["burstCount"]: 0
    );

    WeaponData weapon = WeaponData(
      name: data["displayName"], 
      icon: data["displayIcon"], 
      cost: shopInfo["cost"], 
      category: shopInfo["category"],
      fireRate: double.parse(stats["fireRate"].toString()), 
      equipSpeed: double.parse(stats["equipTimeSeconds"].toString()), 
      firstShotSpreadADS: (ads != null)? double.parse(ads["firstBulletAccuracy"].toString()): 0, 
      firstShotSpreadHIP: double.parse(stats["firstBulletAccuracy"].toString()), 
      magazine: double.parse(stats["magazineSize"].toString()), 
      reloadSpeed: double.parse(stats["reloadTimeSeconds"].toString()), 
      runSpeed: double.parse(stats["runSpeedMultiplier"].toString()),
      damageRanges: damageRanges,
      adsStats: adsStats
    );

    return weapon;
  }

  getAllMaps() async{
    var uri = Uri.https("valorant-api.com", "v1/maps");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);

    var data = await json["data"];

    List<MapListItem> maps = [];

    for(int i = 0; i < data.length; i++){
      if(data[i]["uuid"] == "ee613ee9-28b7-4beb-9666-08db13bb2244"){
        continue;
      }

      MapListItem map = MapListItem(
        id: data[i]["uuid"], 
        name: data[i]["displayName"], 
        icon: data[i]["splash"],
        coordinates: data[i]["coordinates"]
      );

      maps.add(map);
    }

    return maps;
  }

  getMapData(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/maps/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body); 

    var data = await json["data"];

    MapData map = MapData(
      mapLayout: data["displayIcon"]
    );

    return map;
  }
}