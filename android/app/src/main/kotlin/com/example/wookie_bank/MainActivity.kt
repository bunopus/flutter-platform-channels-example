package com.example.wookie_bank

import android.os.VibrationEffect
import android.os.Vibrator
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Context
import android.os.Build
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wookie.bank/vi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "vibrateDevice" -> {
                    Log.i("FLUTTER","${call.arguments}")
                    val duration = (call.arguments as Int).toLong()

                    val message = "Vibrated device for $duration"

                    val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        vibrator.vibrate(VibrationEffect.createOneShot(duration, VibrationEffect.DEFAULT_AMPLITUDE))
                    } else {
                        vibrator.vibrate(duration)
                    }
                    result.success(message)
                }
                else -> result.notImplemented()
            }
        }
    }
}
