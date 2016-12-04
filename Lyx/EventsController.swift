//
//  EventsController.swift
//  Lyx
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import UIKit

class EventsController: UIViewController {

    var eventID: String?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var summaryView: UIView!
    @IBOutlet var descriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = self.eventID {
            print("ID: \(id)")
            DispatchQueue.main.async {
                let frameHeight = self.summaryView.frame.height + self.descriptionView.frame.height + 25
                print("frame height \(frameHeight)")
                let size = CGSize(width: self.contentView.frame.width, height: frameHeight)
                self.contentView.frame.size = size
                self.scrollView.contentSize = size
                
            }
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
