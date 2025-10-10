import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sona/core/diamond/services/diamond.dart';

/// 钻石余额提供者
final diamondBalanceProvider = FutureProvider<DiamondBalance>((ref) async {
  final response = await DiamondService.getBalance();

  if (response.isSuccess) {
    return DiamondBalance.fromJson(response.data['data']);
  } else {
    throw Exception(response.data['msg'] ?? '获取钻石余额失败');
  }
});

/// 钻石交易记录提供者
final diamondTransactionsProvider =
    FutureProvider.family<List<DiamondTransaction>, ({int page, int pageSize})>(
      (ref, params) async {
        final response = await DiamondService.getTransactions(
          page: params.page,
          pageSize: params.pageSize,
        );

        if (response.isSuccess) {
          final list = response.data['data'] as List<dynamic>? ?? [];
          return list.map((item) => DiamondTransaction.fromJson(item)).toList();
        } else {
          throw Exception(response.data['msg'] ?? '获取交易记录失败');
        }
      },
    );

/// 检查钻石余额是否充足提供者
final checkDiamondBalanceProvider = FutureProvider.family<bool, int>((
  ref,
  requiredDiamonds,
) async {
  final response = await DiamondService.checkBalance(
    requiredDiamonds: requiredDiamonds,
  );

  if (response.isSuccess) {
    return response.data['data'] as bool? ?? false;
  } else {
    throw Exception(response.data['msg'] ?? '检查钻石余额失败');
  }
});
