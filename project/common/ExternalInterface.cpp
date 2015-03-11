#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "OpenFLUnityAds.h"


using namespace openflunityads;



static void openflunityads_init (value cb, value gameId, value testmode, value debugmode) {
	
	InitUnityAds(cb,val_string(gameId),val_bool(testmode),val_bool(debugmode));
	
}
DEFINE_PRIM (openflunityads_init, 4);

static value openflunityads_showAd (value zone, value rewardKey) {
	
	return alloc_bool(show(val_string(zone),val_string(rewardKey)));
}
DEFINE_PRIM (openflunityads_showAd, 2);

static void openflunityads_setOnFetchCB (value f) {
	
	setOnFetchCB(f);
	
}
DEFINE_PRIM (openflunityads_setOnFetchCB, 1);

static void openflunityads_setOnVideoCompletedCB (value f) {
	
	setOnVideoCompletedCB(f);
	
}
DEFINE_PRIM (openflunityads_setOnVideoCompletedCB, 1);

static void openflunityads_setOnVideoStartedCB (value f) {
	
	setOnVideoStartedCB(f);
	
}
DEFINE_PRIM (openflunityads_setOnVideoStartedCB, 1);

static void openflunityads_setOnVideoHideCB (value f) {
	
	setOnVideoHideCB(f);
	
}
DEFINE_PRIM (openflunityads_setOnVideoHideCB, 1);

static void openflunityads_setOnVideoShowCB (value f) {
	
	setOnVideoShowCB(f);
	
}
DEFINE_PRIM (openflunityads_setOnVideoShowCB, 1);


extern "C" void openflunityads_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (openflunityads_main);



extern "C" int openflunityads_register_prims () { return 0; }
