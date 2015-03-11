package com.ipsilondev;


import android.app.Activity;
import android.content.res.AssetManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import com.unity3d.ads.android.UnityAds;
import com.unity3d.ads.android.IUnityAdsListener;
import com.ipsilondev.UnityAdsWrapper;
/* 
	You can use the Android Extension class in order to hook
	into the Android activity lifecycle. This is not required
	for standard Java code, this is designed for when you need
	deeper integration.
	
	You can access additional references from the Extension class,
	depending on your needs:
	
	- Extension.assetManager (android.content.res.AssetManager)
	- Extension.callbackHandler (android.os.Handler)
	- Extension.mainActivity (android.app.Activity)
	- Extension.mainContext (android.content.Context)
	- Extension.mainView (android.view.View)
	
	You can also make references to static or instance methods
	and properties on Java classes. These classes can be included 
	as single files using <java path="to/File.java" /> within your
	project, or use the full Android Library Project format (such
	as this example) in order to include your own AndroidManifest
	data, additional dependencies, etc.
	
	These are also optional, though this example shows a static
	function for performing a single task, like returning a value
	back to Haxe from Java.
*/
public class UnityAdsWrapperListener implements IUnityAdsListener{
	public void main(String[] args) {
		// TODO Auto-generated method stub
	}
	
	//after initied, this method is called if campaigns could be fetched
	public void onFetchCompleted(){
		UnityAdsWrapper.cb.call1("unityAdsOnFetch",true);
	}
	//after initied, this method is called if no campaigns could be fetched	
	public void onFetchFailed(){
		UnityAdsWrapper.cb.call1("unityAdsOnFetch",false);		
	} 

	public void onVideoCompleted(String keyId,boolean rewarded){
		UnityAdsWrapper.cb.call2("unityAdsOnVideoCompleted",keyId,rewarded);
	}
	
	public void onVideoStarted(){
		UnityAdsWrapper.cb.call0("unityAdsOnVideoStarted");
	}
	
	public void onHide() {
		UnityAdsWrapper.cb.call0("unityAdsOnHide");		
	}
	
	public void onShow() {
		UnityAdsWrapper.cb.call0("unityAdsOnShow");				
	}
	
}
