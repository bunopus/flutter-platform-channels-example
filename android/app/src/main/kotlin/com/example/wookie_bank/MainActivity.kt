package com.example.wookie_bank

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.lifecycle.LifecycleRegistry
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import android.os.Bundle
import androidx.lifecycle.Lifecycle
import java.util.*
import java.util.concurrent.TimeUnit


class MainActivity : FlutterActivity(), SensorEventListener {
    private var manager: SensorManager? = null
    private var sink: EventChannel.EventSink? = null
    private val CHANNEL = "wookie.bank/vi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onCancel(arguments: Any?) {
                        sink = null
                    }

                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        sink = events
                    }

                }
        )
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        manager = getSystemService(SENSOR_SERVICE) as SensorManager
    }

    override fun onResume() {
        super.onResume()
        manager?.registerListener(this,
                manager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), 100)
    }

    override fun onPause() {
        super.onPause()
        manager?.unregisterListener(this)
    }

    override fun onSensorChanged(sensorEvent: SensorEvent) {
        sink?.success(sensorEvent.values[1])
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

}
