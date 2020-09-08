//
//  ViewController.swift
//  urbanPan
//
//  Created by URBANSMASH pro on 29/08/2019.
//  Copyright © 2019 Play it on Pan. All rights reserved.
//

import UIKit
import AVFoundation
import AudioKit

class ViewController: UIViewController {
    
    var document: UIDocument?
    
    var noteNum = 0
    
    var currentSound = 0
    
    var conductor = Conductor.shared

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteNum = 0
        
        currentSound = 0
        
        document?.open(completionHandler: { (success) in
            if success {
                self.conductor.importedMIDIURL = (self.document?.fileURL)!
                self.conductor.loadSamples(byIndex: self.currentSound)
                self.conductor.playSound()
            } else {
            }
        })
        
    }
    
    @IBAction func playNote(_ sender: UIButton) {
        conductor.sampler.play(noteNumber: MIDINoteNumber(sender.tag), velocity: 90)
    }
    
    @IBAction func stopNote(_ sender: UIButton) {
        conductor.sampler.stop(noteNumber: MIDINoteNumber(sender.tag))
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.conductor.midiFile.stop()
            self.document?.close(completionHandler: nil)
        }
    }
}
