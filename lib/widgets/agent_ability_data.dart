import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AgentAbilityData extends StatefulWidget {
  final String abilityIcon;
  final String abilityName;
  final String abilityData;
  final VideoPlayerController abilityVideoCon;

  const AgentAbilityData({ 
    required this.abilityIcon,
    required this.abilityName,
    required this.abilityData,
    required this.abilityVideoCon,
    Key? key 
  }) : super(key: key);

  @override
  State<AgentAbilityData> createState() => _AgentAbilityDataState();
}

class _AgentAbilityDataState extends State<AgentAbilityData> {
  bool isLevelAbilityButtonVisible = true;

  @override
  void dispose() {
    super.dispose();
    if(widget.abilityVideoCon.value.isInitialized) {
      widget.abilityVideoCon.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left : 15, right: 15, top: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                widget.abilityIcon,
                width: 40
              ),

              const SizedBox(
                width: 15,
              ),

              Text(
                widget.abilityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Valorant'
                ),
              )
            ],
          )
        ),

        Container(
          margin: const EdgeInsets.only(left : 15, right: 15, top: 20),
          child: Text(
            widget.abilityData,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 20),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isLevelAbilityButtonVisible = true;
                    });
                  },
                  child: widget.abilityVideoCon.value.isInitialized? AspectRatio(
                    aspectRatio: widget.abilityVideoCon.value.aspectRatio,
                    child: VideoPlayer(widget.abilityVideoCon),
                  ): const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ),

              if(widget.abilityVideoCon.value.isInitialized)
              Center(
                child: GestureDetector(
                  onTap: (){
                  },
                  child: Visibility(
                    visible: isLevelAbilityButtonVisible,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.abilityVideoCon.value.isPlaying
                              ? widget.abilityVideoCon.pause()
                              : widget.abilityVideoCon.play();
                        });

                        if(widget.abilityVideoCon.value.isPlaying) {
                          setState(() {
                            isLevelAbilityButtonVisible = false;
                          });
                        }
                      },
                      icon: Icon(
                        widget.abilityVideoCon.value.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                      ),
                      iconSize: 25,
                    )
                  )
                ),
              )
            ],
          ) 
        ),
      ],
    );
  }
}