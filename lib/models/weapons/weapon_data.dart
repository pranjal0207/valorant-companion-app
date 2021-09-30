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
  final ADSStats adsStats;

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
    required this.damageRanges,
    required this.adsStats
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

class ADSStats{
  final bool ads;
  final double zoom;
  final double fireRate;
  final double runSpeedMultiplier;
  final int burstCount;

  ADSStats({
    required this.ads,
    required this.zoom,
    required this.fireRate,
    required this.runSpeedMultiplier,
    required this.burstCount
  });
}