import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(const DownloadState(DownloadStatus.init));

  Future<void> downloadPhoto(Photo photo) async {
    try {
      final path = (await getTemporaryDirectory()).path;
      emit(const DownloadState(DownloadStatus.start));
      final fileName = '${photo.id}-${photo.user.username}.jpg';
      final pathPhoto = '$path/$fileName';
      await Dio().download(photo.links.download, pathPhoto);
      await GallerySaver.saveImage(pathPhoto);
      emit(const DownloadState(DownloadStatus.complete));
    } catch (error) {
      emit(const DownloadState(DownloadStatus.error));
    }
  }
}
