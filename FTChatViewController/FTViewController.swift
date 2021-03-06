//
//  FTViewController.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class FTViewController: UIViewController{
    @IBOutlet weak var container: UIView!
    var chatVC:FTChatViewController!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tmp = storyboard.instantiateViewControllerWithIdentifier("ChatViewController") as? FTChatViewController {
            self.chatVC = tmp
            self.chatVC.view.frame = CGRectMake(0, 20, chatVC.view.frame.width, chatVC.view.frame.height-70)
            self.view.addSubview(chatVC.view)
            self.addChildViewController(self.chatVC)
        }
        
        //initTab
        
        var messages:[FTMessage] = []
        
        for i in 0 ... 50{
            var content:String?
            var image:UIImage?
            var source:FTMessageSource
            switch(i % 4){
            case 0:
                content = "+33600000000 dolor sit er elit, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna"
                source = .Remote
                break;
            case 1:
                content = "Hello"
                source = .Remote
                break;
            case 2:
                content = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna"
                source = .Local
                break;
            default:
                image = UIImage(named: "img.jpg")
                source = .Local
                break;
            }
            var date = NSDate().dateByAddingTimeInterval(NSTimeInterval(-(600.0*60)))
            if(i > 0){
                date = messages.last!.date.dateByAddingTimeInterval(NSTimeInterval((i%3 == 0 ? 0 : 5*60)))
            }
            if let _ = content{
                let message = FTMessage(messageWithContent: content!, atDate: date, from: source)
                messages.append(message)
            }else{
                let message = FTMessage(messageWithImage: image!, atDate: date, from: source)
                messages.append(message)
            }
            

        }
        
        self.chatVC.addMessages(messages)
        
        
    }

    @IBAction func send(sender: AnyObject) {
        if let _ = messageTextField.text {
        let date = NSDate()
        (self.childViewControllers[0] as! FTChatViewController).addMessage(FTMessage(messageWithContent: messageTextField.text!, atDate: date, from: .Local))
            messageTextField.text = ""
        }
    }
}