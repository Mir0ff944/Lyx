//
//  InterfaceController.swift
//  LyxWatch Extension
//
//  Created by Miroslav Ivanov on 10/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import WatchKit
import Foundation
import LyxWatchFramework



class InterfaceController: WKInterfaceController {

    @IBOutlet var performerTitle: WKInterfaceLabel!
    @IBOutlet var performerDetails: WKInterfaceLabel!
    @IBOutlet var performerDesc: WKInterfaceLabel!
    @IBOutlet var performerImage: WKInterfaceImage!
    
    
    var Performer: Artist? {
        didSet {
            performerDetails.setText(Performer?.genre)
            performerDesc.setText(Performer?.id)
            performerTitle.setText(Performer?.title)
            if let url = NSURL(string: (Performer?.image)!) {
                if let data = NSData(contentsOf: url as URL){
                    
                    performerImage.setImage(UIImage(data: data as Data))
                    
                }
            }
        }
    }

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        try? Eventim.sharedInstance.searchPerformer({ (performer) in
            DispatchQueue.main.async {
                self.Performer = performer
            }
        })
        
        
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
