# Keep ExoPlayer and just_audio classes
-keep class com.google.android.exoplayer2.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep class androidx.media.** { *; }

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Optional: keep your app-specific classes
-keep class org.ai4voice.** { *; }
