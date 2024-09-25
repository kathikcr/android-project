import 'package:android_project/features/auth/model/user_model.dart';
import 'package:android_project/features/auth/repository/user_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(UserDataServiceProvider).fetchCurrentUserData();
  return user;
});

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserModel user =
      await ref.watch(UserDataServiceProvider).fetchAnyUserData(userId);
  return user;
});