import 'package:dartz/dartz.dart';
import 'package:stack_trace/stack_trace.dart';

extension TaskX<T extends Either<Object, dynamic>> on Task<T> {
  Task<Either<Exception, A>> mapLeftToException<A>() {
    return map<Either<Exception, A>>((Either<Object, dynamic> either) =>
        either.fold<Either<Exception, A>>((Object obj) {
          try {
            return Left<Exception, A>(obj as Exception);
          } catch (e) {
            throw obj;
          }
        }, (dynamic u) {
          try {
            return Right<Exception, A>(u as A);
          } catch (e) {
            throw u;
          }
        }));
  }
}

extension FutureX<T> on Future<T> {
  Future<Either<Exception, T>> attempt() {
    return attemptTask().run();
  }

  Task<Either<Exception, T>> attemptTask() {
    return Task<T>(() async => this).attempt().mapLeftToException();
  }
}
