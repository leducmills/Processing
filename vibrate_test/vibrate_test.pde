// Vibrate Android via Processing
// Eric Pavey - www.akeric.com - 2010-10-24
// You must enable VIBRATE in Android -> Sketch Permissions menu!!!

// Imports:
import android.content.Context;
import android.app.Notification;
import android.app.NotificationManager;

// Setup vibration globals:
NotificationManager gNotificationManager;
Notification gNotification;
long[] gVibrate = {0,250,50,125,50,62};

void setup() {
  size(480, 640);
}

void draw() {
  // do nothing...
}

//-----------------------------------------------------------------------------------------
// Override the parent (super) Activity class:
// States onCreate(), onStart(), and onStop() aren't called by the sketch.  Processing is entered
// at the 'onResume()' state, and exits at the 'onPause()' state, so just override them as needed:

void onResume() {
  super.onResume();
  // Create our Notification Manager:
  gNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
  // Create our Notification that will do the vibration:
  gNotification = new Notification();
  // Set the vibration:
  gNotification.vibrate = gVibrate;
}

//-----------------------------------------------------------------------------------------
// Override the parent (super) SurfaceView class to detect for touch events:

public boolean surfaceTouchEvent(MotionEvent event) {
  // If user touches the screen, trigger vibration notification:
  gNotificationManager.notify(1, gNotification);
  return super.surfaceTouchEvent(event);
}
