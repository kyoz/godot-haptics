// Source: https://github.com/ionic-team/capacitor-plugins/blob/main/haptics/android/src/main/java/com/capacitorjs/plugins/haptics/arguments/HapticsVibrationType.java
package vn.kyoz.godot.haptics;

public interface HapticsVibrationType {
    long[] getTimings();

    int[] getAmplitudes();

    long[] getOldSDKPattern();
}
