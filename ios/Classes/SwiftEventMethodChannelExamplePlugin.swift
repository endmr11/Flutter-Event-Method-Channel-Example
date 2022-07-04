import Flutter
import UIKit

public class SwiftEventMethodChannelExamplePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "example_method_channel", binaryMessenger: registrar.messenger())
    let instance = SwiftEventMethodChannelExamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    /*
    Event Channel Sınıfımızın bağlantıları.
    */  
    let randomDataChannel = FlutterEventChannel(name: "example_event_channel", binaryMessenger: registrar.messenger())
    let randomDataStreamHandler = RandomDataStreamHandler()
    randomDataChannel.setStreamHandler(randomDataStreamHandler)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
  /*
  Event Channel Sınıfımız.
  */
class RandomDataStreamHandler: NSObject, FlutterStreamHandler{
    /*
    Olay geri arama. İkili kullanımı destekler: Flutter'a gönderilecek olay üreticileri, olayları göndermek için bu arayüzün istemcileri olarak hareket eder.
    Flutter'dan gönderilen olayların tüketicileri, alınan olayları işlemek için bu arayüzü uygular.
    */
    var sink: FlutterEventSink?
    /*
    Timer, arka planda çalışan, belirli aralıklar ile tekrarlanmasını istediğimiz olayları yönetmemizi sağlayan esnek yapılardır.
    */
    var timer: Timer?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        /*
        Bir işlemin birden fazla kez belli periyotlarla çalışmasını istersek Timer.scheduledTimer kullanabiliriz.
        */
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomData), userInfo: nil, repeats: true)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        timer?.invalidate()
        return nil
    }

    @objc func sendNewRandomData() {
      guard let sink = sink else { return }
      let randomData = Int.random(in: 1..<10)
      /*
      Flutter tarafına veri yollayan kod kısmı.
      */
      sink("Eren: \(randomData)")
    }
}