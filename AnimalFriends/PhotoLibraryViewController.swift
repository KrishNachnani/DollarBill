//
//  PhotoLibraryViewController.swift
//  DollarBill
//
//  Created by Krish Nachnani on 9/8/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation

class PhotoLibraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var AnswerLabel: UILabel!
    
    let dollarnames = ["1dollarback":"the back of a one dollar bill.", "1dollarfront":"the front of a one dollar bill.", "5dollarsback":"the back of a five dollar bill.", "5dollarsfront":"the front of a five dollar bill.", "10dollarsback":"the back of a ten dollar bill.", "10dollarsfront":"the front of a ten dollar bill.", "20dollarsback":"the back of a twenty dollar bill.", "20dollarsfront":"the front of a twenty dollar bill.", "50dollarsback":"the back of a fifty dollar bill.", "50dollarsfront":"the front of a fifty dollar bill."]

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
        //let uploadURL = "https://3h6ys7t373.execute-api.us-east-1.amazonaws.com/Predict/03378121-5f5b-4e24-8b5b-7a029003f2a4"
        //let uploadURL = "https://svexr6i4fi.execute-api.us-east-1.amazonaws.com/Predict/93396303-c75a-49d0-9736-c540ca073768"
        let uploadURL = "https://askai.aiclub.world/08f9ac85-ffc6-4dae-b533-5fb5089b5598"
        
        AF.upload(imageB64, to: uploadURL).responseJSON { [self] response in
            
            debugPrint(response)
            switch response.result {
               case .success(let responseJsonStr):
                   print("\n\n Success value and JSON: \(responseJsonStr)")
                   let myJson = JSON(responseJsonStr)
                   let predictedValue = myJson["predicted_label"].string
                   print("Saw predicted value \(String(describing: predictedValue))")
                let predictionMessage = "This is " + dollarnames[predictedValue!]!
                   self.AnswerLabel.text=predictionMessage
                self.say(string: predictionMessage)

               case .failure(let error):
                   print("\n\n Request failed with error: \(error)")
              

               }
            
        }
        
    }
}
