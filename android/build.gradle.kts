plugins {
    id("com.android.application")
    id("kotlin-android") // değiştirmedik 
    id("com.google.gms.google-services") // Firebase için ekledik 
}

android {
    compileSdk = 33
    ndkVersion = "27.0.12077973"

    namespace = "com.fitopia1"

    defaultConfig {
        applicationId = "com.fitopia1"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

repositories {
    google()
    mavenCentral()
}

dependencies {
    // Android temel kütüphaneleri
    implementation("androidx.core:core-ktx:1.9.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.8.0")

    // 🔥 Firebase BOM
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))

    // 🔥 Firebase Authentication
    implementation("com.google.firebase:firebase-auth-ktx")

    // 🔥 Firebase Firestore (isteğe bağlı, veri kaydetmek için)
    implementation("com.google.firebase:firebase-firestore-ktx")
}
