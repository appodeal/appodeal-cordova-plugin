package com.appodeal.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import android.os.Handler;
import android.os.Looper;
import android.widget.LinearLayout;
import android.widget.FrameLayout;
import android.view.ViewGroup;
import android.view.View;
import android.view.Gravity;

import com.appodeal.ads.Appodeal;
import com.appodeal.ads.BannerCallbacks;
import com.appodeal.ads.InterstitialCallbacks;
import com.appodeal.ads.RewardedVideoCallbacks;
import com.appodeal.ads.NonSkippableVideoCallbacks;
import com.appodeal.ads.UserSettings;
import com.appodeal.ads.BannerView;

import org.json.JSONObject;

public class AppodealPlugin extends CordovaPlugin {

    private static final String ACTION_INITIALIZE = "initialize";
    private static final String ACTION_IS_INITIALIZED = "isInitalized";

    private static final String ACTION_SHOW = "show";
    private static final String ACTION_SHOW_WITH_PLACEMENT = "showWithPlacement";
    private static final String ACTION_HIDE = "hide";
   
    private static final String ACTION_IS_LOADED = "isLoaded";
    private static final String ACTION_IS_PRECACHE = "isPrecache";
    private static final String ACTION_CAN_SHOW = "canShow";

    private static final String ACTION_SET_AUTO_CACHE = "setAutoCache";
    private static final String ACTION_CACHE = "cache";
    private static final String ACTION_SET_ON_LOADED_TRIGGER_BOTH = "setTriggerOnLoadedOnPrecache";
    private static final String ACTION_SMART_BANNERS = "setSmartBanners";
    private static final String ACTION_BANNER_BACKGROUND = "setBannerBackground";
    private static final String ACTION_BANNER_ANIMATION = "setBannerAnimation";
    private static final String ACTION_768X90_BANNERS = "set728x90Banners";
    private static final String ACTION_BANNERS_OVERLAP = "setBannerOverLap";
    private static final String ACTION_MUTE_VIDEOS_IF_CALLS_MUTED = "muteVideosIfCallsMuted";
    private static final String ACTION_START_TEST_ACTIVITY = "startTestActivity";

    private static final String ACTION_SET_CUSTOM_INTEGER_RULE = "setCustomIntegerRule";
    private static final String ACTION_SET_CUSTOM_BOOLEAN_RULE = "setCustomBooleanRule";
    private static final String ACTION_SET_CUSTOM_DOUBLE_RULE = "setCustomDoubleRule";
    private static final String ACTION_SET_CUSTOM_STRING_RULE = "setCustomStringRule";

    private static final String ACTION_SET_LOGGING = "setLogging";
    private static final String ACTION_SET_TESTING = "setTesting";
    private static final String ACTION_GET_VERSION = "getVersion";

    private static final String ACTION_DISABLE_NETWORK = "disableNetwork";
    private static final String ACTION_DISABLE_NETWORK_FOR_TYPE = "disableNetworkType";

    private static final String ACTION_DISABLE_LOCATION_PERMISSION_CHECK = "disableLocationPermissionCheck";
    private static final String ACTION_DISABLE_WRITE_EXTERNAL_STORAGE_CHECK = "disableWriteExternalStoragePermissionCheck";

    private static final String ACTION_SET_INTERSTITIAL_CALLBACKS = "setInterstitialCallbacks";
    private static final String ACTION_SET_NON_SKIPPABLE_VIDEO_CALLBACKS = "setNonSkippableVideoCallbacks";
    private static final String ACTION_SET_REWARDED_CALLBACKS = "setRewardedVideoCallbacks";
    private static final String ACTION_SET_BANNER_CALLBACKS = "setBannerCallbacks";

    private static final String ACTION_SET_AGE = "setAge";
    private static final String ACTION_SET_GENDER = "setGender";

    private boolean isInitialized = false;
    private boolean bannerOverlap = true;
    private ViewGroup parentView;
    private BannerView bannerView;
    private UserSettings userSettings;

    private static final String CALLBACK_INIT = "onInit";
    private static final String CALLBACK_LOADED = "onLoaded";
    private static final String CALLBACK_FAILED = "onFailedToLoad";
    private static final String CALLBACK_CLICKED = "onClick";
    private static final String CALLBACK_SHOWN = "onShown";
    private static final String CALLBACK_CLOSED = "onClosed";
    private static final String CALLBACK_FINISHED = "onFinished";
    private CallbackContext interstitialCallbacks;
    private CallbackContext bannerCallbacks;
    private CallbackContext skippableCallbacks;
    private CallbackContext nonSkippableCallbacks;
    private CallbackContext rewardedCallbacks;

