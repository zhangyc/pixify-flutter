package com.solararrow.pixify

import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.window.SplashScreenView
import androidx.core.view.WindowCompat
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        //GoogleApiAvailability.getInstance().makeGooglePlayServicesAvailable(this);
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen
                .setOnExitAnimationListener { splashScreenView: SplashScreenView -> splashScreenView.remove() }
        }
        super.onCreate(savedInstanceState, persistentState)
    }

}
