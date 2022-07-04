package com.eventmethodchannel.event_method_channel_example

import android.os.Handler
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

class EventMethodChannelExamplePlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var randomDataEventChannel : EventChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "example_method_channel")
    channel.setMethodCallHandler(this)

    /*
    Event Channel Sınıfımızın bağlantıları.
    */  
    randomDataEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "example_event_channel")
    randomDataEventChannel.setStreamHandler(RandomDataStreamHandler())
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

  /*
  Event Channel Sınıfımız.
  */
class RandomDataStreamHandler: EventChannel.StreamHandler {
  /*
  Olay geri arama. İkili kullanımı destekler: Flutter'a gönderilecek olay üreticileri, olayları göndermek için bu arayüzün istemcileri olarak hareket eder.
  Flutter'dan gönderilen olayların tüketicileri, alınan olayları işlemek için bu arayüzü uygular.
  */
  var sink: EventChannel.EventSink? = null
  /*
  Handler, arka planda çalışan, belirli aralıklar ile tekrarlanmasını istediğimiz olayları yönetmemizi sağlayan esnek yapılardır
  */
  var handler: Handler? = null

  /*
  Bir işlemin birden fazla kez belli periyotlarla çalışmasını istersek Runnable kullanabiliriz.
   */
  private val runnable = Runnable {
    sendNewRandomData()
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    sink = events
    handler = Handler()
    handler?.post(runnable)
  }

  override fun onCancel(arguments: Any?) {
    sink = null
    handler?.removeCallbacks(runnable)
  }

  fun sendNewRandomData() {
    val randomData = Random().nextInt(9)
    /*
    Flutter tarafına veri yollayan kod kısmı.
    */
    sink?.success("Eren: $randomData ")
    handler?.postDelayed(runnable, 1000)
  }


}