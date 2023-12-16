// Source: https://github.com/ionic-team/capacitor-plugins/blob/main/haptics/android/src/main/java/com/capacitorjs/plugins/haptics/arguments/HapticsImpactType.java
package vn.kyoz.godot.haptics;


public enum HapticsImpactType implements HapticsVibrationType {
    LIGHT("LIGHT", new long[] { 0, 50 }, new int[] { 0, 110 }, new long[] { 0, 20 }),
    MEDIUM("MEDIUM", new long[] { 0, 43 }, new int[] { 0, 180 }, new long[] { 0, 43 }),
    HEAVY("HEAVY", new long[] { 0, 60 }, new int[] { 0, 255 }, new long[] { 0, 61 });

    private final String type;
    private final long[] timings;
    private final int[] amplitudes;
    private final long[] oldSDKPattern;

    HapticsImpactType(String type, long[] timings, int[] amplitudes, long[] oldSDKPattern) {
        this.type = type;
        this.timings = timings;
        this.amplitudes = amplitudes;
        this.oldSDKPattern = oldSDKPattern;
    }

    @Override
    public long[] getTimings() {
        return timings;
    }

    @Override
    public int[] getAmplitudes() {
        return amplitudes;
    }

    @Override
    public long[] getOldSDKPattern() {
        return oldSDKPattern;
    }
}