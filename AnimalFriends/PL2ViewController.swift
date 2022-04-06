// PL2ViewController.swift
// DollarBill
//
// Created by Krish Nachnani on 9/8/21.
//
import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
class PL2ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @IBOutlet weak var TopLabel: UILabel!
  @IBOutlet weak var ImageView: UIImageView!
  @IBOutlet weak var AnswerLabel: UILabel!
  let dollarnames = ["1back":"the back of a one dollar bill.", "1front":"the front of a one dollar bill.", "5back":"the back of a five dollar bill.", "5front":"the front of a five dollar bill.", "10back":"the back of a ten dollar bill.", "10front":"the front of a ten dollar bill.", "20back":"the back of a twenty dollar bill.", "20front":"the front of a twenty dollar bill.", "50back":"the back of a fifty dollar bill.", "50front":"the front of a fifty dollar bill.", "100front": "the front of a hundred dollar bill.", "100back": "the back of a hundred dollar bill."]
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  func getPhotoFromLibrary() {
    print("Button pressed, get photo from library")
    let vc = UIImagePickerController()
    //vc.sourceType = .camera
    vc.sourceType = .photoLibrary
    vc.allowsEditing = true
    vc.delegate = self
    present(vc, animated: true)
    AnswerLabel.text = "Getting Image..."
  }
  override func viewDidAppear(_ animated: Bool) {
    getPhotoFromLibrary()
  }/*
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  */
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    guard let image = info[.editedImage] as? UIImage else {
      print("An error occured: no image found")
      return
    }
    // print out the image size as a test
    ImageView.image = image
    print(image.size)
    AnswerLabel.text = "Checking..."
    let imageJPG = image.jpegData(compressionQuality: 0.0034)
    processFile(image:imageJPG!)
    //buttonMain.isHidden = false
    //buttonSecond.isHidden = false
  }
  func say(string: String) {
    let utterance = AVSpeechUtterance(string: string)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.rate = 0.5
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
  }
  func processFile(image: Data) {
    let imageB64 = Data(image).base64EncodedData()
    let uploadURL = "https://askai.aiclub.world/b04efb1f-1fc5-4009-9b94-725b3809d3d2"
    AF.upload(imageB64, to: uploadURL).responseJSON { [self] response in
      debugPrint(response)
      switch response.result {
        case .success(let responseJsonStr):
          print("\n\n Success value and JSON: \(responseJsonStr)")
          let myJson = JSON(responseJsonStr)
          let predictedValue = myJson["predicted_label"].string
          print("API1 Saw predicted value \(String(describing: predictedValue))")
        self.processAPI2(imageB64: imageB64, AIType: predictedValue!)
        case .failure(let error):
          print("\n\n Request failed with error: \(error)")
        }
    }
  }
  func processAPI2(imageB64: Data, AIType:String) {
    let apiCloseup = "https://askai.aiclub.world/e045e9b4-18fb-4e72-b4f4-e9bfc68f6f45"
    let apiWithBackground = "https://askai.aiclub.world/08f9ac85-ffc6-4dae-b533-5fb5089b5598"
    let apiRotated = "https://askai.aiclub.world/5c562cba-c1b1-486c-97e1-b6e2b66ed341"
    let API2 = ["closeup":apiCloseup, "withbackground":apiWithBackground, "rotated":apiRotated]
    //let imageB64 = Data(image).base64EncodedData()
    let uploadURL = API2[AIType]!
    print("API2 \(AIType) CallsURL \(uploadURL)")
    AF.upload(imageB64, to: uploadURL).responseJSON { [self] response in
      debugPrint(response)
      switch response.result {
        case .success(let responseJsonStr):
          print("\n\n Success value and JSON: \(responseJsonStr)")
          let myJson = JSON(responseJsonStr)
          let predictedValue = myJson["predicted_label"].string
          print("API2 Saw predicted value \(String(describing: predictedValue))")
        let predictionMessage = "This is " + dollarnames[predictedValue!]!
          self.AnswerLabel.text=predictionMessage
        self.say(string: predictionMessage)
        case .failure(let error):
          print("\n\n Request failed with error: \(error)")
        }
    }
  }
}
