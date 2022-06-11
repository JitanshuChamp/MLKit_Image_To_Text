
Feature text detection from image and read it out
1. Multiple ways can be used for solving this problem using Microsoft cognitive api's, MLKit for firebase
2. I have experience using firebase MLKit so choosing that to solve this problem
3. Also detecting text using this can be achived using ondevice detection as well as cloud recognition
4. I am going to use MLVisionTextModel
5. capturing image can be in portrait or landscape mode so will add rotation check and rotate image accordingly ( Reference: https://gist.github.com/schickling/b5d86cb070130f80bb40 )
6. Drawing boxes around detected text to see how much accurately it is working and what is being captured ( Reference: https://stackoverflow.com/questions/60267263/swiftui-drawing-rectangles-around-elements-recognized-with-firebase-ml-kit )
7. After text detection I want to the app to read what is scanned
8. Using native AVFoundation framework and AVSpeechSynthesizer to read the text after detection (Reference: hackingwithswift.com/example-code/media/how-to-convert-text-to-speech-using-avspeechsynthesizer-avspeechutterance-and-avspeechsynthesisvoice)
