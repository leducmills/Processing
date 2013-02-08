import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import javax.microedition.khronos.opengles.GL10;

import ketai.ui.KetaiAlertDialog;

import processing.core.PImage;
import processing.core.PApplet;

import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.graphics.ImageFormat;
import android.graphics.SurfaceTexture;
import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.CameraInfo;
//import android.hardware.Camera.Face;
//import android.hardware.Camera.FaceDetectionListener;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.PictureCallback;
import android.hardware.Camera.PreviewCallback;
import android.hardware.Camera.Size;
import android.media.MediaScannerConnection;
import android.media.MediaScannerConnection.OnScanCompletedListener;
import android.net.Uri;
import android.opengl.GLES20;
import android.os.Environment;
import android.view.Surface;

public class KetaiCamera extends PImage {
        private Camera camera;
        private int[] myPixels;
        protected Method onPreviewEventMethod, onPreviewEventMethodPImage,
                        onSavePhotoEventMethod, onFaceDetectionEventMethod;
        private int frameWidth, frameHeight, cameraFPS, cameraID;
        private int photoWidth, photoHeight;
        public boolean isStarted, enableFlash, isRGBPreviewSupported;
        private String savePhotoPath = "";
        KetaiCamera self;
        String SAVE_DIR = "";
        // Thread runner;
        boolean available = false;
        // public boolean isDetectingFaces = false;
        boolean supportsFaceDetection = false;
        SurfaceTexture mTexture;

        // private ketaiFaceDetectionListener facelistener;

        public KetaiCamera(PApplet pParent, int _width, int _height,
                        int _framesPerSecond) {
                super(_width, _height, PImage.ARGB);
                parent = pParent;
                frameWidth = _width;
                frameHeight = _height;
                photoWidth = frameWidth;
                photoHeight = frameHeight;
                cameraFPS = _framesPerSecond;
                isStarted = false;
                myPixels = new int[_width * _height];
                self = this;
                isRGBPreviewSupported = false;
                enableFlash = false;
                cameraID = 0;
                // facelistener = new ketaiFaceDetectionListener(this);

                try {
                        // the following uses reflection to see if the parent
                        // exposes the callback method. The first argument is the method
                        // name followed by what should match the method argument(s)
                        onPreviewEventMethod = parent.getClass().getMethod(
                                        "onCameraPreviewEvent");
                        PApplet.println("KetaiCamera found onCameraPreviewEvent in parent... ");
                } catch (Exception e) {
                        // no such method, or an error.. which is fine, just ignore
                        onPreviewEventMethod = null;
                        PApplet.println("KetaiCamera did not find onCameraPreviewEvent Method: "
                                        + e.getMessage());
                }

                try {
                        onPreviewEventMethodPImage = parent.getClass().getMethod(
                                        "onCameraPreviewEvent", new Class[] { KetaiCamera.class });
                        PApplet.println("KetaiCamera found onCameraPreviewEvent for PImage in parent... ");
                } catch (Exception e) {
                        // no such method, or an error.. which is fine, just ignore
                        onPreviewEventMethodPImage = null;
                        PApplet.println("KetaiCamera did not find onCameraPreviewEvent for Image Method: "
                                        + e.getMessage());
                }

//                try {
//                        onFaceDetectionEventMethod = parent.getClass().getMethod(
//                                        "onFaceDetectionEvent", new Class[] { KetaiFace[].class });
//                        PApplet.println("KetaiCamera found onFaceDetectionEvent in parent... ");
//                } catch (Exception e) {
//                        // no such method, or an error.. which is fine, just ignore
//                        onFaceDetectionEventMethod = null;
//                        PApplet.println("KetaiCamera did not find onFaceDetectionEvent Method: "
//                                        + e.getMessage());
//                }

                try {
                        onSavePhotoEventMethod = parent.getClass().getMethod(
                                        "onSavePhotoEvent", new Class[] { String.class });
                        PApplet.println("KetaiCamera found onSavePhotoEvent method in parent... ");
                } catch (Exception e) {
                        // no such method, or an error.. which is fine, just ignore
                        onSavePhotoEventMethod = null;
                        PApplet.println("KetaiCamera did not find onSavePhotoEventMethod Method: "
                                        + e.getMessage());
                }

                // we'll store our photos in a folder named after our application!
                PackageManager pm = parent.getApplicationContext().getPackageManager();
                ApplicationInfo ai;
                try {
                        ai = pm.getApplicationInfo(parent.getApplicationContext()
                                        .getPackageName(), 0);
                } catch (final NameNotFoundException e) {
                        ai = null;
                }
                SAVE_DIR = (String) (ai != null ? pm.getApplicationLabel(ai)
                                : "unknownApp");

                PApplet.println("KetaiCamera completed instantiation... "
                                + parent.g.toString());
        }

