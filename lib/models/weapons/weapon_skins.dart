class WeaponSkins{
  String id;
  String name;
  String displayImage;
  int variants;

  WeaponSkins({
    required this.id,
    required this.name,
    required this.displayImage,
    required this.variants
  });
}

class WeaponVariants{
  final String id;
  final String displayName;
  String? video;
  final String swatch;
  final String image;

  WeaponVariants({
    required this.id,
    required this.displayName,
    required this.swatch,
    required this.image,
    this.video
  });
}