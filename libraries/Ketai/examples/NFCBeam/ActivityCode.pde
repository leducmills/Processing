import android.content.Intent;
import android.os.Bundle;

public void onCreate(Bundle savedInstanceState) { 
  super.onCreate(savedInstanceState);
  ketaiNFC = new KetaiNFC(this);
}

public void onNewIntent(Intent intent) { 
  if (ketaiNFC != null)
    ketaiNFC.handleIntent(intent);
}

void onResume()
{
  super.onResume();

  if (ketaiNFC != null)
    ketaiNFC.onResume();
}

public void onPause()
{
  super.onPause();
  if (ketaiNFC != null)
    ketaiNFC.onPause();
}

