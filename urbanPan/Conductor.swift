//
//  Conductor.swift
//  SamplerDemo
//
//  Created by Shane Dunne, revision history on Githbub.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import AudioKit
import CoreMIDI

class Conductor {
    
    //Class methods can now be accessed using Conductor.shared.methodName()
    static let shared = Conductor()
    
    //Create a midi object referring to the class AKMIDI()
    let midi = AKMIDI()
    //Create a new sampler object of type AKAppleSampler
    var sampler: AKSampler
    var midiFile: AKAppleSequencer!
    var midiFileConnector: AKMIDINode!
    var reverb: AKReverb!
    var importedMIDIURL: URL!

    init() {
        
        AKSettings.enableLogging = false
        
        // MIDI Configure - (Methods from the AKMIDI class instance we created)
        
        /// Create set of virtual input and output MIDI ports
        midi.createVirtualPorts()
        
        ///Open midi input port by name
        midi.openInput(name: "Session 1")
        
        //Default function to open the output port
        midi.openOutput()
        
        //Buffer length = amount of samples/time - quality of rendering - increases latency the more you increase it
        AKSettings.bufferLength = .short
        
        //Set the volume property of our new sampler object
        
        //Sampler Object - Allows us to play a soundfont as an instrument
        sampler = AKSampler()

        // Set up the AKSampler
        setupSampler()
        
        reverb = AKReverb(sampler, dryWetMix: 0.5)

        // Set Output & Start AudioKit
        AKManager.output = reverb
        do {
            try AKManager.start()
        } catch {
        }
    }
    
    func playSound() {
        
        // Signal Chain
        
        midiFile = AKAppleSequencer(fromURL: importedMIDIURL)
        
        midiFileConnector = AKMIDINode(node: sampler)
        
        midiFile.setGlobalMIDIOutput(midiFileConnector.midiIn)
        
        midiFile.play()
    }

    private func setupSampler() {
        //Example (below) of loading compressed sample files without a SFZ file
        //loadAndMapCompressedSampleFiles()

        //referred method: use SFZ file
        //You can download a small set of ready-to-use SFZ files and samples from
        // http://audiokit.io/downloads/ROMPlayerInstruments.zip
        // see loadSamples(byIndex:) below

        sampler.attackDuration = 0.01
        sampler.decayDuration = 0.1
        sampler.sustainLevel = 0.8
        sampler.releaseDuration = 0.5

        sampler.filterEnable = true
        sampler.filterCutoff = 20.0
        sampler.filterAttackDuration = 1.0
        sampler.filterDecayDuration = 1.0
        sampler.filterSustainLevel = 0.5
        sampler.filterReleaseDuration = 10.0
    }

    //Method to load a sample and takes in the index (number of samples to load). we don't load more than 4 at once, and we can't load negative samples. That doesn't make sense.
    func loadSamples(byIndex: Int) {
        
        //exit the function if the sample index is negative or greater than 3
        if byIndex < 0 || byIndex > 3 { return }

        let sfzFiles = ["000_urbanPan.sfz"]
        
        
        
        sampler.loadSFZ(path: Bundle.main.resourcePath! + "/", fileName: sfzFiles[byIndex])
        //load the actual .wav samples
        sampler.loadSfzWithEmbeddedSpacesInSampleNames(folderPath: Bundle.main.resourcePath! + "/",
                                                       sfzFileName: sfzFiles[byIndex])
    }

}