        // lock any auto settings to keep from constant adjustments
        public void manualSettings() {
                if (camera == null)
                        return;
                PApplet.println("KetaiCamera: locking camera settings...");
                Parameters cameraParameters = camera.getParameters();
                // camera.cancelAutoFocus();
                if (cameraParameters.isAutoExposureLockSupported())
                        cameraParameters.setAutoExposureLock(true);

                if (cameraParameters.isAutoWhiteBalanceLockSupported())
                        cameraParameters.setAutoWhiteBalanceLock(true);
                else {

                        List<String> w = cameraParameters.getSupportedWhiteBalance();
                        for (String s : w) {
                                if (s.equalsIgnoreCase(Parameters.WHITE_BALANCE_CLOUDY_DAYLIGHT)) {
                                        cameraParameters.setWhiteBalance(s);
                                        break;
                                }
                        }
                }

                List<String> fModes = cameraParameters.getSupportedFocusModes();
                for (String s : fModes) {
                        if (s.equalsIgnoreCase(Parameters.FOCUS_MODE_FIXED)) {
                                PApplet.println("Fixed focus mode supported!");
                                cameraParameters.setFocusMode(Parameters.FOCUS_MODE_FIXED);
                        }
                }

                try {
                        camera.setParameters(cameraParameters);
                } catch (RuntimeException x) {
                        PApplet.println("Failed to set parameters to manual."
                                        + x.getMessage());
                }
                PApplet.println("KetaiCamera manualSettings: "
                                + camera.getParameters().flatten());
        }

        // public void startFaceDetection() {
        // isDetectingFaces = true;
        // if (camera != null && isStarted && supportsFaceDetection) {
        // if (isDetectingFaces) {
        // camera.setFaceDetectionListener(this);
        // camera.startFaceDetection();
        // }
        // }
        // }

        // public void stopFaceDetection() {
        // isDetectingFaces = false;
        // if (camera != null && isStarted && supportsFaceDetection)
        // camera.stopFaceDetection();
        // }

        public void setZoom(int _zoom) {
                if (camera == null)
                        return;

                Parameters cameraParameters = camera.getParameters();
                if (_zoom > cameraParameters.getMaxZoom())
                        _zoom = cameraParameters.getMaxZoom();
                else if (_zoom < 0)
                        _zoom = 0;

                cameraParameters.setZoom(_zoom);
                camera.setParameters(cameraParameters);
        }

        public int getZoom() {
                if (camera == null)
                        return 0;
                Parameters p = camera.getParameters();
                return (p.getZoom());
        }

        // allow camera settings to auto-adjust
        // mainly concerned with focus/white balance
        //
        public void autoSettings() {
                if (camera == null)
                        return;

                PApplet.println("KetaiCamera: setting camera settings to auto...");
                Parameters cameraParameters = camera.getParameters();
                if (cameraParameters.isAutoExposureLockSupported())
                        cameraParameters.setAutoExposureLock(false);
                if (cameraParameters.isAutoWhiteBalanceLockSupported())
                        cameraParameters.setAutoWhiteBalanceLock(false);

                List<String> fModes = cameraParameters.getSupportedFocusModes();
                for (String s : fModes) {
                        PApplet.println("FocusMode: " + s);
                        if (s.equalsIgnoreCase(Parameters.FOCUS_MODE_CONTINUOUS_PICTURE))
                                cameraParameters
                                                .setFocusMode(Parameters.FOCUS_MODE_CONTINUOUS_PICTURE);
                }

                camera.setParameters(cameraParameters);
                camera.autoFocus(autofocusCB);
                PApplet.println("KetaiCamera autoSettings: "
                                + camera.getParameters().flatten());
        }

