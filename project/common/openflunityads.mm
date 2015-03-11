#include <hx/CFFI.h>
#include "OpenFLUnityAds.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UnityAds/UnityAds.h>

extern "C" {
    NSString* UnityAdsCreateNSString (const char* string) {
        return string ? [NSString stringWithUTF8String: string] : [NSString stringWithUTF8String: ""];
    }
}

@interface UnityAdsWrapper : NSObject <UnityAdsDelegate> {
}

- (void)initUnityAds:(NSString*)gameId testModeOn:(BOOL)testMode debugModeOn:(BOOL)debugMode;
//- (bool)showAd:(NSString*)zone rewardKeyOn:(NSString*)rewardKey;
@end

@implementation UnityAdsWrapper

- (void)initUnityAds:(NSString*)gameId testModeOn:(BOOL)testMode debugModeOn:(BOOL)debugMode{
	[[UnityAds sharedInstance] setDelegate:self];
	[[UnityAds sharedInstance] setTestMode:testMode];		
	[[UnityAds sharedInstance] setDebugMode:debugMode];
	
	[[UnityAds sharedInstance] startWithGameId:gameId andViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];	
}

/*- (bool)showAd:(NSString*)zoneId rewardKeyOn:(NSString*)rewardItemKey{
if ([[UnityAds sharedInstance] canShowAds] && [[UnityAds sharedInstance] canShow]) {
            NSLog(@"showad3");
            if([rewardItemKey length] > 0) {
                [[UnityAds sharedInstance] setZone:zoneId withRewardItem:rewardItemKey];
            } else {
                [[UnityAds sharedInstance] setZone:zoneId];
            }
            NSLog(@"showad4");
            return [[UnityAds sharedInstance] show];
            NSLog(@"showad5");
            
            return true;
    }
    NSLog(@"showad6");
    return false;
}*/


- (void)unityAdsFetchCompleted {
	NSLog(@"unityAdsFetchCompleted");
	openflunityads::onFetch(true);
}

- (void)unityAdsFetchFailed {
	openflunityads::onFetch(false);
}

- (void)unityAdsDidShow {
	NSLog(@"unityAdsDidShow");
	openflunityads::onVideoShow();	
}

- (void)unityAdsDidHide {
	NSLog(@"unityAdsDidHide");
	openflunityads::onVideoHide();	
}

- (void)unityAdsVideoStarted {
	NSLog(@"unityAdsVideoStarted");
	openflunityads::onVideoStarted();	
}

- (void)unityAdsVideoCompleted:(NSString *)rewardItemKey skipped:(BOOL)skipped {
	NSLog(@"unityAdsVideoCompleted:rewardItemKey:skipped -- key: %@ -- skipped: %@", rewardItemKey, skipped ? @"true" : @"false");
	openflunityads::onVideoCompleted([rewardItemKey UTF8String],skipped);
} 

@end

namespace openflunityads {
	
	value *onFetchCB = NULL;
	value *onVideoCompletedCB = NULL;
	value *onVideoStartedCB = NULL;
	value *onVideoHideCB = NULL;
	value *onVideoShowCB = NULL;
	void InitUnityAds(value cb, const char *gameId, bool testMode, bool debugMode) {
		[[UnityAdsWrapper alloc] initUnityAds:UnityAdsCreateNSString(gameId) testModeOn:testMode debugModeOn:debugMode];
		
	}
	
	bool show (const char * rawZoneId, const char * rawRewardItemKey){
	NSString * zoneId = UnityAdsCreateNSString(rawZoneId);
    NSString * rewardItemKey = UnityAdsCreateNSString(rawRewardItemKey);
	
	if ([[UnityAds sharedInstance] canShowAds] && [[UnityAds sharedInstance] canShow]) {
            NSLog(@"showad3");
            if([rewardItemKey length] > 0) {
                [[UnityAds sharedInstance] setZone:zoneId withRewardItem:rewardItemKey];
            } else {
                [[UnityAds sharedInstance] setZone:zoneId];
            }
            NSLog(@"showad4");
            [[UnityAds sharedInstance] show];
            NSLog(@"showad5");
            return true;
    }
    NSLog(@"showad6");
    return false;
    
	//return [[UnityAdsWrapper alloc] showAd:UnityAdsCreateNSString(rawZoneId)  rewardKeyOn:UnityAdsCreateNSString(rawRewardItemKey)];
	
	}
	
	void onFetch(bool result){
		val_call1(*onFetchCB,alloc_bool(result));
	}
	
	void onVideoCompleted(const char * keyId, bool rewarded){
		val_call2(*onVideoCompletedCB,alloc_bool(keyId),alloc_bool(rewarded));
	}
	
	void onVideoStarted(){
		val_call0(*onVideoStartedCB);
	}
	
	void onVideoHide(){
		val_call0(*onVideoHideCB);		
	}
	
	void onVideoShow(){
		val_call0(*onVideoShowCB);		
	}
	
	void setOnFetchCB(value f){
	val_check_function(f,1);
    onFetchCB = alloc_root();
    *onFetchCB = f;
	}
	void setOnVideoCompletedCB(value f){
	val_check_function(f,2);
    onVideoCompletedCB = alloc_root();
    *onVideoCompletedCB = f;	
	}
	void setOnVideoStartedCB(value f){
	val_check_function(f,0);
    onVideoStartedCB = alloc_root();
    *onVideoStartedCB = f;			
	}
	void setOnVideoHideCB(value f){
	val_check_function(f,0);
    onVideoHideCB = alloc_root();
    *onVideoHideCB = f;				
	}
	void setOnVideoShowCB(value f){
	val_check_function(f,0);
    onVideoShowCB = alloc_root();
    *onVideoShowCB = f;					
	}

	
	bool canShowAds () {
        return [[UnityAds sharedInstance] canShowAds];
    }
    
	bool canShow () {
        return [[UnityAds sharedInstance] canShow];
    }
	
	
}
