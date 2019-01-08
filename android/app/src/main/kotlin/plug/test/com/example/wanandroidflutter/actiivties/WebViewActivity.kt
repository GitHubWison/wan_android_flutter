package plug.test.com.example.wanandroidflutter.actiivties

import android.databinding.DataBindingUtil
import android.os.Bundle
import android.widget.LinearLayout
import com.just.agentweb.AgentWeb
import io.flutter.app.FlutterActivity
import plug.test.com.example.wanandroidflutter.R
import plug.test.com.example.wanandroidflutter.databinding.ActivityWebViewLayoutBinding

class WebViewActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        DataBindingUtil
                .setContentView<ActivityWebViewLayoutBinding>(this, R.layout.activity_web_view_layout)
                .let {
                    it.title = intent.getStringExtra("title")
                    AgentWeb.with(this)
                            .setAgentWebParent(it.mainWvLl, LinearLayout.LayoutParams(-1, -1))
                            .useDefaultIndicator()
                            .createAgentWeb()
                            .ready()
                            .go(intent.getStringExtra("url"))
                }

    }


}