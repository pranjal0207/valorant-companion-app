// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:valorant_companion/models/weapons/weapon_skins.dart';
import 'package:valorant_companion/utils/api_handler.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController skinVideo;

  int selectedVariant = 0;

  bool loaded = false;
  bool isSkinVideoButtonVisible= true;

  getVariants() async{
    var temp = await apiHandler.getWeaponVariants(widget.id);

    setState(() {
      variants = temp;
    });

    if(variants[selectedVariant].video != "")
      await loadGunVideo(variants[selectedVariant].video);

    setState(() {
      loaded = true;
    });
  }

  loadGunVideo(String link) async{
    skinVideo = VideoPlayerController.network(link)
    ..initialize().then((_) {
      setState(() {});
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
                    Container(
                      decoration: (selectedVariant == i)? BoxDecoration(
                        border: Border.all(
                          color: Colors.white, 
                          width: 4
                        ) 
                      ): null,
                      child: IconButton(
                        onPressed: () async{
                          setState(() {
                            selectedVariant = i;
                          });

                          if(variants[selectedVariant].video != "")
                            await loadGunVideo(variants[selectedVariant].video);
                        },
                        icon: Image.network(
                          variants[i].swatch,
                        ),
                        iconSize: 30,
                        padding: EdgeInsets.zero
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
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
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child : Image.network(
                  variants[selectedVariant].image,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              if(variants[selectedVariant].video != "")
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isSkinVideoButtonVisible = true;
                          });
                        },
                        child: skinVideo.value.isInitialized? AspectRatio(
                          aspectRatio: skinVideo.value.aspectRatio,
                          child: VideoPlayer(skinVideo),
                        ): const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ),

                    if(skinVideo.value.isInitialized)
                    Center(
                      child: GestureDetector(
                        onTap: (){
                        },
                        child: Visibility(
                          visible: isSkinVideoButtonVisible,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                skinVideo.value.isPlaying
                                    ? skinVideo.pause()
                                    : skinVideo.play();
                              });

                              if(skinVideo.value.isPlaying)
                                setState(() {
                                  isSkinVideoButtonVisible = false;
                                });
                            },
                            icon: Icon(
                              skinVideo.value.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                            ),
                            iconSize: 25,
                          )
                        )
                      ),
                    )
                  ],
                ) 
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "SKIN VARIANT LEVELS : ",
                  style: TextStyle(
                    fontSize: 20,
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