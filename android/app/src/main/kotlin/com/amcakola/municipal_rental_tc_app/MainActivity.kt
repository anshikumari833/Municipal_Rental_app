package com.amcakola.municipal_rental_tc_app

import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.amcakola.municipal_rental_tc_app/com.pinelabs.masterapp"
    private val REQUEST_CODE = 1004 // request code for startActivityForResult

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // Checking the Method Call
            if (call.method == "sendPaymentIntent") {
                // Constructing the Intent
//                val doTransactionPayload = "{},\"Header\"{\"ApplicationId\":\"1004\",\"MethodId\":\"1004\",\"UserId\":\"1234\",\"VersionNo\":\"1.0\"}"
                // Constructing the Intent
                val doTransactionPayload = """
            {
              "Detail": {
                "BillingRefNo": "TX12345678",
                "PaymentAmount": 9900,
                "TransactionType": 4001
              },
              "Header": {
                "ApplicationId": "48a78da62f144f209d8837b96d709e7a",
                "MethodId": "1001",
                "UserId": "1234",
                "VersionNo": "1.0"
              }
            }
            """
                // Log the request payload
                println("Request Payload: $doTransactionPayload")

                val intent = Intent("com.pinelabs.masterapp.HYBRID_REQUEST")
                intent.setPackage("com.pinelabs.masterapp")
                intent.putExtra("REQUEST_DATA", doTransactionPayload)
                intent.putExtra("packageName", "com.amcakola.municipal_rental_tc_app")
                // Starting the Activity
                try {
                    startActivityForResult(intent, REQUEST_CODE)
                    // handling the result in onActivityResult
                } catch (e: Throwable) {
                    result.error("SEND_INTENT_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    // Handleing the result of activity
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                // successfull result
                if (data != null) {
                    val responseData = data.getStringExtra("RESPONSE_DATA")
                    if (responseData != null) {
                        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("handleResponse", responseData)
                    }
                }
            } else {
            }
        }
    }
}