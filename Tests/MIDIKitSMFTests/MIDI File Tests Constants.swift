//
//  MIDI File Tests Constants.swift
//  MIDIKitSMF • https://github.com/orchetect/MIDIKitSMF
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import MIDIKitSMF

enum kMIDIFile {
    // swiftformat:options --wrapcollections preserve
    // swiftformat:disable spaceInsideParens spaceInsideBrackets spacearoundoperators
    // swiftformat:options --maxwidth none
    
    /// Example Digital Performer 8 MIDI file export containing marker and cue point events.
    static let DP8Markers: [Byte] = [
        0x4D, 0x54, 0x68, 0x64, // MThd
        0x00, 0x00, 0x00, 0x06, // 6 header bytes
        0x00, 0x01, // type 1 file
        0x00, 0x03, // 3 tracks
        0x01, 0xE0, // musical divisions, 480 ticks per quarter
        
        // track 1
        0x4D, 0x54, 0x72, 0x6B, // MTrk
        0x00, 0x00, 0x00, 0xBE, // track length
        0x00, 0xFF, 0x03, 0x05, 0x53, 0x65, 0x71, 0x2D, 0x31, // track name
        0x00, 0xFF, 0x54, 0x05, 0x40, 0x00, 0x00, 0x00, 0x00, // SMPTE offset
        0x00, 0xFF, 0x58, 0x04, 0x04, 0x02, 0x18, 0x08, // time signature
        0x00, 0xFF, 0x51, 0x03, 0x07, 0xA1, 0x20, // tempo
        // marker
        0x81, 0xD2, 0xF8, 0x00, 0xFF, 0x06, 0x1A, 0x55,
        0x6E, 0x6C, 0x6F, 0x63, 0x6B, 0x65, 0x64, 0x20,
        0x4D, 0x61, 0x72, 0x6B, 0x65, 0x72, 0x20, 0x31,
        0x5F, 0x30, 0x30, 0x5F, 0x30, 0x30, 0x5F, 0x30,
        0x30,
        // cue point
        0x87, 0x40, 0xFF, 0x07, 0x18, 0x4C, 0x6F, 0x63,
        0x6B, 0x65, 0x64, 0x20, 0x4D, 0x61, 0x72, 0x6B,
        0x65, 0x72, 0x20, 0x31, 0x5F, 0x30, 0x30, 0x5F,
        0x30, 0x31, 0x5F, 0x30, 0x30,
        // marker
        0x87, 0x40, 0xFF, 0x06, 0x1A, 0x55, 0x6E, 0x6C,
        0x6F, 0x63, 0x6B, 0x65, 0x64, 0x20, 0x4D, 0x61,
        0x72, 0x6B, 0x65, 0x72, 0x20, 0x31, 0x5F, 0x30,
        0x30, 0x5F, 0x30, 0x32, 0x5F, 0x30, 0x30,
        // cue point
        0x87, 0x40, 0xFF, 0x07, 0x18, 0x4C, 0x6F, 0x63,
        0x6B, 0x65, 0x64, 0x20, 0x4D, 0x61, 0x72, 0x6B,
        0x65, 0x72, 0x20, 0x31, 0x5F, 0x30, 0x30, 0x5F,
        0x30, 0x33, 0x5F, 0x30, 0x30,
        // marker
        0x87, 0x40, 0xFF, 0x06, 0x1A, 0x55, 0x6E, 0x6C,
        0x6F, 0x63, 0x6B, 0x65, 0x64, 0x20, 0x4D, 0x61,
        0x72, 0x6B, 0x65, 0x72, 0x20, 0x31, 0x5F, 0x30,
        0x30, 0x5F, 0x30, 0x34, 0x5F, 0x30, 0x30,
        0x00, 0xFF, 0x2F, 0x00, // end of track
        
        // track 2
        0x4D, 0x54, 0x72, 0x6B, // MTrk
        0x00, 0x00, 0x00, 0x1A, // track length
        0x00, 0xFF, 0x03, 0x06, 0x4D, 0x49, 0x44, 0x49, 0x2D, 0x31, // track name
        0x81, 0xD3, 0x8E, 0x77, 0x90, 0x3B, 0x40, // note on
        0x86, 0x60, 0x80, 0x3B, 0x40, // note off
        0x00, 0xFF, 0x2F, 0x00, // end of track
        
        // track 3
        0x4D, 0x54, 0x72, 0x6B, // MTrk
        0x00, 0x00, 0x00, 0x13, // track length
        0x00, 0xFF, 0x03, 0x06, 0x4D, 0x49, 0x44, 0x49, 0x2D, 0x32, // track name
        0x00, 0xFF, 0x20, 0x01, 0x00, // channel prefix: chan 0
        0x00, 0xFF, 0x2F, 0x00 // end of track
    ]
}
