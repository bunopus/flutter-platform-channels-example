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

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wookie.bank/vi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "vibrateDevice" -> {
                    val message = "Vibrated device for 2500ms"
                    val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        vibrator.vibrate(VibrationEffect.createOneShot(2500, VibrationEffect.DEFAULT_AMPLITUDE))
                    } else {
                        vibrator.vibrate(2500)
                    }
                    result.success(message)
                }
                else -> result.notImplemented()
            }
        }
    }
}
