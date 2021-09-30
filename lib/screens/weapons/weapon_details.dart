import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valorant_companion/models/weapons/weapon_data.dart';
import 'package:valorant_companion/utils/api_handler.dart';

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

  bool loading = true;

  int selectedAbility = 0;

  void getWeaponData() async{
    var temp = await apiHandler.getWeaponData(widget.id);

    setState(() {
      weapon = temp;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeaponData();
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
                                          color: Colors.white
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
                                    "Cost : " + weapon.cost.toString(),
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