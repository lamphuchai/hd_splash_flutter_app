part of 'download_cubit.dart';

enum DownloadStatus { init, start, complete, error }

class DownloadState extends Equatable {
  const DownloadState(this.status);
  final DownloadStatus status;
  @override
  List<Object> get props => [status];
}