    @Override
    public boolean execute(String action, JSONArray args,
            final CallbackContext callback) throws JSONException {

        if (action.equals(ACTION_INITIALIZE)) {
            final String appKey = args.getString(0);
            final int adType = args.getInt(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.initialize(cordova.getActivity(), appKey, getAdType(adType));
                    isInitialized = true;
                }
            });
            return true;
        } else if (action.equals(ACTION_IS_INITIALIZED)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(isInitialized) {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SHOW)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    int rAdType = getAdType(adType);
                    boolean res =  false;
                    if(rAdType == Appodeal.BANNER || rAdType == Appodeal.BANNER_BOTTOM || rAdType == Appodeal.BANNER_TOP){
                        res = showBanner(adType, null);
                    }
                    else{
                        res = Appodeal.show(cordova.getActivity(), getAdType(adType));
                    }
                    callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, res));
                }
            });
            return true;
        } else if (action.equals(ACTION_SHOW_WITH_PLACEMENT)) {
            final int adType = args.getInt(0);
            final String placement = args.getString(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    int rAdType = getAdType(adType);
                    boolean res =  false;
                    if(rAdType == Appodeal.BANNER || rAdType == Appodeal.BANNER_BOTTOM || rAdType == Appodeal.BANNER_TOP){
                        res = showBanner(adType, placement);
                    }
                    else{
                        res = Appodeal.show(cordova.getActivity(), getAdType(adType), placement);
                    }
                    callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, res));
                }
            });
            return true;
        } else if (action.equals(ACTION_HIDE)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.hide(cordova.getActivity(), getAdType(adType));
                }
            });
            return true;
        } else if (action.equals(ACTION_IS_LOADED)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(Appodeal.isLoaded(getAdType(adType))) {
                       callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                       callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_CAN_SHOW)) {
            final int adType = args.getInt(0);
            final String placement = args.getString(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(Appodeal.canShow(getAdType(adType), placement)) {
                       callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                       callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_IS_PRECACHE)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(Appodeal.isPrecache(getAdType(adType))) {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_AUTO_CACHE)) {
            final int adType = args.getInt(0);
            final boolean autoCache = args.getBoolean(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setAutoCache(getAdType(adType), autoCache);
                }
            });
            return true;
        } else if (action.equals(ACTION_CACHE)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.cache(cordova.getActivity(), getAdType(adType));
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_ON_LOADED_TRIGGER_BOTH)) {
            final int adType = args.getInt(0);
            final boolean setOnTriggerBoth = args.getBoolean(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setTriggerOnLoadedOnPrecache(getAdType(adType), setOnTriggerBoth);
                }
            });
            return true;
        } else if (action.equals(ACTION_START_TEST_ACTIVITY)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.startTestActivity(cordova.getActivity());
                }
            });
            return true;
        } else if (action.equals(ACTION_MUTE_VIDEOS_IF_CALLS_MUTED)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.muteVideosIfCallsMuted(value);
                }
            });
            return true;
        } else if (action.equals(ACTION_SMART_BANNERS)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setSmartBanners(value);
                }
            });
            return true;
        } else if (action.equals(ACTION_BANNER_BACKGROUND)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    //Appodeal.setBannerBackground(value);
                }
            });
            return true;
        } else if (action.equals(ACTION_BANNER_ANIMATION)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setBannerAnimation(value);
                }
            });
            return true;
        } else if (action.equals(ACTION_768X90_BANNERS)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.set728x90Banners(value);
                }
            });
            return true;
        } else if(action.equals(ACTION_BANNERS_OVERLAP)) {
            final boolean value = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    bannerOverlap = value;
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_CUSTOM_INTEGER_RULE)) {
            final String name = args.getString(0);
            final int value = args.getInt(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setCustomRule(name, value);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_CUSTOM_BOOLEAN_RULE)) {
            final String name = args.getString(0);
            final boolean value = args.getBoolean(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setCustomRule(name, value);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_CUSTOM_DOUBLE_RULE)) {
            final String name = args.getString(0);
            final double value = args.getDouble(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setCustomRule(name, value);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_CUSTOM_STRING_RULE)) {
            final String name = args.getString(0);
            final String value = args.getString(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setCustomRule(name, value);
                }
            });
            return true;
        } else if (action.equals(ACTION_GET_VERSION)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    callback.success(Appodeal.getVersion());
                }
            });
            return true;
        } else if (action.equals(ACTION_DISABLE_NETWORK)) {
            final String network = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.disableNetwork(cordova.getActivity(), network);
                }
            });
            return true;
        } else if (action.equals(ACTION_DISABLE_NETWORK_FOR_TYPE)) {
            final String network = args.getString(0);
            final int adType = args.getInt(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.disableNetwork(cordova.getActivity(), network, getAdType(adType));
                }
            });
            return true;
        } else if (action.equals(ACTION_DISABLE_LOCATION_PERMISSION_CHECK)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.disableLocationPermissionCheck();
                }
            });
            return true;
        } else if (action.equals(ACTION_DISABLE_WRITE_EXTERNAL_STORAGE_CHECK)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.disableWriteExternalStoragePermissionCheck();
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_LOGGING)) {
            final boolean logging = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setLogLevel(com.appodeal.ads.utils.Log.LogLevel.verbose);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_TESTING)) {
            final boolean testing = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.setTesting(testing);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_INTERSTITIAL_CALLBACKS)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    try{
                      interstitialCallbacks = callback;
                      Appodeal.setInterstitialCallbacks(interstitialListener);
                      JSONObject vals = new JSONObject();
                      vals.put("event", CALLBACK_INIT);
                      PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                      result.setKeepCallback(true);
                      callback.sendPluginResult(result);
                    } catch(JSONException e){}
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_NON_SKIPPABLE_VIDEO_CALLBACKS)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                  try{
                    nonSkippableCallbacks = callback;
                    Appodeal.setNonSkippableVideoCallbacks(nonSkippableVideoListener);
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_INIT);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    callback.sendPluginResult(result);
                  } catch(JSONException e){}
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_REWARDED_CALLBACKS)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                  try{
                    rewardedCallbacks = callback;
                    Appodeal.setRewardedVideoCallbacks(rewardedVideoListener);
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_INIT);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    callback.sendPluginResult(result);
                  } catch(JSONException e){}
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_BANNER_CALLBACKS)) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                  try{
                    bannerCallbacks = callback;
                    Appodeal.setBannerCallbacks(bannerListener);
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_INIT);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    callback.sendPluginResult(result);
                  } catch(JSONException e){}
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_AGE)) {
            final int age = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    getUserSettings().setAge(age);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_GENDER)) {
            final String gender = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(gender.equals("other".toLowerCase())) {
                        getUserSettings().setGender(UserSettings.Gender.OTHER);
                    } else if(gender.equals("female".toLowerCase())) {
                        getUserSettings().setGender(UserSettings.Gender.FEMALE);
                    } else if(gender.equals("male".toLowerCase())) {
                        getUserSettings().setGender(UserSettings.Gender.MALE);
                    }
                }
            });
            return true;
        }
        return false;
    }

    private UserSettings getUserSettings() {
        if(userSettings == null) {
            userSettings = Appodeal.getUserSettings(cordova.getActivity());
        }
        return userSettings;
    }

    private int getAdType(int adtype) {
        int type = 0;
        if((adtype & 3) > 0) {
            type |= Appodeal.INTERSTITIAL;
        }
        if((adtype & 4) > 0) {
            type |= Appodeal.BANNER;
        }
        if((adtype & 8) > 0) {
            type |= Appodeal.BANNER_BOTTOM;
        }
        if((adtype & 16) > 0) {
            type |= Appodeal.BANNER_TOP;
        }
        if((adtype & 128) > 0) {
            type |= Appodeal.REWARDED_VIDEO;
        }
        if((adtype & 256) > 0) {
            type |= Appodeal.NON_SKIPPABLE_VIDEO;
        }
        return type;
    }

    private InterstitialCallbacks interstitialListener = new InterstitialCallbacks() {

        @Override
        public void onInterstitialShown() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_SHOWN);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    interstitialCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onInterstitialLoaded(final boolean arg0) {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_LOADED);
                    vals.put("isPrecache", arg0);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    interstitialCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onInterstitialFailedToLoad() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FAILED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    interstitialCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onInterstitialClosed() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_CLOSED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    interstitialCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onInterstitialClicked() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_CLICKED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    interstitialCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }
    };

    private NonSkippableVideoCallbacks nonSkippableVideoListener = new NonSkippableVideoCallbacks() {

        @Override
        public void onNonSkippableVideoClosed(final boolean finished) {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_CLOSED);
                    vals.put("finished", finished);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    nonSkippableCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onNonSkippableVideoFailedToLoad() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FAILED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    nonSkippableCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onNonSkippableVideoFinished() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FINISHED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    nonSkippableCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onNonSkippableVideoLoaded() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_LOADED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    nonSkippableCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onNonSkippableVideoShown() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_SHOWN);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    nonSkippableCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

    };

    private RewardedVideoCallbacks rewardedVideoListener = new RewardedVideoCallbacks() {

        @Override
        public void onRewardedVideoClosed(final boolean finished) {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_CLOSED);
                    vals.put("finished", finished);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    rewardedCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onRewardedVideoFailedToLoad() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FAILED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    rewardedCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onRewardedVideoFinished(final int amount, final String name) {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FINISHED);
                    vals.put("amount", amount);
                    vals.put("name", name);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    rewardedCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onRewardedVideoLoaded() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_LOADED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    rewardedCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onRewardedVideoShown() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_SHOWN);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    rewardedCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

    };

    private BannerCallbacks bannerListener = new BannerCallbacks() {

        @Override
        public void onBannerClicked() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_CLICKED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    bannerCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onBannerFailedToLoad() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_FAILED);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    bannerCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onBannerLoaded(final int height, final boolean isPrecache) {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_LOADED);
                    vals.put("height", height);
                    vals.put("isPrecache", isPrecache);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    bannerCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

        @Override
        public void onBannerShown() {
          cordova.getActivity().runOnUiThread(new Runnable() {
              @Override
              public void run() {
                  try{
                    JSONObject vals = new JSONObject();
                    vals.put("event", CALLBACK_SHOWN);
                    PluginResult result = new PluginResult(PluginResult.Status.OK, vals);
                    result.setKeepCallback(true);
                    bannerCallbacks.sendPluginResult(result);
                  } catch(JSONException e){}
              }
          });
        }

    };
    
    private ViewGroup getViewGroup(int child){
        ViewGroup vg = (ViewGroup)this.cordova.getActivity().getWindow().getDecorView().findViewById(android.R.id.content);
        if(child != -1) vg = (ViewGroup)vg.getChildAt(child); //child == 0 is view from setContentView
        return vg; 
    }
    
    private boolean showBanner(int adType, String placement){
        if (bannerView != null && bannerView.getParent() != null) {
            ((ViewGroup)bannerView.getParent()).removeView(bannerView);
        }
        if (bannerView == null) bannerView = Appodeal.getBannerView(cordova.getActivity());
        
        if (bannerOverlap){
            ViewGroup rootView = getViewGroup(-1);
            if(rootView == null) return false;
            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
            if(adType == Appodeal.BANNER_TOP) params.gravity = Gravity.TOP  | Gravity.CENTER_HORIZONTAL;
            else params.gravity = Gravity.BOTTOM  | Gravity.CENTER_HORIZONTAL;
            rootView.addView(bannerView, params);
            rootView.requestLayout();
        } else {
            ViewGroup rootView = getViewGroup(0);
            if(rootView == null) return false;
            if (parentView == null) {
                parentView = new LinearLayout(cordova.getActivity());
            }
            if (rootView != parentView) {
                ((ViewGroup)rootView.getParent()).removeView(rootView);
                ((LinearLayout) parentView).setOrientation(LinearLayout.VERTICAL);
                 parentView.setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, 0.0F));
                rootView.setLayoutParams(new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, 1.0F));
                parentView.addView(rootView);
                cordova.getActivity().setContentView(parentView);
            }
            
            if(adType == Appodeal.BANNER_TOP)
                parentView.addView(bannerView, 0);
            else
                parentView.addView(bannerView);
            
            parentView.bringToFront();
            parentView.requestLayout();
        }
        boolean res = false;
        if(placement == null) res = Appodeal.show(cordova.getActivity(), Appodeal.BANNER_VIEW);
        else res = Appodeal.show(cordova.getActivity(), Appodeal.BANNER_VIEW, placement);
        
        return res;
    }
}