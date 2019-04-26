package com.trayning.trayning;

import android.os.Bundle;
//import android.support.multidex.MultiDex;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
   // MultiDex.install(this);

    GeneratedPluginRegistrant.registerWith(this);
  }
}
