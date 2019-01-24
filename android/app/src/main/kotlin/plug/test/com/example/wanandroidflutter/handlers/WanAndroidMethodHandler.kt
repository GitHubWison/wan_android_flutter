package plug.test.com.example.wanandroidflutter.handlers

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import plug.test.com.example.wanandroidflutter.actiivties.WebViewActivity

class WanAndroidMethodHandler(private val activity: Activity) :MethodChannel.MethodCallHandler{
    companion object {
        @JvmStatic
        fun register(registrar:PluginRegistry.Registrar)
        {
            var methodChannel = MethodChannel(registrar.messenger(),"native.wan.android")
            methodChannel.setMethodCallHandler(WanAndroidMethodHandler(registrar.activity()))
        }
    }
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "showWebView" -> {
                val url = methodCall.argument<String>("link")
                val title = methodCall.argument<String>("title")
                Toast.makeText(activity,url,Toast.LENGTH_LONG).show()
                val intent = Intent(activity,WebViewActivity::class.java)
                intent.putExtra("url",url)
                intent.putExtra("title",title)
                activity.startActivity(intent)
            }
            "showToast"->{
                val msg = methodCall.argument<String>("msg")
                Toast.makeText(activity,msg,Toast.LENGTH_LONG).show()
            }
            else -> {
            }
        }
    }

}