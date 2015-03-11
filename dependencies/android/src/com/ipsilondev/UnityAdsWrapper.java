package com.ipsilondev;


import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import com.unity3d.ads.android.UnityAds;
import com.unity3d.ads.android.IUnityAdsListener;
import com.ipsilondev.UnityAdsWrapperListener;
import android.util.Log;
import android.content.ActivityNotFoundException;

public class UnityAdsWrapper extends Extension{
	
	public static HaxeObject cb;
	private static String gameId;
	private static UnityAdsWrapperListener listener;
	private static boolean testMode = false;
	private static boolean debugMode = false;
	private static boolean inited = false;
	
	
	//init UnityAds with the provided gameId and set up the haxe callback. set up test mode if is specified
	//WARNING: debug mode is supported by this code, but NOT BY THE INCLUDED COMPILED SDK. if you want debug mode, you must re-compile the SDK and replace the unity-ads.jar for the one you made.
	public static void init(HaxeObject callbackObject,String gId,boolean test,boolean debug){
		cb = callbackObject;
		gameId = gId;
		if(debug){
			UnityAds.setDebugMode(true);
			debugMode = debug;
		}
		if(test){
			UnityAds.setTestMode(true);
			testMode = test;
		}
		inited = true;
		listener = new UnityAdsWrapperListener();
		UnityAds.init(mainActivity, gameId, (IUnityAdsListener)listener);
	}	
	
		
	public static boolean showAd(String zone,String rewardKey){
		if(rewardKey!="" && zone!=""){
			UnityAds.setZone(zone,rewardKey);
		}else if(zone!=""){
			UnityAds.setZone(zone);			
		}		
		if(UnityAds.canShow() && UnityAds.canShowAds()){
		mainActivity.runOnUiThread(new Runnable() {
           public void run() { 
		UnityAds.show();
			   
		}});
			return true;
		}else{
			return false;
		}
	}
		
	
	
	/**
	 * Called when an activity you launched exits, giving you the requestCode 
	 * you started it with, the resultCode it returned, and any additional data 
	 * from it.
	 */
	public boolean onActivityResult (int requestCode, int resultCode, Intent data) {
		
		return true;
		
	}
	
	
	
	/**
	 * Called when the activity is starting.
	 */
	public void onCreate (Bundle savedInstanceState) {
		
		
		
	}
	
	
	/**
	 * Perform any final cleanup before an activity is destroyed.
	 */
	public void onDestroy () {
		
		
		
	}
	
	
	/**
	 * Called as part of the activity lifecycle when an activity is going into
	 * the background, but has not (yet) been killed.
	 */
	public void onPause () {
		
		
		
	}
	
	
	/**
	 * Called after {@link #onStop} when the current activity is being 
	 * re-displayed to the user (the user has navigated back to it).
	 */
	public void onRestart () {
		
		
		
	}
	
	
	/**
	 * Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	 * to start interacting with the user.
	 */
	public void onResume () {
		
		super.onResume();
		if(inited){
	    UnityAds.changeActivity(mainActivity);
		}
		
		
	}
	
	
	/**
	 * Called after {@link #onCreate} &mdash; or after {@link #onRestart} when  
	 * the activity had been stopped, but is now again being displayed to the 
	 * user.
	 */
	public void onStart () {
		
		
		
	}
	
	
	/**
	 * Called when the activity is no longer visible to the user, because 
	 * another activity has been resumed and is covering this one. 
	 */
	public void onStop () {
		
		
		
	}
	
	
}
