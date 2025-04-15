plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // O plugin do Flutter deve vir após os plugins do Android e Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.medihelp_offline"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // NDK necessário para dependências nativas

    defaultConfig {
        applicationId = "com.example.medihelp_offline"
        minSdk = 24 // Necessário para compatibilidade com flutter_gemma
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            // Usa o signing de debug apenas para facilitar testes internos
            signingConfig = signingConfigs.getByName("debug")

            // ⚠️ Desativa a minificação (R8/Proguard) para evitar erro de classes ausentes
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
