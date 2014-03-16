/* SendReceiveBytes: Written by ScottC on 25 March 2013 using 
 Processing version 2.0b8
 Tested on a Samsung Galaxy SII, with Android version 2.3.4
 Android ADK - API 10 SDK platform */

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.widget.Toast;
import android.view.Gravity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;

import java.util.UUID;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;
public BluetoothSocket scSocket;


import ioio.lib.spi.*;
import ioio.lib.api.*;
import ioio.lib.util.*;
import ioio.lib.util.android.*;
import ioio.lib.android.bluetooth.*;
import ioio.lib.impl.*;
import sikio.*;
import ioio.lib.android.accessory.*;
import ioio.lib.api.exception.*;

import apwidgets.*;

//Make a widget container and 3 buttons, one for each color.
APWidgetContainer widgetContainer; 
APButton redButton;
APButton greenButton;
APButton blueButton;

//This ia a boolean variable that reads if the LED is on or off. The variable can be
//used in this file or the IOIOThread.pde file. 
boolean lightOn = false;

//Create boolean variables that will be read by our thread when buttons are pressed.
boolean redOn, greenOn, blueOn = false;

int redVal, greenVal, blueVal = 0;

PFont font;


SikioManager sikio;

//new SikioManager(this).start();

boolean foundDevice=false; //When true, the screen turns green.
boolean BTisConnected=false; //When true, the screen turns purple.
//String serverName = "ArduinoBasicsServer";

// Message types used by the Handler
//public static final int MESSAGE_WRITE = 1;
//public static final int MESSAGE_READ = 2;
//String readMessage="";

//Get the default Bluetooth adapter
BluetoothAdapter bluetooth = BluetoothAdapter.getDefaultAdapter();




/*The startActivityForResult() within setup() launches an 
 Activity which is used to request the user to turn Bluetooth on. 
 The following onActivityResult() method is called when this 
 Activity exits. */
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
  if (requestCode==0) {
    if (resultCode == RESULT_OK) {
      ToastMaster("Bluetooth has been switched ON");
    } 
    else {
      ToastMaster("You need to turn Bluetooth ON !!!");
    }
  }
}


/* Create a BroadcastReceiver that will later be used to 
 receive the names of Bluetooth devices in range. */
BroadcastReceiver myDiscoverer = new myOwnBroadcastReceiver();


/* Create a BroadcastReceiver that will later be used to
 identify if the Bluetooth device is connected */
BroadcastReceiver checkIsConnected = new myOwnBroadcastReceiver();


void setup() {
  orientation(LANDSCAPE);
  /*IF Bluetooth is NOT enabled, then ask user permission to enable it */
  if (!bluetooth.isEnabled()) {
    Intent requestBluetooth = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
    startActivityForResult(requestBluetooth, 0);
  }
  
  new SikioManager(this).start();

  //sikio = new SikioManager(this);
  font = createFont(PFont.list()[0], 32);
  textFont(font);

  //Drawing options.
  noStroke(); //disables the outline
  rectMode(CENTER); //place rectangles by their center coordinates

  background(0, 0, 0); //draw black background

  //Create a new container for widgets
  widgetContainer = new APWidgetContainer(this); 

  //Create a new button from x and y pos. and label. Size determined by text content.
  redButton = new APButton(10, 40, "Red"); 
  greenButton = new APButton(70, 40, "Green");
  blueButton = new APButton(150, 40, "Blue");

  //Place buttons in container
  widgetContainer.addWidget(redButton);
  widgetContainer.addWidget(greenButton);
  widgetContainer.addWidget(blueButton);

  /*If Bluetooth is now enabled, then register a broadcastReceiver to report any
   discovered Bluetooth devices, and then start discovering */
  if (bluetooth.isEnabled()) {
    registerReceiver(myDiscoverer, new IntentFilter(BluetoothDevice.ACTION_FOUND));
    registerReceiver(checkIsConnected, new IntentFilter(BluetoothDevice.ACTION_ACL_CONNECTED));

    //Start bluetooth discovery if it is not doing so already
    if (!bluetooth.isDiscovering()) {
      bluetooth.startDiscovery();
    }
  }
}


void draw() {
  //Display a green screen if a device has been found,
  //Display a purple screen when a connection is made to the device
  if (foundDevice) {
    if (BTisConnected) {
      text(redVal, 10, 150);
      text(greenVal, 70, 150);
      text(blueVal, 150, 150);
      //background(170, 50, 255); // purple screen
    }
    else {
      //background(100, 100, 100); // grey screen
    }
  }

  //Display anything received from Arduino
  //text(readMessage, 10, 10);
}


/* This BroadcastReceiver will display discovered Bluetooth devices */
public class myOwnBroadcastReceiver extends BroadcastReceiver {
  //ConnectToBluetooth connectBT;

  @Override
    public void onReceive(Context context, Intent intent) {
    String action=intent.getAction();
    ToastMaster("ACTION:" + action);

    //Notification that BluetoothDevice is FOUND
    if (BluetoothDevice.ACTION_FOUND.equals(action)) {
      //Display the name of the discovered device
      String discoveredDeviceName = intent.getStringExtra(BluetoothDevice.EXTRA_NAME);
      ToastMaster("Discovered: " + discoveredDeviceName);

      //Display more information about the discovered device
      BluetoothDevice discoveredDevice = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
      ToastMaster("getAddress() = " + discoveredDevice.getAddress());
      ToastMaster("getName() = " + discoveredDevice.getName());

      int bondyState=discoveredDevice.getBondState();
      ToastMaster("getBondState() = " + bondyState);

      String mybondState;
      switch(bondyState) {
      case 10: 
        mybondState="BOND_NONE";
        break;
      case 11: 
        mybondState="BOND_BONDING";
        break;
      case 12: 
        mybondState="BOND_BONDED";
        break;
      default: 
        mybondState="INVALID BOND STATE";
        break;
      }
      ToastMaster("getBondState() = " + mybondState);

      //Change foundDevice to true which will make the screen turn green
      foundDevice=true;

      //Connect to the discovered bluetooth device (SeeedBTSlave)
      if (discoveredDeviceName.equals("IOIO (76:54)")) {
        ToastMaster("Connecting you Now !!");
        unregisterReceiver(myDiscoverer);
        ConnectToBluetooth connectBT = new ConnectToBluetooth(discoveredDevice);
        //Connect to the the device in a new thread
        new Thread(connectBT).start();
        //sikio.start();
      }
    }

    //Notification if bluetooth device is connected
    if (BluetoothDevice.ACTION_ACL_CONNECTED.equals(action)) {
      ToastMaster("CONNECTED _ YAY");
      BTisConnected=true; //turn screen purple
      //sikio.start();
    }
  }
}

