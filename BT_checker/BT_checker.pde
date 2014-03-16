/*BluetoothChecker1: Written by ScottC on 17 March 2013
 This will show a red screen if Bluetooth is off, 
 and a green screen when Bluetooth is switched on */

import android.bluetooth.BluetoothAdapter;

BluetoothAdapter bluetooth = BluetoothAdapter.getDefaultAdapter();

void setup(){
 orientation(LANDSCAPE);
}

void draw(){
 if(bluetooth.isEnabled()){
 background(10,255,30);
 } else {
 background(255,10,30);
 }
}
