// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HelpPage]
class HelpRoute extends PageRouteInfo<void> {
  const HelpRoute({List<PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HelpPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [PickupMapPage]
class PickupMapRoute extends PageRouteInfo<PickupMapRouteArgs> {
  PickupMapRoute({
    Key? key,
    required int countryId,
    required int? regionId,
    List<PageRouteInfo>? children,
  }) : super(
          PickupMapRoute.name,
          args: PickupMapRouteArgs(
            key: key,
            countryId: countryId,
            regionId: regionId,
          ),
          initialChildren: children,
        );

  static const String name = 'PickupMapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PickupMapRouteArgs>();
      return PickupMapPage(
        key: args.key,
        countryId: args.countryId,
        regionId: args.regionId,
      );
    },
  );
}

class PickupMapRouteArgs {
  const PickupMapRouteArgs({
    this.key,
    required this.countryId,
    required this.regionId,
  });

  final Key? key;

  final int countryId;

  final int? regionId;

  @override
  String toString() {
    return 'PickupMapRouteArgs{key: $key, countryId: $countryId, regionId: $regionId}';
  }
}

/// generated route for
/// [PinCodePage]
class PinCodeRoute extends PageRouteInfo<PinCodeRouteArgs> {
  PinCodeRoute({
    required bool isNewPassword,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PinCodeRoute.name,
          args: PinCodeRouteArgs(
            isNewPassword: isNewPassword,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PinCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinCodeRouteArgs>();
      return PinCodePage(
        args.isNewPassword,
        key: args.key,
      );
    },
  );
}

class PinCodeRouteArgs {
  const PinCodeRouteArgs({
    required this.isNewPassword,
    this.key,
  });

  final bool isNewPassword;

  final Key? key;

  @override
  String toString() {
    return 'PinCodeRouteArgs{isNewPassword: $isNewPassword, key: $key}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}
