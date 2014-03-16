/*BluetoothChecker2: Written by ScottC on 17 March 2013
 
 If Bluetooth is already ON when you run this sketch,
 the background will display BLUE.
 
 If Bluetooth is OFF when you run this sketch but you
 agree to turn it on, the background will display GREEN.
 
 If Bluetooth is OFF when you run this sketch and then
 choose to keep it off, the background will display RED. 
 
 =======================================================*/
 
import android.bluetooth.BluetoothAdapter;
import android.content.Intent;

int BACKGND=0; //Set the background to BLUE

//Get the default Bluetooth adapter
BluetoothAdapter bluetooth = BluetoothAdapter.getDefaultAdapter();


/*The startActivityForResult() launches an Activity which is
 used to request the user to turn Bluetooth on. 
 The following onActivityResult() method is called when the 
 Activity exits. */
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data){
 if(requestCode==0){
 if(resultCode == RESULT_OK){
 BACKGND=2; //Set the background to GREEN
 } else {
 BACKGND=1; //Set the background to RED
 }
 }
}

void setup(){
 orientation(LANDSCAPE);
 
 /*IF Bluetooth is NOT enabled, 
 then ask user permission to enable it */
 if (!bluetooth.isEnabled()) {
 Intent requestBluetooth = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
 startActivityForResult(requestBluetooth, 0);
 }
}

void draw(){
 if(BACKGND==0){
 background(10,10,255); //Set background to BLUE
 } else if(BACKGND==1) {
 background(255,10,10); //Set background to RED
 } else {
 background(10,255,10); //Set background to GREEN
 }
}
