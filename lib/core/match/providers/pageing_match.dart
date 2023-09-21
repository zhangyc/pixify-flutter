// // 1. 分页状态管理
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sona/common/models/user.dart';
// import 'package:sona/core/match/providers/setting.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../../utils/providers/dio.dart';
//
// final pagingProvider = StateNotifierProvider<Paging, PagingState>(
//         (ref) => Paging(const PagingState())
// );
//
// class Paging extends StateNotifier<PagingState> {
//
//   final ApiService api;
//
//   Paging(PagingState state) :api = ApiService(),
//         super(state);
//
//   void refresh(WidgetRef ref) async {
//     // loading
//     state = state.copyWith(isLoading: true);
//
//     try {
//       final items = await api.fetchPage(state.page,ref);
//
//       state = state.copyWith(
//           page: state.page + 1,
//           items: [...state.items, ...items],
//           isLoading: false
//       );
//
//     } catch (err) {
//       state = state.copyWith(isLoading: false);
//     }
//   }
// }
//
//
// // 2. API服务
// final apiProvider = Provider((ref) => ApiService(),
// );
//
// class ApiService {
//   ApiService();
//   Future<List<UserInfo>> fetchPage(int page, WidgetRef ref) async {
//     Dio dio= ref.read(dioProvider);
//     Position? position=ref.read(positionProvider);
//     final sp = await SharedPreferences.getInstance();
//     final storageGenderValue = sp.getInt(MatchSettingNotifier.genderKey);
//     final ageRangeValues = sp.getString(MatchSettingNotifier.ageRangeKey)??'18:40';
//     // final position = ref.read(positionProvider);
//     // final setting = ref.read(matchSettingProvider);
//
//     final resp=await dio.post('/user/match-v2',data: {
//       'gender': storageGenderValue,
//       'minAge': ageRangeValues?.split(':')[0],
//       'maxAge': ageRangeValues?.split(':')[1],
//       'longitude': position?.longitude,
//       'latitude': position?.latitude,
//       "page":1,    // 页码
//       "pageSize":10 // 每页数量
//     });
//     resp as List;
//     List list= resp.data;
//     var users=list.map((e) => UserInfo.fromJson(e)).toList();
//     return Future.value(users);
//   }
// }
//
//
// // 3. 消费分页数据
// final itemsProvider = Provider((ref) {
//   final pageState = ref.watch(pagingProvider);
//   return pageState.items;
// });
//
// class PagingState {
//
//   final List<UserInfo> items;
//   final int page;
//   final bool isLoading;
//   final bool hasMore;
//   final Exception? error;
//
//   const PagingState({
//     this.items = const [],
//     this.page = 1,
//     this.isLoading = false,
//     this.hasMore = true,
//     this.error,
//   });
//
//   PagingState copyWith({
//     List<UserInfo>? items,
//     int? page,
//     bool? isLoading,
//     bool? hasMore,
//     Exception? error
//   }) {
//     return PagingState(
//       items: items ?? this.items,
//       page: page ?? this.page,
//       isLoading: isLoading ?? this.isLoading,
//       hasMore: hasMore ?? this.hasMore,
//       error: error ?? this.error,
//     );
//   }
//
// }
// // 4. 自定义hook
//
// // // 4. UI组件
// // Consumer(
// // builder: (context, ref, child) {
// // final items = ref.watch(itemsProvider);
// //
// // return ListView(
// // children: [...items],
// // );
// // }
// // )