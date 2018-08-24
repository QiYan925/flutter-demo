package cn.ycoder.loan.loanarchive;

import android.os.Bundle;
import cn.ycoder.loan.loanarchive.utils.StatusBarHelper;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    StatusBarHelper.translucent(this);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
