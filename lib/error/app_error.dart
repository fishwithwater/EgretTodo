class AppError extends Error {
  String message;

  AppError(this.message) : super();
}
