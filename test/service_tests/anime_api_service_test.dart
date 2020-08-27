import 'package:AnimeTwistFlut/models/EpisodeModel.dart';
import 'package:AnimeTwistFlut/services/twist_service/TwistApiService.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Twist API Service Tests\n', () {
    TwistApiService twistApiService = TwistApiService();

    test('Anime API service test\n', () async {
      SharedPreferences.setMockInitialValues({
        'anime_cache': [null, null]
      });

      await twistApiService.setTwistModels();
      expect(TwistApiService.allTwistModel.length > 0, true);
      expect(TwistApiService.allTwistModel[0].runtimeType.toString(),
          "TwistModel");
      expect(TwistApiService.allTwistModel[0].slug, "07-ghost");
    });

    test('Donation API service test\n', () async {
      List<int> data = await twistApiService.getDonationsData();
      expect(data[0].runtimeType, int);
      expect(data[1].runtimeType, int);

      expect(data[0] >= 0, true);
      expect(data[1] >= 0, true);
    });

    test('MOTD API service test\n', () async {
      List<String> data = await twistApiService.getMOTD();
      expect(data[0].runtimeType, String);
      expect(data[1].runtimeType, String);

      expect(data[0].length > 0, true);
      expect(data[1].length > 0, true);
    });

    test('Episode API service test\n', () async {
      List<EpisodeModel> data = await twistApiService.getEpisodesForSource(
        twistModel: TwistApiService.allTwistModel.first,
      );
      expect(data.length > 0, true);
      expect(data.first.source.length > 0, true);
      expect(data.first.source.runtimeType, String);
    });
  });
}
