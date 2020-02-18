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

            val n:Int = message?.int ?: 0
            
            val message2 = ByteBuffer.allocateDirect(4)
            message2.putInt(n)
            
            flutterEngine.getDartExecutor().send(CHANNEL, message2) { _ ->
            }

            reply?.reply(null)
        }
    }
}
