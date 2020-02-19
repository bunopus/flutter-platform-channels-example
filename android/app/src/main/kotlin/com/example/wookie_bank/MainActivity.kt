package com.example.wookie_bank

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec


class MainActivity : FlutterActivity() {
    private val CHANNEL = "wookie.bank/vi"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor, CHANNEL, StringCodec.INSTANCE)
        channel.setMessageHandler { message, reply -> reply.reply("$message to you!") }
    }
}
