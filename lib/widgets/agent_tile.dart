import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/agents/agent_list_item.dart';
import '../screens/agents/agent_details.dart';

class AgentTile extends StatelessWidget {
  final AgentListItem agents;
  const AgentTile({ 
    required this.agents,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        String id = agents.id;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AgentDetails(id: id)));
      },
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: agents.icon,
              height: 50,
              width: 50,
            ),

            const SizedBox(
              width: 40,
            ),

            Expanded(
              child: Text(
                agents.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Valorant'
                ),
              ),
            ),

            IconButton(
              onPressed: null,
              icon: Image.network(
                agents.roleIcon
              ),
              tooltip: agents.role,
            ),
          ],
        ),
      )
    );
  }
}