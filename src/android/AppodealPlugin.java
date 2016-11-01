package com.appodeal.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import android.os.Handler;
import android.os.Looper;

import com.appodeal.ads.Appodeal;
import com.appodeal.ads.BannerCallbacks;
import com.appodeal.ads.InterstitialCallbacks;
import com.appodeal.ads.RewardedVideoCallbacks;
import com.appodeal.ads.SkippableVideoCallbacks;
import com.appodeal.ads.NonSkippableVideoCallbacks;
import com.appodeal.ads.UserSettings;

public class AppodealPlugin extends CordovaPlugin {

    private static final String ACTION_INITIALIZE = "initialize";
    private static final String ACTION_IS_INITIALIZED = "isInitalized";

    private static final String ACTION_SHOW = "show";
    private static final String ACTION_SHOW_WITH_PLACEMENT = "showWithPlacement";
    private static final String ACTION_HIDE = "hide";
    private static final String ACTION_CONFIRM = "confirm";

    private static final String ACTION_IS_LOADED = "isLoaded";
    private static final String ACTION_IS_PRECACHE = "isPrecache";

    private static final String ACTION_SET_AUTO_CACHE = "setAutoCache";
    private static final String ACTION_CACHE = "cache";
    private static final String ACTION_SET_ON_LOADED_TRIGGER_BOTH = "setOnLoadedTriggerBoth";
    private static final String ACTION_SMART_BANNERS = "setSmartBanners";
    private static final String ACTION_BANNER_BACKGROUND = "setBannerBackground";
    private static final String ACTION_BANNER_ANIMATION = "setBannerAnimation";
    private static final String ACTION_768X90_BANNERS = "set728x90Banners";

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

    private static final String ACTION_ENABLE_INTERSTITIAL_CALLBACKS = "enableInterstitialCallbacks";
    private static final String ACTION_ENABLE_SKIPPABLE_VIDEO_CALLBACKS = "enableSkippableVideoCallbacks";
    private static final String ACTION_ENABLE_NON_SKIPPABLE_VIDEO_CALLBACKS = "enableNonSkippableVideoCallbacks";
    private static final String ACTION_ENABLE_REWARDED_CALLBACKS = "enableRewardedVideoCallbacks";
    private static final String ACTION_ENABLE_BANNER_CALLBACKS = "enableBannerCallbacks";

    private static final String ACTION_SET_USER_ID = "setUserId";
    private static final String ACTION_SET_EMAIL = "setEmail";
    private static final String ACTION_SET_BIRTHDAY = "setBirthday";
    private static final String ACTION_SET_AGE = "setAge";
    private static final String ACTION_SET_GENDER = "setGender";
    private static final String ACTION_SET_OCCUPATION = "setOccupation";
    private static final String ACTION_SET_RELATION = "setRelation";
    private static final String ACTION_SET_SMOKING = "setSmoking";
    private static final String ACTION_SET_ALKOHOL = "setAlcohol";
    private static final String ACTION_SET_INTERESTS = "setInterests";

