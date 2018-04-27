//
//  InterfaceController.swift
//  MusicPlayer WatchKit Extension
//
//  Created by Restricted on 12/22/17.
//  Copyright © 2017 Restricted. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    //MARK: Properties
    @IBOutlet var playButton: WKInterfaceButton!

    @IBOutlet var volumeSlider: WKInterfaceSlider!
    
    enum SongState {
        case Playing
        case Paused
    }
    
    var currentVolumeLevel: Float = 1.0
    let numberOfSteps = 3
    
    var songState: SongState = .Paused
    
    //using the crownDidRotate
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        let predictedVolumeLevel = currentVolumeLevel +
        Float(rotationalDelta) * 10
        
        if predictedVolumeLevel > 0.0 && predictedVolumeLevel <= Float(numberOfSteps) {
            currentVolumeLevel = predictedVolumeLevel
            
            volumeSlider.setValue(currentVolumeLevel)
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //set the crown delegate
        crownSequencer.focus()
        crownSequencer.delegate = self
        
        // Configure interface objects here.
        
        volumeSlider.setNumberOfSteps(numberOfSteps)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    //MARK: Actions

    @IBAction func playButtonTapped() {
        if songState == .Paused {
            songState = .Playing
            playButton.setBackgroundImage(UIImage(named: "Pause"))
        } else {
            songState = .Paused
            playButton.setBackgroundImage(UIImage(named: "Playing"))
        }
        
            }
    @IBAction func sliderAction(_ value: Float) {
      //update the currentVolumeLevel variable
        currentVolumeLevel = value
    }
}
