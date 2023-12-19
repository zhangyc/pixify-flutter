import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


@immutable
class Entitlements {
  const Entitlements({
    required this.dm,
    required this.interpretation,
    required this.tip,
    required this.like
  });

  final int interpretation;
  final int dm;
  final int tip;
  final int like;

  factory Entitlements.fromJson(Map<String, dynamic> json) {
    return Entitlements(
      dm: json['em'],
      interpretation: json['interpretation'],
      tip: json['tip'],
      like: json['like']
    );
  }

  factory Entitlements.copyWith(Entitlements entitlements, {
    int? interpretation,
    int? dm,
    int? tip,
    int? like
  }) {
    return Entitlements(
      dm: dm ?? entitlements.dm,
      interpretation: entitlements.interpretation,
      tip: tip ?? entitlements.tip,
      like: like ?? entitlements.like
    );
  }
}


class EntitlementsNotifier extends StateNotifier<Entitlements> {
  EntitlementsNotifier(super.state);
  //
  // refresh() {
  //
  // }
  void limit({
    int? interpretation,
    int? dm,
    int? tip,
    int? like
  }) {
    state = Entitlements.copyWith(state, dm: dm, interpretation: interpretation, tip: tip, like: like);
  }
}


final entitlementsProvider = StateNotifierProvider<
    EntitlementsNotifier,
    Entitlements
>((ref) => EntitlementsNotifier(const Entitlements(dm: 1, interpretation: 1, tip: 1, like: 1)));