    private boolean isInitialized = false;
    private UserSettings userSettings;

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
                    if(Appodeal.show(cordova.getActivity(), getAdType(adType))) {
                       callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SHOW_WITH_PLACEMENT)) {
            final int adType = args.getInt(0);
            final String placement = args.getString(1);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(Appodeal.show(cordova.getActivity(), getAdType(adType), placement)) {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
                    } else {
                        callback.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
                    }
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
        } else if (action.equals(ACTION_CONFIRM)) {
            final int adType = args.getInt(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Appodeal.confirm(getAdType(adType));
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
                    Appodeal.setOnLoadedTriggerBoth(getAdType(adType), setOnTriggerBoth);
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
        } else if (action.equals(ACTION_ENABLE_INTERSTITIAL_CALLBACKS)) {
            final boolean setInterstitialCallbacks = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(setInterstitialCallbacks) {
                        Appodeal.setInterstitialCallbacks(interstitialListener);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_ENABLE_NON_SKIPPABLE_VIDEO_CALLBACKS)) {
            final boolean setNonSkippableVideoCallbacks = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(setNonSkippableVideoCallbacks) {
                        Appodeal.setNonSkippableVideoCallbacks(nonSkippableVideoListener);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_ENABLE_SKIPPABLE_VIDEO_CALLBACKS)) {
            final boolean setSkippableVideoCallbacks = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(setSkippableVideoCallbacks) {
                        Appodeal.setSkippableVideoCallbacks(skippableVideoListener);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_ENABLE_REWARDED_CALLBACKS)) {
            final boolean setRewardedVideoCallbacks = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(setRewardedVideoCallbacks) {
                        Appodeal.setRewardedVideoCallbacks(rewardedVideoListener);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_ENABLE_BANNER_CALLBACKS)) {
            final boolean setBannerCallbacks = args.getBoolean(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(setBannerCallbacks) {
                        Appodeal.setBannerCallbacks(bannerListener);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_USER_ID)) {
            final String id = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    getUserSettings().setUserId(id);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_EMAIL)) {
            final String email = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    getUserSettings().setEmail(email);
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_BIRTHDAY)) {
            final String birthday = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    getUserSettings().setBirthday(birthday);
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
        } else if (action.equals(ACTION_SET_OCCUPATION)) {
            final String occupation = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(occupation.equals("other".toLowerCase())) {
                        getUserSettings().setOccupation(UserSettings.Occupation.OTHER);
                    } else if(occupation.equals("work".toLowerCase())) {
                        getUserSettings().setOccupation(UserSettings.Occupation.WORK);
                    } else if(occupation.equals("school".toLowerCase())) {
                        getUserSettings().setOccupation(UserSettings.Occupation.SCHOOL);
                    } else if(occupation.equals("university".toLowerCase())) {
                        getUserSettings().setOccupation(UserSettings.Occupation.UNIVERSITY);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_RELATION)) {
            final String relation = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(relation.equals("other".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.OTHER);
                    } else if(relation.equals("single".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.SINGLE);
                    } else if(relation.equals("dating".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.DATING);
                    } else if(relation.equals("engaged".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.ENGAGED);
                    } else if(relation.equals("married".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.MARRIED);
                    } else if(relation.equals("searching".toLowerCase())) {
                        getUserSettings().setRelation(UserSettings.Relation.SEARCHING);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_SMOKING)) {
            final String smoking = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(smoking.equals("negative".toLowerCase())) {
                        getUserSettings().setSmoking(UserSettings.Smoking.NEGATIVE);
                    } else if(smoking.equals("neutral".toLowerCase())) {
                        getUserSettings().setSmoking(UserSettings.Smoking.NEUTRAL);
                    } else if(smoking.equals("positive".toLowerCase())) {
                        getUserSettings().setSmoking(UserSettings.Smoking.POSITIVE);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_ALKOHOL)) {
            final String alcohol = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    if(alcohol.equals("negative".toLowerCase())) {
                        getUserSettings().setAlcohol(UserSettings.Alcohol.NEGATIVE);
                    } else if(alcohol.equals("neutral".toLowerCase())) {
                        getUserSettings().setAlcohol(UserSettings.Alcohol.NEUTRAL);
                    } else if(alcohol.equals("positive".toLowerCase())) {
                        getUserSettings().setAlcohol(UserSettings.Alcohol.POSITIVE);
                    }
                }
            });
            return true;
        } else if (action.equals(ACTION_SET_INTERESTS)) {
            final String interests = args.getString(0);
            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    getUserSettings().setInterests(interests);
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
        if((adtype & 1) > 0) {
            type |= Appodeal.INTERSTITIAL;
        }
        if((adtype & 2) > 0) {
            type |= Appodeal.SKIPPABLE_VIDEO;
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

    private SkippableVideoCallbacks skippableVideoListener = new SkippableVideoCallbacks() {

        @Override
        public void onSkippableVideoClosed(boolean finished) {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onSkippableVideoClosed');");
                }
            });
        }

        @Override
        public void onSkippableVideoFailedToLoad() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onSkippableVideoFailedToLoad');");
                }
            });
        }

        @Override
        public void onSkippableVideoFinished() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onSkippableVideoFinished');");
                }
            });
        }

        @Override
        public void onSkippableVideoLoaded() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onSkippableVideoLoaded');");
                }
            });
        }

        @Override
        public void onSkippableVideoShown() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onSkippableVideoShown');");
                }
            });
        }

    };

    private NonSkippableVideoCallbacks nonSkippableVideoListener = new NonSkippableVideoCallbacks() {

        @Override
        public void onNonSkippableVideoClosed(boolean finished) {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onNonSkippableVideoClosed');");
                }
            });
        }

        @Override
        public void onNonSkippableVideoFailedToLoad() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onNonSkippableVideoFailedToLoad');");
                }
            });
        }

        @Override
        public void onNonSkippableVideoFinished() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onNonSkippableVideoFinished');");
                }
            });
        }

        @Override
        public void onNonSkippableVideoLoaded() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onNonSkippableVideoLoaded');");
                }
            });
        }

        @Override
        public void onNonSkippableVideoShown() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onNonSkippableVideoShown');");
                }
            });
        }

    };

    private RewardedVideoCallbacks rewardedVideoListener = new RewardedVideoCallbacks() {

        @Override
        public void onRewardedVideoClosed(boolean finished) {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onRewardedVideoClosed');");
                }
            });
        }

        @Override
        public void onRewardedVideoFailedToLoad() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onRewardedVideoFailedToLoad');");
                }
            });
        }

        @Override
        public void onRewardedVideoFinished(final int amount, final String name) {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl(String.format(
                            "javascript:cordova.fireDocumentEvent('onRewardedVideoFinished', { 'amount': %d, 'name':'%s' });",
                            amount, name));
                }
            });
        }

        @Override
        public void onRewardedVideoLoaded() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onRewardedVideoLoaded');");
                }
            });
        }

        @Override
        public void onRewardedVideoShown() {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    webView.loadUrl ("javascript:cordova.fireDocumentEvent('onRewardedVideoShown');");
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
        public void onBannerLoaded(int height, boolean isPrecache) {
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
