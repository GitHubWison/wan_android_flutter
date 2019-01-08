package plug.test.com.example.wanandroidflutter

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import plug.test.com.example.wanandroidflutter.handlers.WanAndroidMethodHandler

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    WanAndroidMethodHandler
            .register(this
                    .registrarFor("plug.test.com.example.wanandroidflutter.handlers.WanAndroidMethodHandler.WanAndroidMethodHandler"))

  }
}
