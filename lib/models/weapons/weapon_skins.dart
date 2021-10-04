class WeaponSkins{
  final String id;
  final String name;
  final String displayImage;
  final int variants;
  final int levels;

  WeaponSkins({
    required this.id,
    required this.name,
    required this.displayImage,
    required this.variants,
    required this.levels
  });
}

class WeaponVariants{
  final String id;
  final String displayName;
  final String video;
  final String swatch;
  final String image;

  WeaponVariants({
    required this.id,
    required this.displayName,
    required this.swatch,
    required this.image,
    required this.video,
  });
}

class WeaponVariantLevel{
  final String id;
  final String name;
  final String video;

  WeaponVariantLevel({
    required this.id,
    required this.name,
    required this.video
  });
}