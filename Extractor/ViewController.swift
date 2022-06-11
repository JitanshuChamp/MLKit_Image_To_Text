import UIKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var cameraButton: UIButton!
  
  let processor = ElementScalingProcessor()
  var frameSublayer = CALayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    imageView.layer.addSublayer(frameSublayer)
  }
  
  @IBAction func cameraDidTouch(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      presentImagePickerController(withSourceType: .camera)
    } else {
      let alert = UIAlertController(title: "Camera Not Available", message: "A camera is not available. Please try picking an image from the image library instead.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func libraryDidTouch(_ sender: UIButton) {
    presentImagePickerController(withSourceType: .photoLibrary)
  }
  
  private func removeFrames() {
    guard let sublayers = frameSublayer.sublayers else { return }
    for sublayer in sublayers {
      sublayer.removeFromSuperlayer()
    }
  }
  
  private func drawFeatures(in imageView: UIImageView, completion: (() -> Void)? = nil) {
    removeFrames()
    processor.process(in: imageView) { text, elements in
      elements.forEach() { element in
        self.frameSublayer.addSublayer(element.shapeLayer)
      }
      self.speakText(text: text)
      completion?()
    }
  }
  
  func speakText(text: String){
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
  }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
  
  private func presentImagePickerController(withSourceType sourceType: UIImagePickerController.SourceType) {
    let controller = UIImagePickerController()
    controller.delegate = self
    controller.sourceType = sourceType
    controller.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
    present(controller, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let pickedImage =
      info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      
      imageView.contentMode = .scaleAspectFit
      let fixedImage = pickedImage.fixOrientation()
      imageView.image = fixedImage
      drawFeatures(in: imageView)
    }
    dismiss(animated: true, completion: nil)
  }
}
