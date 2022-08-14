//
//  AppDelegate.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Cocoa
import MIDIKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let midiManager = MIDIManager(
        clientName: "TestAppMIDIManager",
        model: "TestApp",
        manufacturer: "MyCompany"
    )
    
    let virtualInputName = "TestApp Input"
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        do {
            print("Starting MIDI services.")
            try midiManager.start()
        } catch {
            print("Error starting MIDI services:", error.localizedDescription)
        }
        
        do {
            print("Creating virtual MIDI input.")
            try midiManager.addInput(
                name: virtualInputName,
                tag: virtualInputName,
                uniqueID: .userDefaults(key: virtualInputName),
                receiveHandler: .eventsLogging(filterActiveSensingAndClock: true)
            )
        } catch {
            print("Error creating virtual MIDI input:", error.localizedDescription)
        }
    }
}
