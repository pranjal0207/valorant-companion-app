import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/agents/agent_data.dart';
import '../models/agents/agent_list_item.dart';
import '../models/maps/map_data.dart';
import '../models/maps/map_list_item.dart';
import '../models/weapons/weapon_data.dart';
import '../models/weapons/weapon_list_item.dart';
import '../models/weapons/weapon_skins.dart';

class APIHandler{
  getAllAgentsData(String selectedRole) async{
    var uri = Uri.https("valorant-api.com", "v1/agents");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    List<AgentListItem> agents = [];

    for(int i = 0; i < json["data"].length; i++) {
      if(i == 6){
        continue;
      }

      AgentListItem agent = AgentListItem(
        name: json["data"][i]['displayName'], 
        icon: json["data"][i]['displayIconSmall'], 
        id: json["data"][i]['uuid'],
        role: json["data"][i]['role']['displayName'],
        roleIcon: json["data"][i]['role']['displayIcon']
      );
      
      if(selectedRole == "All Agents") {
        agents.add(agent);
      }

      else{
        if(agent.role.toLowerCase() == selectedRole.toLowerCase()) {
          agents.add(agent);
        }
      }
    }

    agents.sort(((a, b) => a.role.compareTo(b.role)));

    return agents;
  }

  getAgentData(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/agents/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var data = await json["data"];
    var abilities = await json["data"]["abilities"];
    var voice = await json["data"]["voiceLine"];

    List<AbilityData> allAbilities = [];
    List<AgentVoice> agentVoices = [];

    for(int i = 0; i < abilities.length; i++){
      if(i == 4){
        continue;
      }
      AbilityData ability = AbilityData(
        name: abilities[i]['displayName'], 
        description: abilities[i]['description'], 
        icon: abilities[i]['displayIcon']
      );

      allAbilities.add(ability);
    }

    for(int i = 0; i < voice["mediaList"].length; i++){
      AgentVoice agentVoice = AgentVoice(
        duration: voice["maxDuration"], 
        audio: voice["mediaList"][0]["wave"]
      );

      agentVoices.add(agentVoice);
    }

    AgentData agent = AgentData(
      name: data['displayName'], 
      description: data['description'], 
      image: data['bustPortrait'], 
      role: data['role']['displayName'], 
      roleDescription: data['role']['description'], 
      roleIcon: data['role']['displayIcon'], 
      abilities: allAbilities,
      voice: agentVoices
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

  getWeaponSkins(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/weapons/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var skins = await json["data"]["skins"];

    List<WeaponSkins> weaponSkins = [];

    for (int i = 0; i < skins.length; i++){
      WeaponSkins weaponSkin = WeaponSkins(
        id: skins[i]["uuid"], 
        name: skins[i]["displayName"], 
        displayImage: skins[i]["chromas"][0]["fullRender"],
        variants: skins[i]["chromas"].length,
        levels: skins[i]["levels"].length
      );

      weaponSkins.add(weaponSkin);
    }

    return weaponSkins;
  }

  getWeaponVariants(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/weapons/skins/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var variants = await json["data"]["chromas"];
    var levels = await json["data"]["levels"];

    List<WeaponVariants> weaponVariants = [];
    List<WeaponVariantLevel> weaponVariantLevels = [];

    for (int i = 0; i < levels.length; i++){
      WeaponVariantLevel level = WeaponVariantLevel(
        id: levels[i]["uuid"], 
        name: levels[i]["displayName"], 
        video: "https://media.valorant-a…bb-865f-6fa6bceeea72.mp4",
      );

      weaponVariantLevels.add(level);
    }

    for (int i = 0; i < variants.length; i++){
      WeaponVariants variant = WeaponVariants(
        id: variants[i]["uuid"], 
        displayName: variants[i]["displayName"],
        swatch: (variants[i]["swatch"] == null)? "" : variants[i]["swatch"], 
        image: variants[i]["fullRender"],
        video: (variants[i]["streamedVideo"] == null)? "" : variants[i]["streamedVideo"],
      );

      weaponVariants.add(variant);
    }

    return weaponVariants;
  }

  getWeaponVariantlevels(String id) async{
    var uri = Uri.https("valorant-api.com", "v1/weapons/skins/$id");
    var response = await http.get(uri);
    var json = jsonDecode(response.body);  

    var levels = await json["data"]["levels"];

    List<WeaponVariantLevel> weaponVariantLevels = [];

    for (int i = 0; i < levels.length; i++){
      WeaponVariantLevel level = WeaponVariantLevel(
        id: levels[i]["uuid"], 
        name: levels[i]["displayName"], 
        video: (levels[i]["streamedVideo"] == null)? "" : levels[i]["streamedVideo"],
      );

      weaponVariantLevels.add(level);
    }

    return weaponVariantLevels;
  } 
}