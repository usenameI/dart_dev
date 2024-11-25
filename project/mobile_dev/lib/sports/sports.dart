import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_dev/config/mapConfig.dart';
import 'package:mobile_dev/sports/sportsTool.dart';
import 'package:pro_mana/customWidget/customWidget.dart';
import 'package:pro_mana/getLoaction/getLocation.dart';
import 'package:pro_mana/secondTime/secondTime.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'package:latlong2/latlong.dart' as l;
import 'package:pro_mana/style/shadow/shadow.dart';

class sports extends StatefulWidget {
  @override
  State<sports> createState() {
    // TODO: implement createState
    return _sports();
  }
}

class _sports extends State<sports> {
  int step = 0;
  bool play = true;
  var data = Get.put(sportsTool());
  l.LatLng? initPo;
  l.LatLng? displayLo;
  List<l.LatLng> routers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocation.checkLocationPermission().then((value) {
        if (value) {
          ///获取当前的位置
          getLocation.determinePosition().then((lo) {
            initPo = l.LatLng(lo.latitude, lo.longitude);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<sportsTool>();
    stopController.startT();
    getLocation.endGetLoAboutTime();
  }

  ///持续获取经纬度
  getLo() {
    getLocation.startGetLoAboutTime(const Duration(seconds: 1), (value) {
      routers.add(l.LatLng(
          value['latitude']!.toDouble(), value['longitude']!.toDouble()));
      data.update(['router', 'bt']);
    });
  }

  StopController stopController = StopController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: GetBuilder<sportsTool>(
      id: 'sportPage',
      builder: (controller) {
        return IndexedStack(
          index: step,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [shadow.defaultShadow]),
                child: Center(
                  child: customWidget.textBt('开始运动', onTap: () {
                    step = 1;
                    data.update(['sportPage']);

                    ///计时器
                    stopController.startT();

                    ///获取移动经纬度
                    getLo();
                  }),
                ),
              ),
            ),
            Stack(
              children: [
                GetBuilder<sportsTool>(
                  id: 'map',
                  builder: (controller) {
                    if (initPo == null) {
                      return const SizedBox(
                        child: Center(
                          child: TDText('获取经纬度异常'),
                        ),
                      );
                    }
                    return FlutterMap(
                      options: MapOptions(
                        initialCenter: initPo!,
                        initialZoom: 8,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: mapConfig.backGround,
                        ),
                        TileLayer(
                          urlTemplate: mapConfig.street,
                        ),
                        GetBuilder<sportsTool>(
                          id: 'router',
                          builder: (controller) {
                            return PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: routers,
                                  color: Colors.blue,
                                ),
                              ],
                            );
                          },
                        ),
                        CurrentLocationLayer(),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 150,
                  left: 40,
                  child: GetBuilder<sportsTool>(
                    id: 'bt',
                    builder: (controller) {
                      return TDButton(
                        text: '${routers.length}',
                        onTap: () {
                          Get.dialog(
                              barrierDismissible: false,
                              Center(
                                child: Container(
                                  color: Colors.white,
                                  height: 500,
                                  child: ListView.builder(
                                    itemCount: routers.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(5),
                                        child: TDText(
                                            '${routers[index].latitude}_${routers[index].longitude}'),
                                      );
                                    },
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<sportsTool>(
                          id: 'music',
                          builder: (controller) {
                            return TDButton(
                              type: TDButtonType.ghost,
                              child: FaIcon(
                                play
                                    ? FontAwesomeIcons.volumeHigh
                                    : FontAwesomeIcons.volumeXmark,
                                color: play
                                    ? const Color.fromARGB(255, 1, 136, 247)
                                    : const Color.fromARGB(255, 232, 18, 3),
                              ),
                              onTap: () {
                                play = !play;
                                data.update(['music']);
                              },
                            );
                          },
                        ),
                        stopWatch(
                          stopController: stopController,
                        ),
                        TDButton(
                          type: TDButtonType.ghost,
                          child: const FaIcon(
                            FontAwesomeIcons.pause,
                            color: Color.fromARGB(255, 232, 18, 3),
                          ),
                          onTap: () {
                            step = 2;
                            data.update(['sportPage']);
                            stopController.stopT();
                            getLocation.endGetLoAboutTime();
                          },
                        )
                      ],
                    )),
                Positioned(
                    top: 80,
                    child: GetBuilder<sportsTool>(
                      id: 'lo',
                      builder: (controller) {
                        return TDText(
                            '${displayLo?.latitude},${displayLo?.longitude}');
                      },
                    ))
              ],
            ),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [shadow.defaultShadow]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customWidget.textBt('继续', onTap: () {
                      step = 1;
                      data.update(['sportPage']);
                      stopController.startT();
                      getLo();
                    }),
                    customWidget.textBt('结束', onTap: () {
                      step = 0;
                      stopController.init = 0;
                      data.update(['sportPage']);
                    }),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
