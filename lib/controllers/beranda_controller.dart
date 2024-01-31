import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:newtronic_test_rizky/configs/constant.dart';
import 'package:newtronic_test_rizky/models/newtronic_data.dart';
import 'package:newtronic_test_rizky/models/product.dart';
import 'package:newtronic_test_rizky/repositories/beranda_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BerandaController extends GetxController {
  var loading = 0.obs;
  var isDataLoading = false.obs;
  var isPlay = false.obs;
  var isChoice = false.obs;
  var url = "".obs;
  var change = false.obs;
  final productSelected = Product().obs;
  final newtronicData = <NewtronicData>[].obs;
  late VideoPlayerController videoController;
  final ReceivePort _port = ReceivePort();
  late final WebViewController webController;

  final List items = [
    "Produk",
    "Materi",
    "Layanan",
    "Artikel",
    "Berita",
  ];

  @override
  void onInit() async {
    await getNewtronicData();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print('download success');
      }
    });

    // FlutterDownloader.registerCallback(downloadCallback);
    await FlutterDownloader.registerCallback(
        downloadCallback); // callback is a top-level or static function
    downloadVideo(url.toString());
    // webView();
    super.onInit();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    webController.clearLocalStorage();
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void choice() {
    isChoice.value = isChoice.value ? false : true;
  }

  void playVideo() {
    isPlay.value = isPlay.value ? false : true;
  }

  // void getVideo(int index){
  //   videoController = VideoPlayerController.networkUrl(newtronicData[0].playlist![index].url);
  //   videoController.initialize().then((value) {
  //     videoController.play();
  //   });
  // }

  void webView() {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(whiteColor)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          loading.value = 0;
        },
        onProgress: (progress) {
          loading.value = progress;
        },
        onPageFinished: (url) {
          loading.value = 100;
         
        },
        onWebResourceError: (error) {},
      ))
      ..loadRequest(Uri.parse(
          productSelected.value.url ?? newtronicData[0].playlist![0].url!));
  }

  void downloadVideo(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  Future<void> getNewtronicData() async {
    isDataLoading(true);
    try {
      await BerandaRepository().getNewtronicData().then((value) {
        // info(value);
        newtronicData.assignAll(value);
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
    // await BerandaRepository().getNewtronicData().then((value) {
    //   info(value);
    // }).catchError((e){});
    isDataLoading(false);
    // isDataLoading(true);
    // await BerandaRepository().getNewtronicData().then((value) {
    //   info(value);
    //   // newtronicData.assignAll(value);
    //   // product(newtronicData[0].playlist);
    //   print("test");
    // }).catchError((e) {});
    // // await BerandaRepository().getNewtronicData().then(
    // //   (value) {
    // //     product.assignAll(value as Iterable<Product>);
    // //   },
    // // ).catchError((e) {});
    // isDataLoading(false);
  }
}
