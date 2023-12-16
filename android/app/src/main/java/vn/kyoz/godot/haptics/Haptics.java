package vn.kyoz.godot.haptics;

import android.app.Activity;
import android.content.Context;
import android.os.Vibrator;
import android.os.VibratorManager;
import android.os.VibrationEffect;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.collection.ArraySet;

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.SignalInfo;
import org.godotengine.godot.plugin.UsedByGodot;

import java.util.Set;

public class Haptics extends GodotPlugin {
    private static final String TAG = "GodotHaptics";
    private Activity activity;
    private Context context;
    private final Vibrator vibrator;


    public Haptics(Godot godot) {
        super(godot);
        activity = getActivity();
        context = activity.getApplicationContext();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            VibratorManager vibratorManager = (VibratorManager) context.getSystemService(Context.VIBRATOR_MANAGER_SERVICE);
            this.vibrator = vibratorManager.getDefaultVibrator();
        } else {
            this.vibrator = getDeprecatedVibrator(context);
        }
    }

    @NonNull
    @Override
    public String getPluginName() {
        return getClass().getSimpleName();
    }


    @SuppressWarnings("deprecation")
    private Vibrator getDeprecatedVibrator(Context context) {
        return (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
    }

    @SuppressWarnings({ "deprecation" })
    private void vibratePre26(int duration) {
        vibrator.vibrate(duration);
    }

    @SuppressWarnings({ "deprecation" })
    private void vibratePre26(long[] pattern, int repeat) {
        vibrator.vibrate(pattern, repeat);
    }

    @UsedByGodot
    public void light() {
        Log.d(TAG, "called light()");
        HapticsImpactType type = HapticsImpactType.LIGHT;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrator.vibrate(VibrationEffect.createWaveform(type.getTimings(), type.getAmplitudes(), -1));
        } else {
            vibratePre26(type.getOldSDKPattern(), -1);
        }
    }

    @UsedByGodot
    public void medium() {
        Log.d(TAG, "called medium()");
        HapticsImpactType type = HapticsImpactType.MEDIUM;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrator.vibrate(VibrationEffect.createWaveform(type.getTimings(), type.getAmplitudes(), -1));
        } else {
            vibratePre26(type.getOldSDKPattern(), -1);
        }
    }

    @UsedByGodot
    public void heavy() {
        Log.d(TAG, "called heavy()");
        HapticsImpactType type = HapticsImpactType.HEAVY;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrator.vibrate(VibrationEffect.createWaveform(type.getTimings(), type.getAmplitudes(), -1));
        } else {
            vibratePre26(type.getOldSDKPattern(), -1);
        }
    }
}
