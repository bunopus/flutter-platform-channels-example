package com.example.wookie_bank

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.util.Arrays


class MainActivity : FlutterActivity() {
    private val CHANNEL = "wookie.bank/vi"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine.getDartExecutor().setMessageHandler(CHANNEL) { message, reply ->
            message?.order(ByteOrder.nativeOrder())

            val x:Double = message?.double ?: 0.0
            val n:Int = message?.int ?: 0

            Log.i("FLUTTER", "Received: $x and $n")

            val message2 = ByteBuffer.allocateDirect(12)
            message2.putDouble(x)
            message2.putInt(n)
            
            flutterEngine.getDartExecutor().send(CHANNEL, message2) { _ ->
                Log.i("FLUTTER", "Sent $x and $n")                
            }

            reply?.reply(null)
        }
    }
}
