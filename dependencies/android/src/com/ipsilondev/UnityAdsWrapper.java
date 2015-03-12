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
	 * Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	 * to start interacting with the user.
	 */
	public void onResume () {
		
		super.onResume();
		if(inited){
	    UnityAds.changeActivity(mainActivity);
		}
		
		
	}	
	
}
