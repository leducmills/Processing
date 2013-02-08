import android.os.Bundle;

void onCreate(Bundle savedInstanceState)
{
  super.onCreate(savedInstanceState);

  if(net == null)
    net = new KetaiWiFiDirect(this);    
}

void onResume() {
  super.onResume();

  if (net != null)
  {
    net.onResume();
  }
}

void onPause() {
  super.onPause();
  if (net != null)
    net.onPause();
}

