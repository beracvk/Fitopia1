plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // 🔥 Firebase için gerekli
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fitopia2"
    ndkVersion = "27.0.12077973"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    sourceSets {
        getByName("main") {
            manifest.srcFile("android/app/src/main/AndroidManifest.xml")
        }
    }

    defaultConfig {
        applicationId = "com.example.fitopiaCrew"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // 🔥 Firebase BOM (versiyon uyumu için çok önemli)
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))

    // 🔥 Firebase Authentication
    implementation("com.google.firebase:firebase-auth-ktx")

    // 🔥 Firebase Firestore
    implementation("com.google.firebase:firebase-firestore-ktx")
}
