package com.example.mobile_dev

import java.io.File
import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.mobile_dev.LocationHelper
import android.location.Location
import android.widget.Toast
class MainActivity: FlutterActivity(),LocationHelper.LocationCallBack{
     lateinit var locationHelper: LocationHelper;
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        println("ddddddddd")
        val channel = MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.mobile_dev/android")
        channel.setMethodCallHandler { call, result ->
             if (call.method == "test") {
        locationHelper = LocationHelper(this)
        locationHelper?.setLocationCallBack(this)
        locationHelper.requestLocationPermissions(this)
                result.success("文件不存在")
            } else {
                result.notImplemented()
            }
        }
    }

        override fun setLocation(location: Location?) {
        location?.let {
            val latitude = it.latitude
            val longitude = it.longitude
            // 处理获取到的经纬度
            println("log__ggaaaaaLatitude: $latitude, Longitude: $longitude")
            // Toast.makeText(this, "Latitude: $latitude, Longitude: $longitude", Toast.LENGTH_SHORT).show()
        }
    }
}
