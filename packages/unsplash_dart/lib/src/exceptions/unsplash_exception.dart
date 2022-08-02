// ignore_for_file: public_member_api_docs, sort_constructors_first
class UnsplashException implements Exception {
  const UnsplashException({this.code, required this.message});
  final String message;
  final int? code;

  factory UnsplashException.fromCode(int codes) {
    switch (codes) {
      case 400:
        return const UnsplashException(
            code: 400,
            message:
                "The request was unacceptable, often due to missing a required parameter");
      case 401:
        return const UnsplashException(
            code: 401, message: "Invalid Access Token");
      case 403:
        return const UnsplashException(
            code: 403, message: "Missing permissions to perform request");
      case 404:
        return const UnsplashException(
            code: 404, message: "The requested resource doesn't exist");
      case 500:
        return const UnsplashException(
            code: 500, message: "Something went wrong on our end");
      case 503:
        return const UnsplashException(
            code: 503, message: "Something went wrong on our end");
      default:
        return const UnsplashException(message: "Error");
    }
  }

  @override
  String toString() => 'UnsplashException(code: $code ,message: $message)';
}
