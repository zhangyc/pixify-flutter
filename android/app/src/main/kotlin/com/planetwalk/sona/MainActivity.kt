package com.planetwalk.sona

import android.os.Bundle
import android.os.PersistableBundle
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        GoogleApiAvailability.getInstance().makeGooglePlayServicesAvailable(this);
        super.onCreate(savedInstanceState, persistentState)
    }

}