        public String dump() {
                String result = "";
                if (camera == null)
                        return result;

                Parameters p = camera.getParameters();
                result += "Zoom: " + p.getZoom() + "\n";

                result += "White Balance: " + p.getWhiteBalance() + "\n";

                if (p.isAutoWhiteBalanceLockSupported())
                        result += "\t Lock supported, state: "
                                        + p.getAutoWhiteBalanceLock() + "\n";
                else
                        result += "\t Lock NOT supported\n";

                float[] f = new float[3];
                String fd = "";

                p.getFocusDistances(f);
                for (int i = 0; i < f.length; i++)
                        fd += String.valueOf(f[i]) + " ";

                result += "Focal Distances: " + fd + " \n";
                result += "Focal Depth: " + p.getFocalLength() + "\n";
                result += "Focus Mode: " + p.getFocusMode() + "\n";

                result += "Exposure: " + p.getExposureCompensation() + "\n";
                if (p.isAutoExposureLockSupported())
                        result += "\t Lock supported, state: " + p.getAutoExposureLock()
                                        + "\n";
                else
                        result += "\t Lock NOT supported\n";

                result += "Native camera face detection support: "
                                + supportsFaceDetection;

                return result;
        }

        public void setSaveDirectory(String _dirname) {
                SAVE_DIR = _dirname;
        }

        public int getPhotoWidth() {
                return photoWidth;
        }

        public int getPhotoHeight() {
                return photoHeight;
        }

        public void setPhotoSize(int width, int height) {
                photoWidth = width;
                photoHeight = height;
                determineCameraParameters();
        }

        public void enableFlash() {
                enableFlash = true;
                if (camera == null)
                        return;

                Parameters cameraParameters = camera.getParameters();
                cameraParameters.setFlashMode(Parameters.FLASH_MODE_TORCH);
                // check if flash is supported before setting it
                try {
                        camera.setParameters(cameraParameters);
                } catch (Exception x) {
                }// doesnt support flash...its ok...
        }

        public void disableFlash() {
                enableFlash = false;
                if (camera == null)
                        return;

                Parameters cameraParameters = camera.getParameters();
                cameraParameters.setFlashMode(Parameters.FLASH_MODE_OFF);
                try {
                        camera.setParameters(cameraParameters);
                } catch (Exception x) {
                } // nopers
        }

        public void setCameraID(int _id) {
                if (_id < Camera.getNumberOfCameras())
                        cameraID = _id;
        }

        public int getCameraID() {
                return cameraID;
        }

