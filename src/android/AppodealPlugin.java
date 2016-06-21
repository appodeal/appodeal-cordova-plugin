package com.appodeal.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.os.Handler;
import android.os.Looper;

import com.appodeal.ads.Appodeal;
import com.appodeal.ads.BannerCallbacks;
import com.appodeal.ads.InterstitialCallbacks;
import com.appodeal.ads.VideoCallbacks;

public class AppodealPlugin extends CordovaPlugin {

	private static final String ACTION_INIT_APPODEAL = "initialize";
	private static final String ACTION_INIT_APPODEAL_AD_TYPE = "initializeAdType";
	private static final String ACTION_SET_INTERSTITIAL_CALLBACKS = "enableIntertitialCallbacks";
	private static final String ACTION_SET_VIDEO_CALLBACKS = "enableVideoCallbacks";
	private static final String ACTION_SET_BANNER_CALLBACKS = "enableBannerCallbacks";
	private static final String ACTION_ISLOADED = "isLoaded";
	private static final String ACTION_ISPRECACHE = "isPrecache";
	private static final String ACTION_SHOW = "show";
	private static final String ACTION_HIDE = "hide";
	private static final String ACTION_SHOW_WITH_PRICE_FLOOR = "showWithPriceFloor";
	private static final String ACTION_SET_AUTO_CACHE = "setAutoCache";
	private static final String ACTION_CACHE_BANNER = "cacheBanner";
	private static final String ACTION_SET_ON_LOADED_TRIGGER_BOTH = "setOnLoadedTriggerBoth";
	private static final String ACTION_DISABLE_NETWORK = "disableNetwork";
	private static final String ACTION_DISABLE_LOCATION_CHECK = "disableLocationCheck";
	
	private String appKey = null;
	private int adType = 127;
	private boolean autoCache = true;
	private boolean setOnTriggerBoth = true;
	private boolean setInterstitialCallbacks = false;
	private boolean setVideoCallbacks = false;
	private boolean setBannerCallbacks = false;

	@Override
	public boolean execute(String action, JSONArray args,
			final CallbackContext callback) throws JSONException {

		if (action.equals(ACTION_INIT_APPODEAL)) {
			appKey = args.getString(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.initialize(cordova.getActivity(), appKey);
				}
			});
			return true;
		} else if (action.equals(ACTION_INIT_APPODEAL_AD_TYPE)) {
			appKey = args.getString(0);
			adType = args.getInt(1);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.initialize(cordova.getActivity(), appKey, adType);
				}
			});
			return true;
		} else if (action.equals(ACTION_SET_INTERSTITIAL_CALLBACKS)) {
			setInterstitialCallbacks = args.getBoolean(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					if(setInterstitialCallbacks) {
						Appodeal.setInterstitialCallbacks(interstitialListener);
					}
				}
			});
			return true;
		} else if (action.equals(ACTION_SET_VIDEO_CALLBACKS)) {
			setVideoCallbacks = args.getBoolean(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					if(setVideoCallbacks) {
						Appodeal.setVideoCallbacks(videoListener);
					}
				}
			});
			return true;
		} else if (action.equals(ACTION_SET_BANNER_CALLBACKS)) {
			setBannerCallbacks = args.getBoolean(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					if(setBannerCallbacks) {
						Appodeal.setBannerCallbacks(bannerListener);
					}
				}
			});
			return true;
		} else if (action.equals(ACTION_ISLOADED)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					callback.success(Appodeal.isLoaded(adType) ? 1 : 0);
				}
			});
			return true;
		} else if (action.equals(ACTION_ISPRECACHE)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					callback.success(Appodeal.isPrecache(adType) ? 1 : 0);
				}
			});
			return true;
		} else if (action.equals(ACTION_SHOW)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					boolean isShow = Appodeal.show(cordova.getActivity(), adType);
					callback.success(isShow ? 1 : 0);
				}
			});
			return true;
		} else if (action.equals(ACTION_HIDE)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.hide(cordova.getActivity(), adType);
				}
			});
			return true;
		} else if (action.equals(ACTION_SHOW_WITH_PRICE_FLOOR)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					boolean isShow = Appodeal.showWithPriceFloor(cordova.getActivity(), adType);
					callback.success(isShow ? 1 : 0);
				}
			});
			return true;
		} else if (action.equals(ACTION_SET_AUTO_CACHE)) {
			adType = args.getInt(0);
			autoCache = args.getBoolean(1);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.setAutoCache(adType, autoCache);
				}
			});
			return true;
		} else if (action.equals(ACTION_CACHE_BANNER)) {
			adType = args.getInt(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.cache(cordova.getActivity(), adType);
				}
			});
			return true;
		} else if (action.equals(ACTION_SET_ON_LOADED_TRIGGER_BOTH)) {
			adType = args.getInt(0);
			setOnTriggerBoth = args.getBoolean(1);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.setOnLoadedTriggerBoth(adType, setOnTriggerBoth);
				}
			});
			return true;
		} else if (action.equals(ACTION_DISABLE_NETWORK)) {
			final String network = args.getString(0);
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.disableNetwork(network);
				}
			});
			return true;
		} else if (action.equals(ACTION_DISABLE_LOCATION_CHECK)) {
			cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					Appodeal.disableLocationPermissionCheck();
				}
			});
			return true;
		}
		return false;
	}
	
	private InterstitialCallbacks interstitialListener = new InterstitialCallbacks() {
		
		@Override
		public void onInterstitialShown() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onInterstitialShown');");
			    }
			});
		}
		
		@Override
		public void onInterstitialLoaded(boolean arg0) {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onInterstitialLoaded');");
			    }
			});
		}
		
		@Override
		public void onInterstitialFailedToLoad() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onInterstitialFailedToLoad');");
			    }
			});
		}
		
		@Override
		public void onInterstitialClosed() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onInterstitialClosed');");
			    }
			});
		}
		
		@Override
		public void onInterstitialClicked() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onInterstitialClicked');");
			    }
			});
		}
	};
	
	private VideoCallbacks videoListener = new VideoCallbacks() {

		@Override
		public void onVideoClosed() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onVideoClosed');");
			    }
			});
		}

		@Override
		public void onVideoFailedToLoad() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onVideoFailedToLoad');");
			    }
			});
		}

		@Override
		public void onVideoFinished() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onVideoFinished');");
			    }
			});
		}

		@Override
		public void onVideoLoaded() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
					webView.loadUrl ("javascript:cordova.fireDocumentEvent('onVideoLoaded');");
			    }
			});
		}

		@Override
		public void onVideoShown() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onVideoShown');");
			    }
			});
		}
		
	};
	
	private BannerCallbacks bannerListener = new BannerCallbacks() {

		@Override
		public void onBannerClicked() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onBannerClicked');");
			    }
			});
		}

		@Override
		public void onBannerFailedToLoad() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onBannerFailedToLoad');");
			    }
			});
		}

		@Override
		public void onBannerLoaded() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onBannerLoaded');");
			    }
			});
		}

		@Override
		public void onBannerShown() {
			new Handler(Looper.getMainLooper()).post(new Runnable() {
			    @Override
			    public void run() {
			    	webView.loadUrl ("javascript:cordova.fireDocumentEvent('onBannerShown');");
			    }
			});
		}
		
	};
}