/* ConnectBluetooth: Written by ScottC on 18 March 2013 using 
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
import android.util.Log;

import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;

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


boolean foundDevice=false; //When true, the screen turns green.
boolean BTisConnected=false; //When true, the screen turns purple.

SikioManager sikio;

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
  
  //size(displayWidth, displayHeight);
  //new SikioManager(this).start();


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
  
}



void draw() {
  //Display a green screen if a device has been found,
  //Display a purple screen when a connection is made to the device
  if (foundDevice) {
    if (BTisConnected) {
      //background(170, 50, 255); // purple screen
       //ToastMaster("Connected!");
    }
    else {
      //background(10, 255, 10); // green screen
      //ToastMaster("Found Device; Not connected");
    }
  }
  text(redVal, 10, 150);
  text(greenVal, 70, 150);
  text(blueVal, 150, 150);
}



/* This BroadcastReceiver will display discovered Bluetooth devices */
public class myOwnBroadcastReceiver extends BroadcastReceiver {
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
      //if(discoveredDeviceName.equals("SeeedBTSlave")){

      if (discoveredDeviceName.equals("IOIO (76:54)")) {
        ToastMaster("Connecting you Now !!");
        unregisterReceiver(myDiscoverer);
        ConnectToBluetooth connectBT = new ConnectToBluetooth(discoveredDevice);
        //Connect to the the device in a new thread
        new Thread(connectBT).start();
      }
    }

    //Notification if bluetooth device is connected
    if (BluetoothDevice.ACTION_ACL_CONNECTED.equals(action)) {
      ToastMaster("CONNECTED _ YAY");
      BTisConnected=true; //turn screen purple
    }
  }
}

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
    } 
    catch (IOException connectException) {
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


/* My ToastMaster function to display a messageBox on the screen */
void ToastMaster(String textToDisplay) {
  Toast myMessage = Toast.makeText(getApplicationContext(), 
  textToDisplay, 
  Toast.LENGTH_SHORT);
  myMessage.setGravity(Gravity.CENTER, 0, 0);
  myMessage.show();
}

