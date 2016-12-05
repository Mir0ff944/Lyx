//
//  EventsController.swift
//  Lyx
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import UIKit
import Events

class EventsController: UIViewController {

    //var eventID: String?
    var event: String?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var summaryView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var descriptionViewHeight: NSLayoutConstraint!
    @IBOutlet var summaryViewHeight: NSLayoutConstraint!
    @IBOutlet var city: UILabel!
    @IBOutlet var eventAddress: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle?.text = self.event
//        eventDescription?.text = Eventim.sharedInstance.getEvent(forIndex: IndexPath).city
        
//        if let id = self.eventID {
//            print("ID: \(id)")
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            try? Eventim.sharedInstance.getDetails(withID: id, { (Events) in
//                DispatchQueue.main.async {
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    self.summaryViewHeight.constant = self.eventImage.frame.height + 16
//                    self.descriptionViewHeight.constant = self.eventDescription.frame.height + 16
//                    print("summary Height \(self.summaryViewHeight)")
//                    print("description height \(self.descriptionViewHeight)")
//                    let frameHeight = self.summaryView.frame.height + self.descriptionView.frame.height + 25
//                    print("frame height \(frameHeight)")
//                    let size = CGSize(width: self.contentView.frame.width, height: frameHeight)
//                    self.contentView.frame.size = size
//                    self.scrollView.contentSize = size
//                    self.summaryView.sizeToFit()
//                    self.contentView.sizeToFit()
//                    
//                }
//            })
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
