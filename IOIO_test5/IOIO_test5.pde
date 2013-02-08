/* IOIO Test 4 - 
 * Toggling a real LED on pin 3, and reading values from a potentiometer on pin 37 through Processing in Android mode
 * by Ben Leduc-Mills
 * This code is Beerware - feel free to reuse and credit me, and if it helped you out and we meet someday, buy me a beer.
 */

//import apwidgets.*;
//
//import ioio.lib.util.*;
//import ioio.lib.impl.*;
//import ioio.lib.api.*;
//import ioio.lib.api.exception.*;
//import ioio.lib.bluetooth.*;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import java.util.ArrayList;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;

private static final int REQUEST_ENABLE_BT = 3;
ArrayList devices;
BluetoothAdapter adapter;
BluetoothDevice device;
BluetoothSocket socket;
InputStream ins;
OutputStream ons;
boolean registered = false;
PFont f1;
PFont f2;
int state;
String error;
byte value;


BroadcastReceiver receiver = new BroadcastReceiver()
{
    public void onReceive(Context context, Intent intent)
    {
        println("onReceive");
        String action = intent.getAction();
 
        if (BluetoothDevice.ACTION_FOUND.equals(action))
        {
            BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
            println(device.getName() + " " + device.getAddress());
            devices.add(device);
        }
        else if (BluetoothAdapter.ACTION_DISCOVERY_STARTED.equals(action))
        {
          state = 0;
          println("Started Search");
        }
        else if (BluetoothAdapter.ACTION_DISCOVERY_FINISHED.equals(action))
        {
          state = 1;
          println("Finished Search");
        }
 
    }
};


void setup() {
//  thread1 = new myIOIOThread("thread1", 100);
//  thread1.start();

  frameRate(25);
  f1 = loadFont("Arial",20,true);
  f2 = loadFont("Arial",15,true);
  stroke(255);
}

void draw() {
  switch(state)
  {
    case 0:
      listDevices("Looking for devices", color(255, 0, 0));
      break;
    case 1:
      listDevices("Choose Device", color(0, 255, 0));
      break;
    case 2:
      deviceConnected();
      break;
    case 3:
      showData();
      break;
    case 4:
      showError();
      break;
  }
}


void onStart()
{
  super.onStart();
  println("onStart");
  adapter = BluetoothAdapter.getDefaultAdapter();
  if (adapter != null)
  {
    if (!adapter.isEnabled())
    {
        Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
    }
    else
    {
      begin();
    }
  }
}


void onStop()
{
  println("onStop");
  /*
  if(registrado)
  {
    unregisterReceiver(receptor);
  }
  */
 
  if(socket != null)
  {
    try
    {
      socket.close();
    }
    catch(IOException e)
    {
      println(e);
    }
  }
  super.onStop();
}


void onActivityResult (int requestCode, int resultCode, Intent data)
{
  println("onActivityResult");
  if(resultCode == RESULT_OK)
  {
    println("RESULT_OK");
    begin();
  }
  else
  {
    println("RESULT_CANCELED");
    state = 4;
    error = "No Bluetooth enabled";
  }
}

void mouseReleased()
{
  switch(state)
  {
    case 0:
      /*
      if(registrado)
      {
        adaptador.cancelDiscovery();
      }
      */
      break;
    case 1:
      checkElection();
      break;
    case 3:
      checkButton();
      break;
  }
}


void begin()
{
    devices = new ArrayList();
    /*
    registerReceiver(receptor, new IntentFilter(BluetoothDevice.ACTION_FOUND));
    registerReceiver(receptor, new IntentFilter(BluetoothAdapter.ACTION_DISCOVERY_STARTED));
    registerReceiver(receptor, new IntentFilter(BluetoothAdapter.ACTION_DISCOVERY_FINISHED));
    registrado = true;
    adaptador.startDiscovery();
    */
    for (BluetoothDevice device : adapter.getBondedDevices())
    {
        devices.add(device);
    }
    state = 1;
}


void listDevices(String s, color c)
{
  background(0);
  textFont(f1);
  fill(c);
  text(s, 0, 20);
  if(devices != null)
  {
    for(int i = 0; i < devices.size(); i++)
    {
      BluetoothDevice device = (BluetoothDevice) devices.get(i);
      fill(255,255,0);
      int position = 50 + (i * 55);
      if(device.getName() != null)
      {
        text(device.getName(),0, position);
      }
      fill(180,180,255);
      text(device.getAddress(),0, position + 20);
      fill(255);
      line(0, position + 30, 319, position + 30);
    }
  }
}


void checkElection()
{
  int elected = (mouseY - 50) / 55;
  if(elected < devices.size())   
  {     
    device = (BluetoothDevice) devices.get(elected);     
    println(device.getName());     
    state = 2;   
  } 
} 


void deviceConnected() 
{   
  try   
  {     
    socket = device.createRfcommSocketToServiceRecord(UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"));
    /*     
      Method m = dispositivo.getClass().getMethod("createRfcommSocket", new Class[] { int.class });     
      socket = (BluetoothSocket) m.invoke(dispositivo, 1);             
    */     
    socket.connect();     
    ins = socket.getInputStream();     
    ons = socket.getOutputStream();     
    state = 3;   
  }   
  catch(Exception e)   
  {     
    state = 4;     
    error = e.toString();     
    println(error);   
  } 
}


void showData() 
{   
  try
  {     
    while(ins.available() > 0)
    {
      value = (byte)ins.read();
    }
  }
  catch(Exception e)
  {
    state = 4;
    error = e.toString();
    println(error);
  }
  background(0);
  fill(255);
  text(value, width / 2, height / 2);
  stroke(255, 255, 0);
  fill(255, 0, 0);
  rect(120, 400, 80, 40);
  fill(255, 255, 0);
  text("Button", 135, 425);
}


void checkButton()
{
  if(mouseX > 120 && mouseX < 200 && mouseY > 400 && mouseY < 440)
  {
    try
    {
        ons.write(0);
    }
    catch(Exception e)
    {
      state = 4;
      error = e.toString();
      println(error);
    }
  }
}

void showError()
{
  background(255, 0, 0);
  fill(255, 255, 0);
  textFont(f2);
  textAlign(CENTER);
  translate(width / 2, height / 2);
  rotate(3 * PI / 2);
  text(error, 0, 0);
}

