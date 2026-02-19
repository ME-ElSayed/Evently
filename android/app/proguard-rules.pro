# OkHttp3 - Required by uCrop
-dontwarn okhttp3.**
-dontwarn okio.**
-keepnames class okhttp3.** { *; }
-keepnames class okio.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# uCrop
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }