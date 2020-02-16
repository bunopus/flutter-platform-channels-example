package com.example.wookie_bank

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import java.nio.ByteBuffer
import java.nio.ByteOrder

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wookie.bank/vi"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine.getDartExecutor().setMessageHandler(CHANNEL) { message, reply ->
            message?.order(ByteOrder.nativeOrder())
            val x = message?.double
            val n = message?.int
            Log.i("FLUTTER", "Received: $x and $n")
            reply?.reply(null)
        }
    }
}
