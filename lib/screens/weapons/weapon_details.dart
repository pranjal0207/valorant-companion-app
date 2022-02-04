import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/weapons/weapon_data.dart';
import '../../models/weapons/weapon_skins.dart';
import '../../utils/api_handler.dart';
import 'skin_variants.dart';

class WeaponDetails extends StatefulWidget {
  final String id;
  const WeaponDetails({
    required this.id,
    Key? key 
  }) : super(key: key);

  @override
  _WeaponDetailsState createState() => _WeaponDetailsState();
}

class _WeaponDetailsState extends State<WeaponDetails> {
  final apiHandler = APIHandler();
  
  late WeaponData weapon;
  late List<WeaponSkins> skins;

  bool loading = true;
  bool skinLoading = true;

  int selectedAbility = 0;

  void getWeaponData() async{
    var temp = await apiHandler.getWeaponData(widget.id);

    setState(() {
      weapon = temp;
      loading = false;
    });
  }

  getSkinData() async{
    var temp = await apiHandler.getWeaponSkins(widget.id);

    setState(() {
      skins = temp;
      skinLoading = false;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    getWeaponData();
    getSkinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                child: (loading)? 
                  const Center(
                    child: CircularProgressIndicator(),
                  ):

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Image.network(
                              weapon.icon,
                              height: 50,
                              width: 150,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        weapon.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Valorant'
                                        ),
                                      ),

                                      Text(
                                        "(" + weapon.category + ")",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    "Cost : " + weapon.cost.toString() + " credits",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20),
                        child : const Text(
                          "Weapon Statistics",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatBox(
                              title: "FIRE RATE", 
                              data: weapon.fireRate.toString(), 
                              unit: "RDS/SEC"
                            ),

                            StatBox(
                              title: "RUN SPEED", 
                              data: (weapon.runSpeed * 6.75).toStringAsFixed(2), 
                              unit: "M/SEC"
                            )
                          ],
                        )
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatBox(
                              title: "EQUIP SPEED", 
                              data: weapon.equipSpeed.toString(), 
                              unit: "SEC"
                            ),

                            StatBox(
                              title: "1ST SHOT SPREAD", 
                              data: weapon.firstShotSpreadHIP.toStringAsFixed(2) + " / " + weapon.firstShotSpreadADS.toStringAsFixed(2), 
                              unit: "DEG (HIP/ADS)"
                            )
                          ],
                        )
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatBox(
                              title: "RELOAD SPEED", 
                              data: weapon.reloadSpeed.toString(), 
                              unit: "SEC"
                            ),

                            StatBox(
                              title: "MAGAZINE", 
                              data: weapon.magazine.toString(), 
                              unit: "RDS"
                            )
                          ],
                        )
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20),
                        child : const Text(
                          "Damage & Ranges",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.white
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(70)
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children:  <TableRow>[
                            TableRow(
                              children: [
                                Container(
                                  height: 40,
                                  child : const Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                    ),
                                  ),
                                ),

                                for(int i = 0; i < weapon.damageRanges.length; i++)
                                Center(
                                  child: Text(
                                    weapon.damageRanges[i].rangeStarts.toString() + "-" + weapon.damageRanges[i].rangeEnds.toString() + " m"
                                  ),
                                )
                              ]
                            ),

                            TableRow(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child : const Text(
                                    "HEAD",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                    ),
                                    textAlign: TextAlign.center
                                  ),
                                ),

                                for(int i = 0; i < weapon.damageRanges.length; i++)
                                Center(
                                  child: Text(
                                    weapon.damageRanges[i].headDamage.toStringAsFixed(0)
                                  ),
                                )
                              ]
                            ),

                            TableRow(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child : const Text(
                                    "BODY",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                    ),
                                    textAlign: TextAlign.center
                                  ),
                                ),

                                for(int i = 0; i < weapon.damageRanges.length; i++)
                                Center(
                                  child : Text(
                                    weapon.damageRanges[i].bodyDamage.toStringAsFixed(0)
                                  )
                                )
                              ]
                            ),

                            TableRow(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  child : const Text(
                                    "LEGS",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                    ),
                                    textAlign: TextAlign.center
                                  ),
                                ),

                                for(int i = 0; i < weapon.damageRanges.length; i++)
                                Center(
                                  child: Text(
                                    weapon.damageRanges[i].legDamage.toStringAsFixed(0)
                                  )
                                )
                              ]
                            )
                          ],
                        )
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      if(weapon.adsStats.ads)
                      Container(
                        margin: const EdgeInsets.only(left : 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ADS Statistics",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )
                            ),

                            const SizedBox(
                              height: 20
                            ),

                            Text(
                              "\t\t1.\t\t\tZoom : " + weapon.adsStats.zoom.toStringAsFixed(1) + "x",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),

                            const SizedBox(
                              height: 10
                            ),

                            Text(
                              "\t\t2.\t\t\tFire Rate : " + weapon.fireRate.toStringAsFixed(1) + " rounds/sec",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),

                            const SizedBox(
                              height: 10
                            ),

                            Text(
                              "\t\t3.\t\t\tMove Speed : " + (weapon.adsStats.runSpeedMultiplier * weapon.runSpeed * 6.75).toStringAsFixed(2)  + "m/sec",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),

                            const SizedBox(
                              height: 10
                            ),

                            Text(
                              "\t\t4.\t\t\tBurst Count : " + weapon.adsStats.burstCount.toString() + " bullet(s)",
                              style: const TextStyle(
                                fontSize: 16,
                              )
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20
                      ),

                      Container(
                        margin : const EdgeInsets.only(left : 15, right : 15),
                        child : const Divider(
                          thickness: 2,
                          color: Colors.white
                        ),
                      ),

                      const SizedBox(
                        height: 20
                      ),

                      if(!skinLoading)
                      Container(
                        margin : const EdgeInsets.only(left : 20, right : 20),
                        child : Text(
                          "WEAPON SKINS (" + (skins.length).toString() + ")",
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'Valorant'
                          ),
                        )
                      ),

                      const SizedBox(
                        height: 20
                      ),

                      if(!skinLoading)
                      for (int i = 0; i < skins.length; i = i + 2)
                      Container(
                        margin : const EdgeInsets.only(left : 20, right : 20, bottom: 20),
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int j = i; j < i+2 && j < skins.length; j++)
                            GestureDetector(
                              onTap: (){
                                if(skins[j].variants > 1 || skins[j].levels > 1){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SkinVariants(id: skins[j].id, name: skins[j].name)));
                                }

                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "This Skin has only one variant",
                                        style: TextStyle(
                                          fontSize: 16,
                                        )
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.grey
                                    )
                                  );
                                }
                              },
                              child : SkinInfoBox(
                                skin: skins[j]
                              )
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40
                      ),
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final String title;
  final String data;
  final String unit;

  const StatBox({ 
    required this.title,
    required this.data,
    required this.unit,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top : 10, bottom : 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white)
      ),
      width: (width - 50)/2,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            unit,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),
        ]
      ),
    );
  }
}

class SkinInfoBox extends StatelessWidget {
  final WeaponSkins skin;
  const SkinInfoBox({ 
    required this.skin,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.only(top : 20, bottom : 20, left : 10, right : 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white)
        ),
        height: 182,
        width: (width - 50)/2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              skin.name,
              style: const TextStyle(
                fontFamily: 'Valorant'
              )
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.network(
                    skin.displayImage,
                    height: 60
                  ),
                ],
              )
            )
            
          ],
        ),
      );
  }
}