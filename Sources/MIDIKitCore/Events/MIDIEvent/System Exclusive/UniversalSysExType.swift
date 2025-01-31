//
//  UniversalSysExType.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

extension MIDIEvent {
    /// Universal System Exclusive message type.
    public enum UniversalSysExType: UInt7, Equatable, Hashable {
        /// Real-Time System Exclusive ID number (`0x7F`).
        case realTime = 0x7F
    
        /// Non- Real-Time System Exclusive ID number (`0x7E`).
        case nonRealTime = 0x7E
    
        // Note: this cannot be implemented as `init?(rawValue: UInt8)` because
        // Xcode 12.4 won't compile (Xcode 13 compiles fine however).
        // It seems the parameter name "rawValue:" confuses the compiler
        // and prevents it from synthesizing its own `init?(rawValue: UInt7)` init.
        /// Universal System Exclusive message type.
        ///
        /// Initialize from raw UInt8 byte.
        public init?(rawUInt8Value: UInt8) {
            guard let uInt7 = UInt7(exactly: rawUInt8Value) else { return nil }
    
            self.init(rawValue: uInt7)
        }
    }
}

extension MIDIEvent.UniversalSysExType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .realTime: return "realTime"
        case .nonRealTime: return "nonRealTime"
        }
    }
}
