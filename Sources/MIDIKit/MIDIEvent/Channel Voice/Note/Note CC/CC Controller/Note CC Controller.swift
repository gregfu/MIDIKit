//
//  Note CC Controller.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

extension MIDIEvent.Note.CC {
    /// Per-Note Controller
    /// (MIDI 2.0)
    public enum Controller: Equatable, Hashable {
        /// Registered Per-Note Controller
        case registered(Registered)
        
        /// Assignable Per-Note Controller (Non-Registered)
        case assignable(Assignable)
    }
}

extension MIDIEvent.Note.CC.Controller: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .registered(cc):
            return "registered(\(cc.number))"
            
        case let .assignable(cc):
            return "assignable(\(cc))"
        }
    }
}

extension MIDIEvent.Note.CC.Controller {
    /// Returns the controller number.
    @inline(__always)
    public var number: UInt8 {
        switch self {
        case let .registered(cc):
            return cc.number
            
        case let .assignable(cc):
            return cc
        }
    }
}
