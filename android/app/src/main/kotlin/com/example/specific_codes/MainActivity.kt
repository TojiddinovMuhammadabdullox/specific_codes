package com.example.specific_codes

import android.os.Bundle
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter/flashlight"
    private var isFlashlightOn: Boolean = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "toggleFlashlight") {
                val toggleResult = toggleFlashlight()
                result.success(toggleResult)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun toggleFlashlight(): Boolean {
        val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
        return try {
            val cameraId = cameraManager.cameraIdList[0]
            cameraManager.setTorchMode(cameraId, !isFlashlightOn)
            isFlashlightOn = !isFlashlightOn
            isFlashlightOn
        } catch (e: CameraAccessException) {
            e.printStackTrace()
            false
        }
    }
}
