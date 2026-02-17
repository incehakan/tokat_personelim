import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/exceptions/server_exception.dart';
import '../../../product/utils/network_manager.dart';
import '../models/birthday_celebration_model.dart';
import '../models/birthday_model.dart';
import '../models/feed_model.dart';
import '../models/notification.dart';

class NotificationRepository {
  final NetworkManager networkManager;

  NotificationRepository(this.networkManager);

  Future<Either<ServerException, List<Feed>>> fetchFeeds() async {
    const url = Endpoints.notificationsUrl + Endpoints.feeds;
    try {
      final response = await networkManager.get(url);
      final data = FeedModel.fromJson(response.data);
      if (data.feeds != null && data.feeds!.isNotEmpty) {
        return Right(data.feeds!);
      } else {
        return Left(ServerException(AppStrings.notFoundFeed));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<Birthday>>> fetchBirthdays() async {
    try {
      final response = await networkManager.get(Endpoints.birthdays);
      final data = BirthdayModel.fromJson(response.data);
      if (data.birthdays != null && data.birthdays!.isNotEmpty) {
        return Right(data.birthdays!);
      } else {
        return Left(ServerException(AppStrings.notFoundBirthday));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, void>> celebrateBirthday(String registerNo, String type) async {
    try {
      await networkManager.post(
        Endpoints.celebrateBirthday,
        data: {
          "SICIL_ID": registerNo,
          "TIP": type,
        },
      );
      return const Right(null);
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<BirthdayCelebration>>> fetchBirthdayCelebrations() async {
    try {
      final response = await networkManager.get(
        Endpoints.birthdayCelebrations,
      );
      final data = BirthdayCelebrationModel.fromJson(response.data);
      if (data.celebrations != null && data.celebrations!.isNotEmpty) {
        return Right(data.celebrations!);
      } else {
        return Left(ServerException(""));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }

  Future<Either<ServerException, List<PrsNotification>>> fetchNotifications() async {
    const url = Endpoints.notificationsUrl + Endpoints.notificationHistory;
    try {
      final response = await networkManager.post(url, data: {
        "UYGULAMA_KODU": "KBAGLARINTRANET2023",
      });
      final data = NotificationResponse.fromJson(response.data);
      if (data.notifications != null && data.notifications!.isNotEmpty) {
        return Right(data.notifications!);
      } else {
        return Left(ServerException('Gösterilecek bildirim bulunamadı.'));
      }
    } on DioException catch (err) {
      return Left(
        ServerException(
          err.response!.statusMessage.toString(),
        ),
      );
    }
  }
}
