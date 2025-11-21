import "package:faker/faker.dart";

import "../../errors/connection/http_call_exception.dart";
import "../../services/logger/logger_service.dart";

/// Base mock data source with diferent base methods for an api
abstract class MockDataSource {
  /// Base mock data source with diferent base methods for an api
  const MockDataSource({
    required this.errorPercentage,
    required this.maxWaitTime,
  });

  /// The final wait time the process might take
  final int maxWaitTime;

  /// The error percentage value the process might throw an exception
  final int errorPercentage;

  /// Logger to log the values and errors
  Logger get logger => getLogger("Mock Source");

  /// Mocks an api process time and sends a failure in random form
  Future awaitableMethod({
    int? errorPercentage,
    int? maxWaitTime,
  }) async {
    final activeErrorPercentage = errorPercentage ?? this.errorPercentage;
    final activeMaxWaitTime = maxWaitTime ?? this.maxWaitTime;

    await Future.delayed(
      Duration(milliseconds: activeMaxWaitTime),
    );

    if (faker.randomGenerator.integer(100) <= activeErrorPercentage) {
      throw HttpCallException(
        title: faker.lorem.words(3).join(" "),
        message: faker.lorem.sentence(),
        type: HttpExceptions.values[faker.randomGenerator.integer(
          HttpExceptions.values.length,
        )],
      );
    }
  }
}
