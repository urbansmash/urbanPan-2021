//
//  Conductor.swift
//  MIDIView
//
//  Created by Evan Murray on 7/15/20.
//

import Foundation
import AudioKit

class Conductor {
    var sampler: MIDISampler
    var sequencer: AppleSequencer
    
    init(){
        sampler = MIDISampler(name: "Track")
        sequencer = AppleSequencer()
    }
    
    func loadSequencerWithFile(url: URL) {
        sequencer = AppleSequencer(fromURL: url)
    }
}
