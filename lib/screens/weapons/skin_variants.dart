import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/weapons/weapon_skins.dart';
import '../../utils/api_handler.dart';

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
  late List<WeaponVariantLevel> levels;

  late VideoPlayerController skinVideo;
  late VideoPlayerController levelVideo;

  int selectedVariant = 0;

  bool loaded = false;
  bool isSkinVideoButtonVisible = true;
  bool isLevelVideoButtonVisible = true;

  List<String> levelsLabel = [];
  late String levelsValue;

  getVariants() async{
    var temp = await apiHandler.getWeaponVariants(widget.id);

    setState(() {
      variants = temp;
    });

    temp = await apiHandler.getWeaponVariantlevels(widget.id);

    setState(() {
      levels = temp;
      for(int i = 0; i < levels.length; i++) {
        levelsLabel.add((i+1).toString());
      }
      levelsValue = levelsLabel[0];
    });

    if(variants[selectedVariant].video != "") {
      await loadGunVideo(variants[selectedVariant].video);
    }

    if(levels[0].video != "") {
      await loadSkinLevelVideo(levels[0].video);
    }

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

  loadSkinLevelVideo(String link) async{
    levelVideo = VideoPlayerController.network(link)
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
  void dispose() {
    super.dispose();
    if(levelVideo.value.isInitialized) {
      levelVideo.dispose();
    }
    if(skinVideo.value.isInitialized) {
      skinVideo.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   
    if(loaded) {
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

              if((variants[0].swatch != ""))
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
                      decoration: (selectedVariant == i && (variants[i].swatch != ""))? BoxDecoration(
                        border: Border.all(
                          color: Colors.white, 
                          width: 4
                        ) 
                      ): null,
                      child:(variants[i].swatch != "")? IconButton(
                        onPressed: () async{
                          setState(() {
                            selectedVariant = i;
                          });

                          if(variants[selectedVariant].video != "") {
                            await loadGunVideo(variants[selectedVariant].video);
                          }
                        },
                        icon: Image.network(
                          variants[i].swatch,
                        ),
                        iconSize: 30,
                        padding: EdgeInsets.zero
                      ) : null,
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

                              if(skinVideo.value.isPlaying) {
                                setState(() {
                                  isSkinVideoButtonVisible = false;
                                });
                              }
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

              if(levels.length > 1)
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "SKIN VARIANT LEVELS : ",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Valorant'
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              if(levels.length > 1)
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width : width - 40,
                child: DropdownButton(
                  isExpanded: true,
                  value: levelsValue,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      levelsValue = newValue!;
                    });
                    loadSkinLevelVideo(levels[int.parse(levelsValue) - 1].video);
                  },
                  items: levelsLabel.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        "Level " + value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Valorant'
                        ),
                      ),
                    );
                  }).toList(),
                )
              ),

              const SizedBox(
                height: 30,
              ),

              if(levels.length > 1)
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  levels[int.parse(levelsValue) - 1].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Valorant'
                  ),
                )
              ),

              const SizedBox(
                height: 30,
              ),

              if(levels[int.parse(levelsValue) - 1].video != "")
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isLevelVideoButtonVisible = true;
                          });
                        },
                        child: levelVideo.value.isInitialized? AspectRatio(
                          aspectRatio: levelVideo.value.aspectRatio,
                          child: VideoPlayer(levelVideo),
                        ): const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ),

                    if(levelVideo.value.isInitialized)
                    Center(
                      child: GestureDetector(
                        onTap: (){
                        },
                        child: Visibility(
                          visible: isLevelVideoButtonVisible,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                levelVideo.value.isPlaying
                                    ? levelVideo.pause()
                                    : levelVideo.play();
                              });

                              if(levelVideo.value.isPlaying) {
                                setState(() {
                                  isLevelVideoButtonVisible = false;
                                });
                              }
                            },
                            icon: Icon(
                              levelVideo.value.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
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
            ],
          ),
        ),
      ),
    );
    }

    return const Scaffold(
      body: Center(
        child : CircularProgressIndicator()
      ),
    );
  }
}