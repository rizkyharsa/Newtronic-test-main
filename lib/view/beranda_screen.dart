import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtronic_test_rizky/configs/constant.dart';
import 'package:newtronic_test_rizky/controllers/beranda_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BerandaScreen extends GetView<BerandaController> {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final webController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(controller.productSelected.value.url ??
    //       controller.newtronicData[0].playlist![0].url!));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Image.asset(
          "assets/images/logo2_newtronic.jpg",
          scale: 5,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              color: blackColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isDataLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isPlay.isFalse
                        ? Container(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            color: blueColor,
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            color: blackColor,
                            child: controller.productSelected.value.id == null
                                ? Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                    width: MediaQuery.of(context).size.width,
                                    color: blackColor,
                                  )
                                : WebViewWidget(
                                    controller: controller.webController,
                                  ),
                          ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "" == ""
                                  ? controller.newtronicData[0].title.toString()
                                  : controller
                                      .newtronicData[0].playlist![0].title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blackColor,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "\n${controller.newtronicData[0].description}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: blackColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                controller.choice();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 8),
                                height: 10,
                                width: MediaQuery.of(context).size.width * .3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.isChoice.isFalse
                                      ? Colors.grey.shade300
                                      : blueColor,
                                ),
                                child: Text(
                                  controller.items[index],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemCount:
                              controller.newtronicData[0].playlist!.length,
                          itemBuilder: (context, index) {
                            var urlVideo = controller
                                .newtronicData[0].playlist![index].url
                                ?.trim();
                            return Container(
                              padding: const EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.height * .12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade500),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      controller.playVideo();
                                      controller.productSelected(controller
                                          .newtronicData[0].playlist![index]);
                                      // controller.webController;
                                      controller.webView();
                                      print(urlVideo);
                                      // controller.videoController =
                                      //     VideoPlayerController.networkUrl(
                                      //         Uri.parse(urlVideo!));
                                      // controller.videoController
                                      //     .initialize()
                                      //     .then((value) {
                                      //   controller.videoController.play();
                                      // });
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: blackColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${controller.newtronicData[0].playlist![index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${controller.newtronicData[0].playlist![index].description}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      controller.downloadVideo(urlVideo!);
                                    },
                                    child: Container(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: blueColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Simpan",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
