import 'dart:io';

import 'package:flutter/services.dart';
import 'package:coco_mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class Network {
  Future<bool> get isInternet;
}

class NetworkImplement implements Network {
  @override
  Future<bool> get isInternet async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }

    return false;
  }
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
