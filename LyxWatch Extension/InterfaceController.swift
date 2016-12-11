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
    
    var performer: Artist?

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        try? Eventim.sharedInstance.searchPerformer(withText: "Eminem", { () in
            print("search complete")
            self.eventTitle?.setText(self.performer?.title)
            self.eventDetails.setText(self.performer?.ganre)
            self.eventDesc?.setText(self.performer?.id)
            
        })
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