//public static byte[] stringToBytesUTFCustom(String str) {
//  char[] buffer = str.toCharArray();
//  byte[] b = new byte[buffer.length << 1];
//  for (int i = 0; i < buffer.length; i++) {
//    int bpos = i << 1;
//    b[bpos] = (byte) ((buffer[i]&0xFF00)>>8);
//    b[bpos + 1] = (byte) (buffer[i]&0x00FF);
//  }
//  return b;
//}



public class ConnectToBluetooth implements Runnable {
  private BluetoothDevice btShield;
  private BluetoothSocket mySocket = null;
  private UUID uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

  public ConnectToBluetooth(BluetoothDevice bluetoothShield) {
    btShield = bluetoothShield;
    try {
      mySocket = btShield.createRfcommSocketToServiceRecord(uuid);
    }
    catch(IOException createSocketException) {
      //Problem with creating a socket
      Log.e("ConnectToBluetooth", "Error with Socket");
      println(createSocketException);
    }
  }

  @Override
    public void run() {
    /* Cancel discovery on Bluetooth Adapter to prevent slow connection */
    bluetooth.cancelDiscovery();

    try {
      /*Connect to the bluetoothShield through the Socket. This will block
       until it succeeds or throws an IOException */
      mySocket.connect();
      sikio.start();
      //scSocket=mySocket;
    } 
    catch (IOException connectException) {
      Log.e("ConnectToBluetooth", "Error with Socket Connection");
      try {
        mySocket.close(); //try to close the socket
      }
      catch(IOException closeException) {
      }
      return;
    }
  }

  /* Will cancel an in-progress connection, and close the socket */
  public void cancel() {
    try {
      mySocket.close();
    } 
    catch (IOException e) {
    }
  }
}


//private class SendReceiveBytes implements Runnable {
//  private BluetoothSocket btSocket;
//  private InputStream btInputStream = null;
//  private OutputStream btOutputStream = null;
//  String TAG = "SendReceiveBytes";
//
//  public SendReceiveBytes(BluetoothSocket socket) {
//    btSocket = socket;
//    try {
//      btInputStream = btSocket.getInputStream();
//      btOutputStream = btSocket.getOutputStream();
//    } 
//    catch (IOException streamError) { 
//      Log.e(TAG, "Error when getting input or output Stream");
//    }
//  }
//
//
//  public void run() {
//    byte[] buffer = new byte[1024]; // buffer store for the stream
//    int bytes; // bytes returned from read()
//
//    // Keep listening to the InputStream until an exception occurs
//    while (true) {
//      try {
//        // Read from the InputStream
//        bytes = btInputStream.read(buffer);
//        // Send the obtained bytes to the UI activity
//        mHandler.obtainMessage(MESSAGE_READ, bytes, -1, buffer)
//          .sendToTarget();
//      } 
//      catch (IOException e) {
//        Log.e(TAG, "Error reading from btInputStream");
//        break;
//      }
//    }
//  }


//  /* Call this from the main activity to send data to the remote device */
//  public void write(byte[] bytes) {
//    try {
//      btOutputStream.write(bytes);
//    } 
//    catch (IOException e) { 
//      Log.e(TAG, "Error when writing to btOutputStream");
//    }
//  }

//
///* Call this from the main activity to shutdown the connection */
//public void cancel() {
//  try {
//    btSocket.close();
//  } 
//  catch (IOException e) { 
//    Log.e(TAG, "Error when closing the btSocket");
//  }
//}




/* My ToastMaster function to display a messageBox on the screen */
void ToastMaster(String textToDisplay) {
  Toast myMessage = Toast.makeText(getApplicationContext(), 
  textToDisplay, 
  Toast.LENGTH_SHORT);
  myMessage.setGravity(Gravity.CENTER, 0, 0);
  myMessage.show();
}


//onClickWidget is called when a widget is clicked/touched.
void onClickWidget(APWidget widget) {

  //Each button toggles the boolean associated with that button's led color
  //In the ioio thread, we switch the LED on or off based on the status of that boolean.
  if (widget == redButton) { 
    redOn = !redOn;
    //background(255, 0, 0); //draw red background
    if (redOn == true) { 
      redVal = 255;
    };
    if (redOn == false) { 
      redVal = 0;
    };
  }

  if (widget == greenButton) {
    greenOn = !greenOn;
    //background(255, 0, 0); //draw red background
    if (greenOn == true) { 
      greenVal = 255;
    };
    if (greenOn == false) { 
      greenVal = 0;
    };
  }

  if (widget == blueButton) {
    blueOn = !blueOn;
    //background(255, 0, 0); //draw red background
    if (blueOn == true) { 
      blueVal = 255;
    };
    if (blueOn == false) { 
      blueVal = 0;
    };
  }

  background(redVal, greenVal, blueVal);
}

