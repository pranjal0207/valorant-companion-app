class AgentData{
  final String name;
  final String description;
  final String image;
  final String role;
  final String roleDescription;
  final String roleIcon;
  final List<AbilityData> abilities;
  final List<AgentVoice> voice;

  AgentData({
    required this.name,
    required this.description,
    required this.image,
    required this.role,
    required this.roleDescription,
    required this.roleIcon,
    required this.abilities,
    required this.voice
  });
}

class AbilityData{
  final String name;
  final String description;
  final String icon;

  AbilityData({
    required this.name,
    required this.description,
    required this.icon
  });
}

class AgentVoice{
  final String audio;
  final double duration;

  AgentVoice({
    required this.audio,
    required this.duration
  });
}