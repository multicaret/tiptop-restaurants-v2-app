package app.trytiptop.tiptop_restaurant

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import android.preference.PreferenceManager
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL = "io.trytiptop.native_channel"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.e("configureFlutterEngine", "configureFlutterEngine")
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            Log.e("called method name", call.method)
            if (call.method.equals("change_language")) {
                val code = call.argument("locale") as String?
                val sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context)
                sharedPreferences.edit().putString("locale", code).apply()
                result.success("locale set successfully")
            }
            else result.success("no method was called")
        }
    }

    override fun attachBaseContext(newBase: Context) {
        val sharedPreferences = PreferenceManager.getDefaultSharedPreferences(newBase)
        val code = sharedPreferences.getString("locale", "ar")
        val locale = Locale(code ?: "ar")
        Locale.setDefault(locale)
        val resources = newBase.resources
        val config = Configuration(resources.configuration)
        Log.e("locale change ", locale.toString())
        config.setLocale(locale)
        super.attachBaseContext(newBase.createConfigurationContext(config))
        Log.e("attachBaseContext", "attachBaseContext")
    }

//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);

//        val channel = "tiptop/salesIQ"
//
//        MethodChannel(getFlutterView(), channel).setMethodCallHandler { call, result ->
//            if (call.method == "initLiveChat") {
//                val languageCode: String? = call.argument("languageCode")
//                val userName: String? = call.argument("userName")
//                val userEmail: String? = call.argument("userEmail")
//                val isAuth: Boolean? = call.argument("isAuth")
//
//                ZohoLiveChat.Chat.show()
//                ZohoLiveChat.Chat.setVisibility(ChatComponent.prechatForm, !isAuth!!)
//                ZohoLiveChat.Chat.setLanguage(languageCode);
//
//                ZohoSalesIQ.Visitor.setName(userName)
//                ZohoSalesIQ.Visitor.setEmail(userEmail)
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    //setting up Flutter Engine View
//    private fun getFlutterView(): BinaryMessenger? {
//        return flutterEngine?.dartExecutor?.binaryMessenger
//    }
}
