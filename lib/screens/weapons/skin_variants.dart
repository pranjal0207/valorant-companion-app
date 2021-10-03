// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:valorant_companion/models/weapons/weapon_skins.dart';
import 'package:valorant_companion/utils/api_handler.dart';

class SkinVariants extends StatefulWidget {
  final String name;
  final String id;

  const SkinVariants({ 
    required this.id,
    required this.name,
    Key? key 
  }) : super(key: key);

  @override
  _SkinVariantsState createState() => _SkinVariantsState();
}

class _SkinVariantsState extends State<SkinVariants> {
  final apiHandler = APIHandler();
  
  late List<WeaponVariants> variants;

  int selectedVariant = 0;

  bool loaded = false;

  getVariants() async{
    var temp = await apiHandler.getWeaponVariants(widget.id);

    setState(() {
      variants = temp;
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getVariants();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   
    if(loaded)
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
                margin: const EdgeInsets.only(right:20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                    ),

                    const SizedBox(
                      width : 20,
                    ),

                    Expanded(
                      child: Text(
                        widget.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Valorant'
                        ),
                      ),
                    )
                  ],
                )
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(int i = 0; i < variants.length; i++)
                    IconButton(
                      onPressed: (){
                        setState(() {
                          selectedVariant = i;
                        });
                      },
                      icon: Image.network(
                        variants[i].swatch,
                      ),
                      iconSize: 30
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child : Image.network(
                  variants[selectedVariant].image,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child : Text(
                  variants[selectedVariant].displayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Valorant'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    return const Scaffold(
      body: Center(
        child : CircularProgressIndicator()
      ),
    );
  }
}