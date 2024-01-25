enum RouteType {
  home,
  detail,
  unknown,
}

extension RouteTypeExtension on RouteType {
  String get name {
    switch (this) {
      case RouteType.home:
        return '/home';
      case RouteType.detail:
        return '/detail';
      case RouteType.unknown:
        return '/unknown';
      default:
        return '/';
    }
  }
}
