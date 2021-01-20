package com.laogao.flutter_github_demo.account;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.auth0.android.Auth0;
import com.auth0.android.Auth0Exception;
import com.auth0.android.authentication.AuthenticationAPIClient;
import com.auth0.android.authentication.AuthenticationException;
import com.auth0.android.callback.BaseCallback;
import com.auth0.android.lock.AuthenticationCallback;
import com.auth0.android.lock.Lock;
import com.auth0.android.lock.LockCallback;
import com.auth0.android.lock.utils.CustomField;
import com.auth0.android.lock.utils.LockException;
import com.auth0.android.management.ManagementException;
import com.auth0.android.management.UsersAPIClient;
import com.auth0.android.provider.VoidCallback;
import com.auth0.android.provider.WebAuthProvider;
import com.auth0.android.request.internal.OkHttpClientFactory;
import com.auth0.android.result.Credentials;
import com.auth0.android.result.UserIdentity;
import com.auth0.android.result.UserProfile;
import com.laogao.flutter_github_demo.MainActivity;
import com.laogao.flutter_github_demo.R;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.OkHttp;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;

public class AccountPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {


    private static final String EU = "EU";
    private static final String US = "US";

    private static String _pluginName = "ai.nreal.nebula/account_login_logout";
    private static String _methodLogin = "login";
    private static String _methodLogout = "logout";


    private static String _methodGetChannelInfoName = "getChannelInfo";
    private final MainActivity mainActivity;

    private Context context;
    private MethodChannel methodChannel;
    private Lock lock;
    private Auth0 auth0;

    public AccountPlugin(MainActivity mainActivity) {
        this.mainActivity = mainActivity;
    }


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {

        context = binding.getApplicationContext();
        BinaryMessenger binaryMessenger = binding.getBinaryMessenger();
        methodChannel = new MethodChannel(binaryMessenger, _pluginName);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

        if (methodChannel != null) {
            methodChannel.setMethodCallHandler(null);
            methodChannel = null;
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
            String countryData = (String) call.arguments;
            initAuth(countryData);
            result.success("ok");
        } else if (call.method.equalsIgnoreCase(_methodLogout)) {
            logoutAuth0();
        }
    }

    private void initAuth(String countryData) {

        auth0 = new Auth0(context.getString(R.string.com_auth0_client_id),
                context.getString(R.string.com_auth0_domain));
        auth0.setOIDCConformant(true);
        auth0.setLoggingEnabled(true);

        List<CustomField> customFields = new ArrayList<>();

        CustomField fieldName = new CustomField(R.mipmap.ic_launcher, CustomField.FieldType.TYPE_NAME, "firstName", R.string.hint_first_name);
        customFields.add(fieldName);

        CustomField fieldName2 = new CustomField(R.mipmap.ic_launcher, CustomField.FieldType.TYPE_NUMBER, "number", R.string.hint_number);
        customFields.add(fieldName2);

        lock = Lock.newBuilder(auth0, callback)
//                .withScheme("demo")
//                .withAudience(String.format("https://%s/userinfo",
//                        context.getString(R.string.com_auth0_domain)))
                .withAudience(String.format("https://%s/api/v2/",
                        context.getString(R.string.com_auth0_domain)))
                .withScope(
                        "openid profile email " +
                                "offline_access read:current_user " +
//                                "update:current_user_identities "+
                                "update:users update:users_app_metadata update:current_user_metadata " +
                                "")
                .setPrivacyURL("http://example.com/privacy")
                .setTermsURL("http://example.com/terms")
                .setMustAcceptTerms(true)
                .closable(true)
                .loginAfterSignUp(false)
//                .withSignUpFields(customFields)

                .build(context);

        context.startActivity(lock.newIntent(context));


    }

    private void logoutAuth0() {

        WebAuthProvider.logout(auth0).start(context, new VoidCallback() {
            @Override
            public void onSuccess(@Nullable Void payload) {
                Log.e("lao_gao_AccountPlugin", "onSuccess: ");
            }

            @Override
            public void onFailure(@NonNull Auth0Exception error) {
                Log.e("lao_gao_AccountPlugin", "onFailure: " + error.getMessage());
            }
        });
    }

    private LockCallback callback = new AuthenticationCallback() {
        @Override
        public void onAuthentication(Credentials credentials) {
            //Authenticated
            Log.e("lao_gao_AccountPlugin", "onAuthentication: "
                    + credentials.getAccessToken()
                    + "   id = " + credentials.getIdToken()
            );

            getUserInfo(credentials.getAccessToken());
        }

        @Override
        public void onCanceled() {
            //User pressed back
            Log.e("lao_gao_AccountPlugin", "onCanceled: ");
        }

        @Override
        public void onError(LockException error) {
            Log.e("lao_gao_AccountPlugin", "onError: " + error.getMessage());
        }
        //Exception occurred

    };

    private UsersAPIClient usersClient;
    private AuthenticationAPIClient authenticationAPIClient;

    private void getUserInfo(String accessToken) {

        Log.e("lao_gao_LoginActivity", "getUserInfo:1111111111 ");
        usersClient = new UsersAPIClient(auth0, accessToken);
        authenticationAPIClient = new AuthenticationAPIClient(auth0);

        getProfile(accessToken);
    }

    // app/src/main/java/com/auth0/samples/activities/MainActivity.java

    private void getProfile(String accessToken) {

        authenticationAPIClient.userInfo(accessToken)
                .start(new BaseCallback<UserProfile, AuthenticationException>() {
                    @Override
                    public void onSuccess(UserProfile userinfo) {

                        printUser(userinfo, "getProfile");
                        updateUser(userinfo.getId());
                    }

                    @Override
                    public void onFailure(AuthenticationException error) {
                        // Show error
                        Log.e("lao_gao_MainActivity", "onFailure222: " + error.getMessage());

                    }
                });
    }


    private void updateUser(String id) {

        Map<String, Object> userMetadata = new HashMap<>();
        userMetadata.put("country", "USA");
        usersClient.updateMetadata(id, userMetadata).start(new BaseCallback<UserProfile, ManagementException>() {
            @Override
            public void onSuccess(UserProfile profile) {

                // You can react to this, and show the information to the user.
                printUser(profile, "updateUser");
            }

            @Override
            public void onFailure(ManagementException error) {
                // Show error
                Log.e("lao_gao_AccountPlugin", "onFailure: " + error.getMessage());
            }
        });
    }


    private void printUser(UserProfile userinfo, String tag) {
        Log.e("lao_gao_LoginActivity", "printUser: " + tag);
        Log.e("lao_gao_LoginActivity", "printUser: " + userinfo.toString()
                + "\n " + userinfo.getId()
                + "\n " + userinfo.getName()
                + "\n " + userinfo.getFamilyName()
                + "\n " + userinfo.getGivenName()
                + "\n " + userinfo.getEmail()
                + "\n " + userinfo.getPictureURL()
                + "\n " + userinfo.getUserMetadata().toString()

        );
    }
}
