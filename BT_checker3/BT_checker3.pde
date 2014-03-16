/* DiscoverBluetooth: Written by ScottC on 18 March 2013 using 
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

boolean foundDevice=false; //When this is true, the screen turns green.

//Get the default Bluetooth adapter
BluetoothAdapter bluetooth = BluetoothAdapter.getDefaultAdapter();


/*The startActivityForResult() within setup() launches an 
 Activity which is used to request the user to turn Bluetooth on. 
 The following onActivityResult() method is called when this 
 Activity exits. */
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data){
 if(requestCode==0){
 if(resultCode == RESULT_OK){
 ToastMaster("Bluetooth has been switched ON");
 } else {
 ToastMaster("You need to turn Bluetooth ON !!!");
 }
 }
}



/* Create a Broadcast Receiver that will later be used to 
 receive the names of Bluetooth devices in range. */
BroadcastReceiver myDiscoverer = new myOwnBroadcastReceiver();



void setup(){
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
 //Start bluetooth discovery if it is not doing so already
 if (!bluetooth.isDiscovering()){
 bluetooth.startDiscovery();
 }
 }
}



void draw(){
 //Display a green screen if a device has been found
 if(foundDevice){
 background(10,255,10);
 }
}



/* This BroadcastReceiver will display discovered Bluetooth devices */
public class myOwnBroadcastReceiver extends BroadcastReceiver {
 @Override
 public void onReceive(Context context, Intent intent) {
 
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
 switch(bondyState){
 case 10: mybondState="BOND_NONE";
 break;
 case 11: mybondState="BOND_BONDING";
 break;
 case 12: mybondState="BOND_BONDED";
 break;
 default: mybondState="INVALID BOND STATE";
 break;
 }
 ToastMaster("getBondState() = " + mybondState);
 
 //Change foundDevice to true which will make the screen turn green
 foundDevice=true;
 }
}



/* My ToastMaster function to display a messageBox on the screen */
void ToastMaster(String textToDisplay){
 Toast myMessage = Toast.makeText(getApplicationContext(), 
 textToDisplay,
 Toast.LENGTH_LONG);
 myMessage.setGravity(Gravity.CENTER, 0, 0);
 myMessage.show();
}
