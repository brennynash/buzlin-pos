import '../handlers/handlers.dart';
import '../models/models.dart';
import '../models/response/profile_response.dart';

abstract class MastersRepository {
  Future<ApiResult<UsersPaginateResponse>> getMasters({
    String? query,
    String? inviteStatus,
    int? page,
    int? serviceId,
  });

  Future<ApiResult> updateMasterStatus({
    required int? id,
    required String status,
  });

  Future<ApiResult<ProfileResponse>> getMastersDetails(String? uuid);

  Future<ApiResult<ProfileResponse>> updateMaster(UserData? user);

  Future<ApiResult<void>> updateDisableTimes({
    required DisableTimes time,
    int? id,
  });

  Future<ApiResult<void>> updateClosedDays({
    required List<DateTime> days,
    int? masterId,
  });

  Future<ApiResult<ClosedDatesResponse>> getClosedDays({
    int? masterId,
    DateTime? to,
    DateTime? from,
  });

  Future<ApiResult<DisableTimesResponse>> getDisableTimes(
      {int? masterId, int? page});

  Future<ApiResult<SingleDisableTimeResponse>> getDisableTimeDetails(int? id);

  Future<ApiResult<void>> updateWorkingDays({
    required List<WorkingDay> workingDays,
    int? id,
  });
}
