//
//  ViewController.swift
//  AnimalFriends
//
//  Created by Krish Nachnani on 7/27/21.
//
import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var CentralImage: UIImageView!
    
    
    
    let dollarnames = ["1dollarback":"the back of a one dollar bill.", "1dollarfront":"the front of a one dollar bill.", "5dollarsback":"the back of a five dollar bill.", "5dollarsfront":"the front of a five dollar bill.", "10dollarsback":"the back of a ten dollar bill.", "10dollarsfront":"the front of a ten dollar bill.", "20dollarsback":"the back of a twenty dollar bill.", "20dollarsfront":"the front of a twenty dollar bill.", "50dollarsback":"the back of a fifty dollar bill.", "50dollarsfront":"the front of a fifty dollar bill."]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //buttonMain.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        //buttonMain.backgroundColor = UIColor.blue
        CentralImage.isHidden = true
        Button1.backgroundColor = UIColor.blue
        Button2.backgroundColor = UIColor.green
        Button2.isHidden = true
        Button1.isHidden = true
        topLabel.adjustsFontForContentSizeCategory = true
    
        
        
    }

    
    
    
    //
    
        
        
    }
