package com.blockflow.test.blockflow_camera

import android.content.ContentValues
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "media_saver"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveVideo" -> {
                    val path = call.argument<String>("path")
                    val success = saveToMediaStore(path, true)
                    result.success(success)
                }
                "savePhoto" -> {
                    val path = call.argument<String>("path")
                    val success = saveToMediaStore(path, false)
                    result.success(success)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun saveToMediaStore(path: String?, isVideo: Boolean): Boolean {
        if (path == null) return false
        return try {
            val file = File(path)
            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, file.name)
                put(MediaStore.MediaColumns.MIME_TYPE, if (isVideo) "video/mp4" else "image/jpeg")
                put(MediaStore.MediaColumns.RELATIVE_PATH,
                    if (isVideo) "Movies/YourApp" else "Pictures/YourApp")
            }
            val uri = contentResolver.insert(
                if (isVideo) MediaStore.Video.Media.EXTERNAL_CONTENT_URI
                else MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values
            ) ?: return false
            contentResolver.openOutputStream(uri)?.use { output ->
                FileInputStream(file).use { input ->
                    input.copyTo(output)
                }
            }
            true
        } catch (_: Exception) {
            false
        }
    }
}