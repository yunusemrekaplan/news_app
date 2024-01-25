enum Category {
  general,
  economy,
  sport,
  technology,
  entertainment,
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.general:
        return 'Genel';
      case Category.economy:
        return 'Ekonomi';
      case Category.sport:
        return 'Spor';
      case Category.technology:
        return 'Teknoloji';
      case Category.entertainment:
        return 'Eğlence';
      default:
        return '';
    }
  }

  String get tag {
    switch (this) {
      case Category.general:
        return 'general';
      case Category.economy:
        return 'economy';
      case Category.sport:
        return 'sport';
      case Category.technology:
        return 'technology';
      case Category.entertainment:
        return 'entertainment';
      default:
        return '';
    }
  }
}
