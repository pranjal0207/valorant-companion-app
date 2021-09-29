class WeaponData{
  final String name;
  final String icon;
  final int cost;
  final String category;
  final double fireRate;
  final double runSpeed;
  final double equipSpeed;
  final double firstShotSpreadHIP;
  final double firstShotSpreadADS;
  final double reloadSpeed;
  final double magazine;
  final List<DamageRange> damageRanges;

  WeaponData({
    required this.name,
    required this.icon,
    required this.cost,
    required this.category,
    required this.fireRate,
    required this.runSpeed,
    required this.equipSpeed,
    required this.firstShotSpreadADS,
    required this.firstShotSpreadHIP,
    required this.reloadSpeed,
    required this.magazine,
    required this.damageRanges
  });
}

class DamageRange{
  final int rangeStarts;
  final int rangeEnds;
  final double headDamage;
  final double bodyDamage;
  final double legDamage;

  DamageRange({
    required this.rangeStarts,
    required this.rangeEnds,
    required this.bodyDamage,
    required this.headDamage,
    required this.legDamage
  });
}