        public boolean start() {
                try {

                        PApplet.println("KetaiCamera: opening camera...");
                        if (camera == null)
                                try {
                                        camera = Camera.open(cameraID);
                                } catch (Exception x) {
                                        KetaiAlertDialog.popup(parent, "KetaiCamera",
                                                        "Failed to connect to Camera.\n" + x.getMessage());
                                        PApplet.println("Failed to open camera for camera ID: "
                                                        + cameraID + ":" + x.getMessage());
                                        return false;
                                }
                        Parameters cameraParameters = camera.getParameters();
                        List<Integer> list = cameraParameters.getSupportedPreviewFormats();

                        PApplet.println("Supported preview modes...");
                        for (Integer i : list) {

                                if (i == ImageFormat.RGB_565) {
                                        PApplet.println("RGB Image preview supported!!!!(try better resolutions/fps combos)");
                                        isRGBPreviewSupported = true;
                                }

                                PApplet.println("\t" + i);
                        }

                        if (isRGBPreviewSupported)
                                cameraParameters.setPreviewFormat(ImageFormat.RGB_565);
                        // else if (isNV21Supported)
                        // cameraParameters.setPreviewFormat(ImageFormat.NV21);
                        // else
                        // PApplet.println("Camera does not appear to provide data in a format we can convert. Sorry.");
                        PApplet.println("default imageformat:"
                                        + cameraParameters.getPreviewFormat());

                        List<String> flashmodes = cameraParameters.getSupportedFlashModes();
                        if (flashmodes != null && flashmodes.size() > 0) {
                                for (String s : flashmodes)
                                        PApplet.println("supported flashmode: " + s);
                                if (enableFlash)
                                        cameraParameters.setFlashMode(Parameters.FLASH_MODE_TORCH);
                                else
                                        cameraParameters.setFlashMode(Parameters.FLASH_MODE_OFF);
                        } else
                                PApplet.println("No flash support.");

                        int rotation = parent.getWindowManager().getDefaultDisplay()
                                        .getRotation();
                        int degrees = 0;
                        switch (rotation) {
                        case Surface.ROTATION_0:
                                degrees = 0;
                                break;
                        case Surface.ROTATION_90:
                                degrees = 90;
                                break;
                        case Surface.ROTATION_180:
                                degrees = 180;
                                break;
                        case Surface.ROTATION_270:
                                degrees = 270;
                                break;

                        }
                        Camera.CameraInfo info = new CameraInfo();
                        Camera.getCameraInfo(cameraID, info);

                        int result;
                        if (info.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
                                result = (info.orientation + degrees) % 360;
                                result = (360 - result) % 360; // compensate the mirror
                        } else { // back-facing
                                result = (info.orientation - degrees + 360) % 360;
                        }
                        camera.setDisplayOrientation(result);

                        camera.setParameters(cameraParameters);
                        camera.setPreviewCallback(previewcallback);

                        // set sizes
                        determineCameraParameters();

                        try {
                                parent.runOnUiThread(new Runnable() {
                                        public void run() {

                                                int[] textures = new int[1];
                                                // generate one texture pointer and bind it as an
                                                // external texture so preview will start
                                                GLES20.glGenTextures(1, textures, 0);
                                                GLES20.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);

                                                int texture_id = textures[0];
                                                mTexture = new SurfaceTexture(texture_id);

                                                try {
                                                        camera.setPreviewTexture(mTexture);
                                                } catch (IOException iox) {
                                                }
                                        }
                                });
                                camera.startPreview();
                        } catch (NoClassDefFoundError x) {
                                camera.startPreview();
                        }
                        isStarted = true;

                        // if (supportsFaceDetection && isDetectingFaces) {
                        // camera.setFaceDetectionListener(this);
                        // camera.startFaceDetection();
                        // }

                        PApplet.println("Using preview format: "
                                        + camera.getParameters().getPreviewFormat());

                        PApplet.println("Preview size: " + frameWidth + "x" + frameHeight
                                        + "," + cameraFPS);
                        PApplet.println("Photo size: " + photoWidth + "x" + photoHeight);

                        return true;
                } catch (Exception x) {
                        x.printStackTrace();
                        if (camera != null)
                                camera.release();
                        PApplet.println("Exception caught while trying to connect to camera service.  Please check your sketch permissions or that another application is not using the camera.");
                        return false;
                }
        }

        public boolean isFlashEnabled() {
                return enableFlash;
        }

        public boolean savePhoto() {
                if (camera != null && isStarted()) {
                        savePhotoPath = "";
                        return savePhoto(savePhotoPath);
                }
                return false;
        }

        public boolean savePhoto(String _filename) {
                String filename = "";

                // we have an absolute file pathname....
                if (_filename.startsWith(File.separator)) {
                        savePhotoPath = _filename;
                } else {
                        // construct the path using the filename specified...
                        if (_filename.equalsIgnoreCase("")) {
                                String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss")
                                                .format(new Date());

                                filename = "IMG_" + timeStamp + ".jpg";
                        } else
                                filename = _filename;

                        File mediaStorageDir = new File(
                                        Environment
                                                        .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                                        SAVE_DIR);

                        // Create the storage directory if it does not exist
                        if (!mediaStorageDir.exists()) {
                                if (!mediaStorageDir.mkdirs()) {
                                        PApplet.println("failed to create directory to save photo: "
                                                        + mediaStorageDir.getAbsolutePath());
                                        return false;
                                }
                        }
                        savePhotoPath = mediaStorageDir.getAbsolutePath() + File.separator
                                        + filename;

                }// end creating savePath...

                // test for file write, return false if error
                // otherwise call camera to save
                PApplet.println("Calculated photo path: " + savePhotoPath);

                try {
                        FileOutputStream outStream = new FileOutputStream(savePhotoPath);
                        outStream.write(1);
                        outStream.close();
                        File f = new File(savePhotoPath);
                        if (!f.delete())
                                PApplet.println("Failed to remove temp photoFile while testing permissions..oops");
                } catch (FileNotFoundException x) {
                        PApplet.println("Failed to save photo to " + savePhotoPath + "\n"
                                        + x.getMessage());
                        return false;
                } catch (IOException e) {
                        PApplet.println("Failed to save photo to " + savePhotoPath + "\n"
                                        + e.getMessage());
                        return false;
                }

                if (camera != null && isStarted())
                        camera.takePicture(null, null, jpegCallback);

                return true;
        }

        public void onResume() {
                if (camera == null) {
                        camera = Camera.open();
                }

                if (isStarted())
                        return;

                try {
                        camera.reconnect();
                        camera.startPreview();
                        isStarted = true;
                } catch (IOException e) {
                        e.printStackTrace();
                        start();
                }
        }

        public synchronized void read() {
                if (pixels.length != frameWidth * frameHeight)
                        pixels = new int[frameWidth * frameHeight];
                synchronized (pixels) {
                        //loadPixels();
                        System.arraycopy(myPixels, 0, pixels, 0, frameWidth * frameHeight);
                        available = false;
                        updatePixels();
                }
        }

        public boolean isStarted() {
                return isStarted;
        }

        int lastProcessedFrame = 0;

        PreviewCallback previewcallback = new PreviewCallback() {
                public void onPreviewFrame(byte[] data, Camera camera) {
                        if ((parent.millis() - lastProcessedFrame) < (1000 / cameraFPS))
                                return;

                        lastProcessedFrame = parent.millis();

                        if (camera == null || !isStarted)
                                return;

                        if (myPixels == null || myPixels.length != frameWidth * frameHeight)
                                myPixels = new int[frameWidth * frameHeight];

                        if (isRGBPreviewSupported)
                                System.arraycopy(myPixels, 0, data, 0, myPixels.length);
                        else
                                decodeYUV420SP(data);

                        if (myPixels == null)
                                return;

                        if (onPreviewEventMethod != null && myPixels != null)
                                try {
                                        onPreviewEventMethod.invoke(parent);
                                } catch (Exception e) {
                                        PApplet.println("Disabling onCameraPreviewEvent() because of an error:"
                                                        + e.getMessage());
                                        
                                        e.printStackTrace();
                                        
                                }

                        if (onPreviewEventMethodPImage != null && myPixels != null) {
                                try {
                                        onPreviewEventMethodPImage.invoke(parent,
                                                        new Object[] { (PImage) self });
                                } catch (Exception e) {
                                        PApplet.println("Disabling onCameraPreviewEvent(KetaiCamera) because of an error:"
                                                        + e.getMessage());
                                        e.printStackTrace();
                                        onPreviewEventMethodPImage = null;
                                }
                        }

                        // if (!self.supportsFaceDetection && self.isDetectingFaces) {
                        // PApplet.println("Finding faces in preview using CV");
                        // kFace[] faces = FaceFinder.findFaces((PImage) self, 5);
                        //
                        // int numberOfFaces = faces.length;
                        // if (numberOfFaces > 0)
                        // try {
                        // onFaceDetectionEventMethod.invoke(parent,
                        // new Object[] { faces });
                        // } catch (Exception e) {
                        // PApplet.println("Exception trying to forward facedetection event (KetaiCamera):"
                        // + e.getMessage());
                        // }
                        // }

                }
        };
        private AutoFocusCallback autofocusCB = new AutoFocusCallback() {
                public void onAutoFocus(boolean result, Camera c) {
                        PApplet.println("Autofocus result: " + result);
                }
        };

        private PictureCallback jpegCallback = new PictureCallback() {
                public void onPictureTaken(byte[] data, Camera camera) {
                        PApplet.println("pictureCallback entered...");
                        if (camera == null)
                                return;
                        FileOutputStream outStream = null;

                        try {
                                PApplet.println("Saving image: " + savePhotoPath);
                                outStream = new FileOutputStream(savePhotoPath);
                                outStream.write(data);
                                outStream.close();

                                // callback sketch with path of saved image
                                // ;
                                if (onSavePhotoEventMethod != null && myPixels != null
                                                && savePhotoPath != null)
                                        try {
                                                onSavePhotoEventMethod.invoke(parent,
                                                                new Object[] { (String) savePhotoPath });
                                        } catch (Exception e) {

                                        }

                                // restart preview
                                camera.startPreview();
                                // try {
                                // SurfaceTexture st = new SurfaceTexture(0);
                                // camera.setPreviewTexture(st);
                                // camera.startPreview();
                                // camera.setPreviewDisplay(null);
                                // } catch (NoClassDefFoundError x) {
                                // camera.startPreview();
                                // }

                        } catch (FileNotFoundException e) {
                                e.printStackTrace();
                        } catch (IOException e) {
                                e.printStackTrace();
                        } catch (RuntimeException rtx) {
                        } finally {

                        }
                }
        };

        private OnScanCompletedListener myScannerCallback = new OnScanCompletedListener() {
                public void onScanCompleted(String arg0, Uri arg1) {
                        PApplet.println("Media Scanner returned: " + arg1.toString()
                                        + " => " + arg0);
                }
        };

        public void addToMediaLibrary(String _file) {

                // String[] paths = { mediaFile.getAbsolutePath() };
                String[] paths = { _file };
                MediaScannerConnection.scanFile(parent.getApplicationContext(), paths,
                                null, myScannerCallback);

        }

        public void pause() {
                camera.stopPreview();
                camera.release();
                isStarted = false;
        }

        public void stop() {
                PApplet.println("Stopping Camera...");
                if (camera != null && isStarted) {
                        isStarted = false;
                        camera.stopPreview();
                        camera.setPreviewCallback(null);
                        camera.release();
                        camera = null;
                }
        }

        public void decodeYUV420SP(byte[] yuv420sp) {

                // here we're using our own internal PImage attributes
                final int frameSize = width * height;

                for (int j = 0, yp = 0; j < height; j++) {
                        int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
                        for (int i = 0; i < width; i++, yp++) {
                                int y = (0xff & ((int) yuv420sp[yp])) - 16;
                                if (y < 0)
                                        y = 0;
                                if ((i & 1) == 0) {
                                        v = (0xff & yuv420sp[uvp++]) - 128;
                                        u = (0xff & yuv420sp[uvp++]) - 128;
                                }

                                int y1192 = 1192 * y;
                                int r = (y1192 + 1634 * v);
                                int g = (y1192 - 833 * v - 400 * u);
                                int b = (y1192 + 2066 * u);

                                if (r < 0)
                                        r = 0;
                                else if (r > 262143)
                                        r = 262143;
                                if (g < 0)
                                        g = 0;
                                else if (g > 262143)
                                        g = 262143;
                                if (b < 0)
                                        b = 0;
                                else if (b > 262143)
                                        b = 262143;

                                // use interal buffer instead of pixels for UX reasons
                                myPixels[yp] = 0xff000000 | ((r << 6) & 0xff0000)
                                                | ((g >> 2) & 0xff00) | ((b >> 10) & 0xff);
                        }
                }

        }

        public int getNumberOfCameras() {
                return Camera.getNumberOfCameras();
        }

        public Collection<? extends String> list() {
                Vector<String> list = new Vector<String>();
                String facing = "";
                int count = Camera.getNumberOfCameras();
                for (int i = 0; i < count; i++) {
                        Camera.CameraInfo info = new Camera.CameraInfo();
                        Camera.getCameraInfo(i, info);
                        if (info.facing == CameraInfo.CAMERA_FACING_BACK)
                                facing = "backfacing";
                        else
                                facing = "frontfacing";

                        list.add("camera id [" + i + "] facing:" + facing);
                        PApplet.println("camera id[" + i + "] facing:" + facing);
                }
                return list;
        }

        // figure out closest requested width/height, FPS combos
        private void determineCameraParameters() {
                if (camera == null)
                        return;

                PApplet.println("Requested camera parameters as (w,h,fps):"
                                + frameWidth + "," + frameHeight + "," + cameraFPS);

                Parameters cameraParameters = camera.getParameters();
                PApplet.println(cameraParameters.flatten());
                List<Size> supportedSizes = cameraParameters.getSupportedPreviewSizes();
                boolean foundSupportedSize = false;
                Size nearestRequestedSize = null;

                for (Size s : supportedSizes) {
                        PApplet.println("Checking supported preview size:" + s.width + ","
                                        + s.height);
                        if (nearestRequestedSize == null)
                                nearestRequestedSize = s;

                        if (!foundSupportedSize) {
                                if (s.width == frameWidth && s.height == frameHeight) {
                                        PApplet.println("Found matching camera size");
                                        nearestRequestedSize = s;
                                        foundSupportedSize = true;
                                } else {
                                        int delta = (frameWidth * frameHeight)
                                                        - (nearestRequestedSize.height * nearestRequestedSize.width);
                                        int current = (frameWidth * frameHeight)
                                                        - (s.height * s.width);
                                        delta = Math.abs(delta);
                                        current = Math.abs(current);
                                        if (current < delta)
                                                nearestRequestedSize = s;
                                }
                        }
                }
                if (nearestRequestedSize != null) {
                        frameWidth = nearestRequestedSize.width;
                        frameHeight = nearestRequestedSize.height;
                }
                cameraParameters.setPreviewSize(frameWidth, frameHeight);

                supportedSizes = cameraParameters.getSupportedPictureSizes();
                foundSupportedSize = false;
                nearestRequestedSize = null;

                for (Size s : supportedSizes) {
                        if (!foundSupportedSize) {
                                if (s.width == photoWidth && s.height == photoHeight) {
                                        nearestRequestedSize = s;

                                        foundSupportedSize = true;
                                } else if (photoWidth <= s.width) {
                                        nearestRequestedSize = s;
                                }
                        }
                }
                if (nearestRequestedSize != null) {
                        photoWidth = nearestRequestedSize.width;
                        photoHeight = nearestRequestedSize.height;
                }
                cameraParameters.setPictureSize(photoWidth, photoHeight);

                List<Integer> supportedFPS = cameraParameters
                                .getSupportedPreviewFrameRates();
                int nearestFPS = 0;

                for (int r : supportedFPS) {
                        PApplet.println("Supported preview FPS: " + r);
                        if (nearestFPS == 0)
                                nearestFPS = r;
                        if ((Math.abs(cameraFPS - r)) > (Math.abs(cameraFPS - nearestFPS))) {
                                nearestFPS = r;
                        }
                }
                PApplet.println("calculated preview FPS: " + nearestFPS);

                cameraParameters.setPreviewFrameRate(nearestFPS);

                PApplet.println("Setting calculated parameters:"
                                + cameraParameters.flatten());

                camera.setParameters(cameraParameters);

                cameraParameters = camera.getParameters();
                frameHeight = cameraParameters.getPreviewSize().height;
                frameWidth = cameraParameters.getPreviewSize().width;

                // if what was requested is what we set then update
                // otherwise we'll compensate here
                if (cameraFPS == cameraParameters.getPreviewFrameRate())
                        cameraFPS = cameraParameters.getPreviewFrameRate();
                PApplet.println("Calculated camera parameters as (w,h,fps):"
                                + frameWidth + "," + frameHeight + "," + cameraFPS);
                PApplet.println(cameraParameters.flatten());

                if (cameraParameters.getMaxNumDetectedFaces() > 0) {
                        PApplet.println("Face detection supported!");
                        supportsFaceDetection = true;
                }
                // update PImage
                resize(frameWidth, frameHeight);
        }

        public void onFrameAvailable(SurfaceTexture arg0) {
                PApplet.print(".");
        }

        // public void onFaceDetection(Face[] _faces, Camera _camera) {
        // KetaiFace[] faces = new KetaiFace[_faces.length];
        //
        // for (int i = 0; i < _faces.length; i++) {
        // faces[i] = new KetaiFace(_faces[i], frameWidth, frameHeight);
        // }
        // if (onFaceDetectionEventMethod != null) {
        // try {
        // onFaceDetectionEventMethod.invoke(parent,
        // new Object[] { faces });
        // } catch (Exception e) {
        // PApplet.println("Disabling onFaceDetectionEventMethod(KetaiCamera) because of an error:"
        // + e.getMessage());
        // e.printStackTrace();
        // onFaceDetectionEventMethod = null;
        // }
        // }
        // }
}

