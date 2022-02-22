package com.laogao.flutter_github_demo.account;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.auth0.android.Auth0;
import com.auth0.android.Auth0Exception;
import com.auth0.android.authentication.AuthenticationAPIClient;
import com.auth0.android.authentication.AuthenticationException;
import com.auth0.android.authentication.storage.CredentialsManager;
import com.auth0.android.authentication.storage.CredentialsManagerException;
import com.auth0.android.authentication.storage.SecureCredentialsManager;
import com.auth0.android.authentication.storage.SharedPreferencesStorage;
import com.auth0.android.callback.BaseCallback;
import com.auth0.android.google.GoogleAuthProvider;
import com.auth0.android.jwt.JWT;
import com.auth0.android.lock.AuthenticationCallback;
import com.auth0.android.lock.Lock;
import com.auth0.android.lock.LockCallback;
import com.auth0.android.lock.utils.LockException;
import com.auth0.android.management.ManagementException;
import com.auth0.android.management.UsersAPIClient;
import com.auth0.android.provider.VoidCallback;
import com.auth0.android.provider.WebAuthProvider;
import com.auth0.android.result.Credentials;
import com.auth0.android.result.UserProfile;
import com.laogao.flutter_github_demo.MainActivity;
import com.laogao.flutter_github_demo.R;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AccountPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler {


    public static final boolean DEBUG = true;
    private static final String SHARED_PREF_NAME = "FlutterSharedPreferences";
    private static final String SHARED_PREF_KEY_USER_TOKEN =
            "flutter.USER_TOKEN";

    private static final String EU = "EU";
    private static final String US = "US";

    private static String _pluginName = "ai.nreal.nebula/account_login_logout";
    private static String _pluginEventName = "ai.nreal.nebula/account_info_event";
    private static String _methodLogin = "login";
    private static String _methodLogout = "logout";

    private static String _methodUpdateUser = "updateUser";

    private static final String GET_USER = "getUser";
    private static final String UPDATE_USER = "updateUser";
    private final MainActivity mainActivity;

    private Context context;
    private MethodChannel methodChannel;
    private EventChannel eventChannel;
    private Lock lock;

    private String countryData;
    private EventChannel.EventSink events;
    private Handler mainHandler;
    private SharedPreferences sharedPreferences;
    // 为了获取和更新用户信息。
    private UsersAPIClient usersClient;
    // 为了获取userId
    private AuthenticationAPIClient authenticationAPIClient;
    // 返回数据
    private Map<String, Object> userMap;


    public AccountPlugin(MainActivity mainActivity) {
        this.mainActivity = mainActivity;
        mainHandler = new Handler(Looper.getMainLooper());
    }

    private void postMainThread(Runnable runnable) {
        mainHandler.post(runnable);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {

        context = binding.getApplicationContext();
        sharedPreferences = context.getSharedPreferences(SHARED_PREF_NAME, Context.MODE_PRIVATE);
        BinaryMessenger binaryMessenger = binding.getBinaryMessenger();
        methodChannel = new MethodChannel(binaryMessenger, _pluginName);
        methodChannel.setMethodCallHandler(this);


        eventChannel = new EventChannel(binaryMessenger, _pluginEventName);
        eventChannel.setStreamHandler(this);


    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

        if (methodChannel != null) {
            methodChannel.setMethodCallHandler(null);
            methodChannel = null;
        }
        if (eventChannel != null) {
            eventChannel.setStreamHandler(null);
            eventChannel = null;
        }

        if (lock != null) {
            lock.onDestroy(context);
            lock = null;
        }
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

        if (call.method.equalsIgnoreCase(_methodLogin)) {

            Toast.makeText(context, "login", Toast.LENGTH_SHORT).show();
//            countryData = (String) call.arguments;
//            if (TextUtils.isEmpty(countryData)) {
//                countryData = EU;
//            }
//            login();

            ComponentName cn = new ComponentName(context.getPackageName(),
                    "com.laogao.flutter_github_demo.OtherProcessActivity");
            Intent intent = new Intent();
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
            intent.setComponent(cn);

            context.startActivity(intent);

            result.success("ok");
        } else if (call.method.equalsIgnoreCase(_methodLogout)) {
            logoutAuth0();
        } else if (call.method.equals(_methodUpdateUser)) {

            String userToken = sharedPreferences.getString(SHARED_PREF_KEY_USER_TOKEN, "");

            Map<String, Object> argumentMap = (Map<String, Object>) call.arguments;

            updateUserInfo(argumentMap, userToken);
        }

    }


    private Auth0 getAccount() {
        Auth0 auth0;
        if (countryData.equals(EU)) {
            auth0 = new Auth0(context.getString(R.string.com_auth0_client_id),
                    context.getString(R.string.com_auth0_domain));
        } else {
            auth0 = new Auth0(context.getString(R.string.com_auth0_client_id),
                    context.getString(R.string.com_auth0_domain));
        }
        auth0.setOIDCConformant(true);
        auth0.setLoggingEnabled(DEBUG);
        return auth0;
    }

    private void login() {

        GoogleAuthProvider provider = new GoogleAuthProvider(
                context.getString(R.string.google_server_client_id), new AuthenticationAPIClient(getAccount()));

        lock = Lock.newBuilder(getAccount(), callback)
                .withScheme("app")
                .withAudience(String.format("https://%s/api/v2/",
                        context.getString(R.string.com_auth0_domain)))
                // 可以允许的权限
                .withScope("openid profile email offline_access read:current_user update:current_user_metadata")
                .setPrivacyURL("https://www.nreal.ai/h5/nebula/privacy-policy/kddi/en/")
                .setTermsURL("https://www.nreal.ai/h5/nebula/tos/kddi/en/")
                .setMustAcceptTerms(true)
                .closable(true)
                .allowedConnections(generateConnections())
//                .withAuthHandlers(new GoogleAuthHandler(provider))
                // 浏览器的title的颜色
//                .withCustomTabsOptions(  CustomTabsOptions.newBuilder().showTitle(false).withToolbarColor(R.color.black).build())
                // 注册时可以添加自定义的参数。
//                .withSignUpFields(customFields)

                .build(context);

        context.startActivity(lock.newIntent(context));


    }

    private List<String> generateConnections() {
        List<String> connections = new ArrayList<>();
        if (countryData.equals(EU)) {
            connections.add("Nebula-database");
        } else {
            connections.add("Nebula-database");
        }
        connections.add("mfa-connection");
        connections.add("with-strength");
        connections.add("ad");
        connections.add("another");
        connections.add("fake-saml");
        connections.add("contoso-ad");
        connections.add("google-oauth2");
//        connections.add("twitter");
//        connections.add("facebook");
//        connections.add("paypal-sandbox");
//        if (connections.isEmpty()) {
//            connections.add("no-connection");
//        }
        return connections;
    }

    private void logoutAuth0() {

        Log.e("lao_gao_AccountPlugin", "logoutAuth0: ");
        if (manager != null) {
            manager.clearCredentials();
        }

        GoogleAuthProvider provider = new GoogleAuthProvider("my-connection",
                context.getString(R.string.google_server_client_id), new AuthenticationAPIClient(getAccount()));
        provider.clearSession();
        provider.rememberLastLogin(false);

        WebAuthProvider.logout(getAccount()).withScheme("app").start(mainActivity, new VoidCallback() {
            @Override
            public void onSuccess(@Nullable Void payload) {
                if (DEBUG) Log.e("lao_gao_AccountPlugin", "onSuccess: ");
            }

            @Override
            public void onFailure(@NonNull Auth0Exception error) {
                if (DEBUG) Log.e("lao_gao_AccountPlugin", "onFailure: " + error.getMessage());
            }
        });
    }

    private String accessTokenTemp;
    Long expiresIn;
    private LockCallback callback = new AuthenticationCallback() {
        @Override
        public void onAuthentication(Credentials credentials) {
            //Authenticated
            if (DEBUG) Log.e("lao_gao_AccountPlugin", "onAuthentication: "
                    + " getAccessToken "+credentials.getAccessToken()
                    + " getIdToken "+credentials.getIdToken()
                    + " getRefreshToken "+credentials.getRefreshToken()

            );
            expiresIn = credentials.getExpiresIn() * 1000 + SystemClock.elapsedRealtime();
            accessTokenTemp = credentials.getAccessToken();
            sharedPreferences.edit().putString(SHARED_PREF_KEY_USER_TOKEN, accessTokenTemp).apply();

            Log.e("lao_gao_AccountPlugin", "onAuthentication: "
                    + " getAccessToken= " + new JWT(credentials.getAccessToken()).getExpiresAt().getTime()
                    + " getIdToken= " + new JWT(credentials.getIdToken()).getExpiresAt().getTime()
//                    + " getRefreshToken= " + new JWT(credentials.getRefreshToken()).getExpiresAt().getTime()

            );
            getUserInfo(credentials);
        }

        @Override
        public void onCanceled() {
            //User pressed back
            if (DEBUG) Log.e("lao_gao_AccountPlugin", "onCanceled: ");
        }

        @Override
        public void onError(LockException error) {
            if (DEBUG) Log.e("lao_gao_AccountPlugin", "onError: " + error.getMessage());
        }
    };

    /**
     * 获取用户信息，返回到flutter
     *
     * @param credentials
     */
    private void getUserInfo(Credentials credentials) {

        userMap = new HashMap<>();
        userMap.put(GET_USER, GET_USER);
        usersClient = new UsersAPIClient(getAccount(), credentials.getAccessToken());
        authenticationAPIClient = new AuthenticationAPIClient(getAccount());
        manager = new SecureCredentialsManager(context,authenticationAPIClient, new SharedPreferencesStorage(context));
        manager.saveCredentials(credentials);
        authenticationAPIClient.userInfo(credentials.getAccessToken())
                .start(new BaseCallback<UserProfile, AuthenticationException>() {
                    @Override
                    public void onSuccess(UserProfile userinfo) {
                        if (userinfo == null) {

                            postMainThread(() -> {
                                userMap.put("error", "userinfo ==null");
                                events.success(events);
                            });
                            return;
                        }
                        usersClient.getProfile(userinfo.getId())
                                .start(new BaseCallback<UserProfile, ManagementException>() {
                                    @Override
                                    public void onSuccess(@Nullable UserProfile payload) {
                                        postMainThread(() -> {

                                            if (payload == null) {
                                                userMap.put("error", "payload ==null");
                                                events.success(events);
                                                return;
                                            }
                                            if (events != null) {
                                                Map<String, Object> userMap = new HashMap<>();
                                                userMap.put("email", payload.getEmail());
                                                userMap.put("email", payload.getPictureURL());
                                                userMap.put("userMetadata", payload.getUserMetadata());
                                                events.success(userMap);
                                            }
                                            printUser(payload, "usersClient.getProfile");
                                        });
                                    }

                                    @Override
                                    public void onFailure(@NonNull ManagementException error) {
                                        if (DEBUG)
                                            Log.e("lao_gao_AccountPlugin", "onFailure: usersClient.getProfile " + error.getMessage());
                                        postMainThread(() -> {
                                            userMap.put("error", error.getMessage());
                                            events.success(events);
                                        });

                                    }
                                });

                    }

                    @Override
                    public void onFailure(AuthenticationException error) {
                        // Show error
                        if (DEBUG)
                            Log.e("lao_gao_MainActivity", "onFailure222: " + error.getMessage());
                        postMainThread(() -> {
                            userMap.put("error", error.getMessage());
                            events.success(events);
                        });
                    }
                });
    }

    SecureCredentialsManager manager;

    private void updateUserInfo(Map<String, Object> userMetadata, String accessToken) {
        if (DEBUG) Log.e("lao_gao_AccountPlugin", "updateUserInfo: " + userMetadata.toString());

        userMap = new HashMap<>();
        userMap.put(UPDATE_USER, UPDATE_USER);
//        usersClient = new UsersAPIClient(getAccount(), accessTokenTemp);
        authenticationAPIClient = new AuthenticationAPIClient(getAccount());

        manager = new SecureCredentialsManager(context,authenticationAPIClient, new SharedPreferencesStorage(context));


        boolean hasValidCredentials = manager.hasValidCredentials(60);
        Log.e("lao_gao_AccountPlugin", "updateUserInfo: hasValidCredentials = " + hasValidCredentials);

        boolean timeout = SystemClock.elapsedRealtime() > expiresIn;
        Log.e("lao_gao_AccountPlugin", "updateUserInfo: " + timeout);

//        _updateUserMetedataInfo(accessToken, userMetadata);
//        if(hasValidCredentials){
//
//        }

        manager.getCredentials(new BaseCallback<Credentials, CredentialsManagerException>() {
            @Override
            public void onSuccess(@Nullable Credentials payload) {
//                manager.saveCredentials(payload);

                _updateUserMetedataInfo(payload.getAccessToken(), userMetadata);
            }

            @Override
            public void onFailure(@NonNull CredentialsManagerException error) {

            }
        });
    }

    private void _updateUserMetedataInfo(String accessToken, Map<String, Object> userMetadata) {
        authenticationAPIClient.userInfo(accessToken)
                .start(new BaseCallback<UserProfile, AuthenticationException>() {
                    @Override
                    public void onSuccess(UserProfile userinfo) {
                        if (userinfo == null || TextUtils.isEmpty(userinfo.getId())) {
                            postMainThread(() -> {
                                userMap.put("error", "userinfo is error");
                                events.success(userMap);
                            });
                            return;
                        }
                        usersClient = new UsersAPIClient(getAccount(), accessToken);
                        usersClient.updateMetadata(userinfo.getId(), userMetadata)
                                .start(new BaseCallback<UserProfile, ManagementException>() {
                                    @Override
                                    public void onSuccess(UserProfile profile) {

                                        // You can react to this, and show the information to the user.
                                        printUser(profile, "updateUser");
                                        postMainThread(() -> {
                                            userMap.put("success", "success");
                                            events.success(userMap);
                                        });
                                    }

                                    @Override
                                    public void onFailure(ManagementException error) {
                                        // Show error
                                        if (DEBUG) {
                                            Log.e("lao_gao_AccountPlugin", "onFailure: " + error.getMessage());
                                        }
                                        postMainThread(() -> {
                                            userMap.put("error", error.getMessage());
                                            events.success(userMap);
                                        });
                                    }
                                });
                    }

                    @Override
                    public void onFailure(AuthenticationException error) {
                        // Show error
                        if (DEBUG) {
                            Log.e("lao_gao_AccountPlugin", "onFailure: " + error.getCode()
                                    + "  " + error.getDescription()
                                    + "  " + error.getStatusCode()

                            );
                            Log.e("lao_gao_MainActivity", "onFailure222: " + error.getMessage());
                        }
                        postMainThread(() -> {
                            userMap.put("error", error.getMessage());
                            events.success(userMap);
                        });
                    }
                });
    }


    private void printUser(UserProfile userinfo, String tag) {
        if (DEBUG) Log.e("lao_gao_LoginActivity", "printUser: " + tag);
        if (DEBUG) Log.e("lao_gao_LoginActivity", "printUser: " + userinfo.toString()
                + "\n " + userinfo.getId()
                + "\n " + userinfo.getName()
                + "\n " + userinfo.getFamilyName()
                + "\n " + userinfo.getGivenName()
                + "\n " + userinfo.getEmail()
                + "\n " + userinfo.getPictureURL()
                + "\n " + userinfo.getUserMetadata().toString()

        );
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;

    }

    @Override
    public void onCancel(Object arguments) {

    }
}
