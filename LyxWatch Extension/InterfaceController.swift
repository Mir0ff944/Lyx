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

    @IBOutlet var eventTitle: WKInterfaceLabel!
    @IBOutlet var eventDetails: WKInterfaceLabel!
    @IBOutlet var eventDesc: WKInterfaceLabel!
    
    var event: Event?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        try? Eventim.sharedInstance.searchEvent(withText: "London", { () in
            print("search complete")
        })
        self.eventTitle?.setText(self.event?.title)
        self.eventDetails.setText(self.event?.address)
        self.eventDesc?.setText(self.event?.description)
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
