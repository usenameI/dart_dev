package com.example.mobile_dev

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.location.Address
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.app.ComponentActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class LocationHelper(private val context: Context) : LocationListener {

    private var locationManager: LocationManager? = null
    private val timeoutHandler = Handler(Looper.getMainLooper())
    private var isLocationReceived = false
     var mLocationCallBack: LocationCallBack? = null
    init {
        locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    }

    interface LocationCallBack {
        fun setLocation(location: Location?)
//        fun onLocationReceived(latitude: Double, longitude: Double)
//        fun setAddress(address: Address?)
    }

    fun requestLocationPermissions(activity: FlutterActivity) {
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(activity, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 1)
        } else {
            startLocationUpdates()
        }
    }

     fun startLocationUpdates() {
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            timeoutHandler.postDelayed({
                if (!isLocationReceived) {
                    // 超时处理逻辑
                    onTimeout()
                }
            }, 2000)
            locationManager?.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 10f, this, Looper.getMainLooper())

//            locationManager?.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 5000, 10f, this, Looper.getMainLooper())
        }
    }
    // 定位监听
    private val mLocationListener: LocationListener = object : LocationListener {
        override fun onLocationChanged(location: Location) {
            if (mLocationCallBack != null) {
                mLocationCallBack!!.setLocation(location)
            }
        }

        override fun onStatusChanged(provider: String, status: Int, extras: Bundle) {}
        override fun onProviderEnabled(provider: String) {}
        override fun onProviderDisabled(provider: String) {
            // 如果gps定位不可用,改用网络定位
            if (provider == LocationManager.GPS_PROVIDER) {
//                netWorkLocation()
            }
        }
    }



    private fun onTimeout() {
        // 超时处理逻辑
//        Toast.makeText(context, "Location request timed out.", Toast.LENGTH_SHORT).show()
        locationManager?.removeUpdates(this)
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
         locationManager?.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 5000, 10f, this, Looper.getMainLooper())
        }
      locationManager?.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 5000, 10f, this, Looper.getMainLooper())
    }
    override fun onLocationChanged(location: Location) {
        // 当位置更新时调用
        val latitude = location.latitude
        val longitude = location.longitude
        println("log__ggLatitude: $latitude, Longitude: $longitude")
        mLocationCallBack!!.setLocation(location)
//        mLocationCallBack?.onLocationReceived(latitude, longitude)
    }

    override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {
        // 位置提供者状态变化时调用
    }

    override fun onProviderEnabled(provider: String) {
        // 位置提供者启用时调用
    }

    override fun onProviderDisabled(provider: String) {
        // 位置提供者禁用时调用
    }

    fun setLocationCallBack(callback: LocationCallBack) {
        mLocationCallBack = callback
    }
}