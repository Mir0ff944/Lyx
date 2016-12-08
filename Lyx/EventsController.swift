//
//  EventsController.swift
//  Lyx
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import UIKit
import Events
//import QuartzCore

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
    @IBOutlet var startTime: UILabel!
    @IBOutlet var performerLb: UILabel!
    @IBOutlet var venueName: UILabel!
    @IBOutlet var performerbio: UILabel!
    @IBOutlet var venueDetails: UIView!
    @IBOutlet var performerViewHeight: NSLayoutConstraint!
    @IBOutlet var venue: UILabel!



    
    /// Loads the data passed from TableControlle's table view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryView.layer.cornerRadius = 5
        eventDescription.layer.cornerRadius = 5
        descriptionView.layer.cornerRadius = 5
        venueDetails.layer.cornerRadius = 5
        
        
        DispatchQueue.main.async {
            self.eventTitle?.text = self.event?.title
            self.city?.text = self.event?.city
            self.eventAddress?.text = self.event?.address
            self.eventDescription?.text = self.event?.description
            self.startTime?.text = self.event?.start
            self.performerLb?.text = self.event?.performerName
            self.performerbio?.text = self.event?.performerBio
            self.venueName?.text = self.event?.venue
            if self.event?.image != nil {
                let url = NSURL(string: (self.event?.image)!)
                self.imageUI = NSData(contentsOf: url! as URL)
                if self.imageUI != nil {
                    self.imageView?.image = UIImage(data: self.imageUI! as Data)
                }
            }
            self.summaryViewHeight.constant = self.imageView.frame.height + 20
            self.descriptionViewHeight.constant = self.eventDescription.frame.height + 20
            self.performerViewHeight.constant = self.venue.frame.height + self.venueName.frame.height + self.startTime.frame.height + 20
            print("summary Height \(self.summaryViewHeight)")
            print("description height \(self.descriptionViewHeight)")
            let frameHeight = self.summaryView.frame.height + self.descriptionView.frame.height + 80
            print("frame height \(frameHeight)")
            let size = CGSize(width: self.contentView.frame.width, height: frameHeight)
            self.contentView.frame.size = size
            self.scrollView.contentSize = size
            self.summaryView.sizeToFit()
            self.contentView.sizeToFit()
        }


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
