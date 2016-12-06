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

//    var eventID: String?
    var event: Event?
    var imageUI: NSData?
    
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
    @IBOutlet var imageView: UIImageView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle?.text = event?.title
        city?.text = event?.city
        eventAddress?.text = event?.address
        eventDescription?.text = event?.description
//        let url = NSURL(string: (event?.image)!)
//        imageUI = NSData(contentsOf: url! as URL)
//        if imageUI != nil {
//            imageView?.image = UIImage(data: imageUI! as Data)
//        }
        

        
//        if let id = self.event {
//            print("ID: \(id)")
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            try? Eventim.sharedInstance.getDetails(withID: id, { (Events) in
//                DispatchQueue.main.async {
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    self.city.text = Events.city
//                    self.eventAddress.text = Events.region
//                   // self.summaryViewHeight.constant = self.eventImage.frame.height + 16
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
