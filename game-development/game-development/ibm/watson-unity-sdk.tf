
    # This is an example of how to use the Watson Unity SDK, you can modify it to fit your needs.

# Import the Watson Unity SDK
using IBM.Watson.SpeechToText.V1;
using IBM.Cloud.SDK.Core.Service;
using IBM.Cloud.SDK.Core.Authentication;
using UnityEngine;
using System.Collections;

public class SpeechToTextExample : MonoBehaviour
{
    // Initialize the Speech to Text service
    private SpeechToText service;

    // Set the API key and URL
    private string apiKey = "YOUR_API_KEY"; // Replace with your API key
    private string url = "YOUR_API_URL"; // Replace with your API URL

    void Start()
    {
        // Create a new instance of the Speech to Text service
        service = new SpeechToText(new Credentials(apiKey, url));

        // Start the speech recognition
        service.Recognize(OnRecognize, OnRecognizeError);
    }

    // Callback for successful speech recognition
    private void OnRecognize(SpeechRecognitionResult result)
    {
        Debug.Log("Recognized text: " + result.Results[0].Alternatives[0].Transcript);
    }

    // Callback for error during speech recognition
    private void OnRecognizeError(SpeechRecognitionError error)
    {
        Debug.LogError("Speech recognition error: " + error.Message);
    }
}

  