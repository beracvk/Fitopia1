plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    compileSdk = 33
    ndkVersion = "27.0.12077973"

    namespace = "com.fitopia1" // Burada, uygulamanın paket adını yaz.

    defaultConfig {
        applicationId = "com.fitopia1" // Kotlin DSL'de `=` ile kullanılır.
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
    jcenter()  // Alternatif olarak, bu depo kullanılabilir.
}

dependencies {
    implementation("androidx.core:core-ktx:1.9.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.8.0")
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
