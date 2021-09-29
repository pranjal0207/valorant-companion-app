import 'package:flutter/material.dart';
import 'package:valorant_companion/screens/agents/all_agents.dart';
import 'package:valorant_companion/screens/weapons/all_weapons.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({ Key? key }) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 0;
  
  List<Widget> screens = <Widget>[
    const AllAgents(),
    const AllWeapons(),
    const Text("MAPS")
  ];

  void onItemTap(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Center(
          child: screens.elementAt(selectedIndex)
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: "Agents"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.king_bed),
            label: "Weapons"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "Maps"
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTap,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
      ),
    );
  }
}