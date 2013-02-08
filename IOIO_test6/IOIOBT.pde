public class BluetoothIOIOConnectionDiscovery implements
IOIOConnectionDiscovery {

  private static final String TAG = "BluetoothIOIOConnectionDiscovery";

  @Override
    public void getSpecs(Collection<IOIOConnectionSpec> result) {
    try {
      final BluetoothAdapter adapter = BluetoothAdapter
        .getDefaultAdapter();
      Set<BluetoothDevice> bondedDevices = adapter.getBondedDevices();
      for (BluetoothDevice device : bondedDevices) {
        if (device.getName().startsWith("IOIO")) {
          result.add(new IOIOConnectionSpec(
          BluetoothIOIOConnection.class.getName(), 
          new Object[] { 
            device.getName(), 
            device.getAddress()
          }
          ));
        }
      }
    } 
    catch (SecurityException e) {
      Log.e(TAG, 
      "Did you forget to declare uses-permission of android.permission.BLUETOOTH?");
      throw e;
    }
  }
}




public class BluetoothIOIOConnection implements IOIOConnection {
  private static final String TAG = "BluetoothIOIOConnection";
  private BluetoothSocket socket_ = null;
  private boolean disconnect_ = false;
  private final String name_;
  private final String address_;

  public BluetoothIOIOConnection(String name, String address) {
    name_ = name;
    address_ = address;
  }

  @Override
    public void waitForConnect() throws ConnectionLostException {
    final BluetoothAdapter adapter = BluetoothAdapter.getDefaultAdapter();
    final BluetoothDevice ioioDevice = adapter.getRemoteDevice(address_);
    synchronized (this) {
      if (disconnect_) {
        throw new ConnectionLostException();
      }
      Log.e(TAG, name_ + " Creating socket");
      try {
        socket_ = createSocket(ioioDevice);
      } 
      catch (IOException e) {
        throw new ConnectionLostException(e);
      }
      Log.e(TAG, name_ + " Created socket");
    }
    // keep trying to connect as long as we're not aborting
    while (true) {
      try {
        Log.e(TAG, name_ + "Connecting");
        socket_.connect();
        Log.e(TAG, "Established connection to device " + name_
          + " address: " + address_);
        break; // if we got here, we're connected
      } 
      catch (Exception e) {
        if (disconnect_) {
          throw new ConnectionLostException(e);
        }
        try {
          Thread.sleep(1000);
        } 
        catch (InterruptedException e1) {
        }
      }
    }
  }

  public BluetoothSocket createSocket(final BluetoothDevice device)
  throws IOException {
    try {
      // We're trying to create an insecure socket, which is
      // only supported
      // in API 10 and up. If we fail, we try a secure socket
      // with is in API
      // 7 and up.
      //return device.createInsecureRfcommSocketToServiceRecord(UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"));
    } 
    catch (NoSuchMethodError e) {
      return device.createRfcommSocketToServiceRecord(UUID
        .fromString("00001101-0000-1000-8000-00805F9B34FB"));
    }
  }

  @Override
    public synchronized void disconnect() {
    if (disconnect_) {
      return;
    }
    Log.d(TAG, "Client initiated disconnect");
    disconnect_ = true;
    if (socket_ != null) {
      try {
        socket_.close();
      } 
      catch (IOException e) {
      }
    }
  }

  @Override
    public InputStream getInputStream() throws ConnectionLostException {
    try {
      return socket_.getInputStream();
    } 
    catch (IOException e) {
      throw new ConnectionLostException(e);
    }
  }

  @Override
    public OutputStream getOutputStream() throws ConnectionLostException {
    try {
      return socket_.getOutputStream();
    } 
    catch (IOException e) {
      throw new ConnectionLostException(e);
    }
  }
}

