//
//  PhotoLibraryViewController.swift
//  DollarBill
//
//  Created by Krish Nachnani on 9/8/21.
//

import UIKit

class PhotoLibraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var AnswerLabel: UILabel!
    

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

}
