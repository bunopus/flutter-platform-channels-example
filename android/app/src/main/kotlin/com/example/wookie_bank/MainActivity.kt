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

        flutterEngine.dartExecutor.binaryMessenger.setMessageHandler(CHANNEL) { message, reply ->

            flutterEngine.dartExecutor.binaryMessenger.send(CHANNEL, message) {

            }

            reply.reply(null)
        }
    }
}
