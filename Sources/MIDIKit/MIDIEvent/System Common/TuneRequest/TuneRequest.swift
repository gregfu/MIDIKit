//
//  TuneRequest.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

extension MIDIEvent {
    /// System Common: Tune Request
    /// (MIDI 1.0 / 2.0)
    ///
    /// - remark: MIDI Spec:
    ///
    /// "Used with analog synthesizers to request that all oscillators be tuned."
    public struct TuneRequest: Equatable, Hashable {
        /// UMP Group (0x0...0xF)
        public var group: UInt4 = 0x0
        
        public init(group: UInt4 = 0x0) {
            self.group = group
        }
    }
    
    /// System Common: Tune Request
    /// (MIDI 1.0 / 2.0)
    ///
    /// - remark: MIDI Spec:
    ///
    /// "Used with analog synthesizers to request that all oscillators be tuned."
    ///
    /// - Parameters:
    ///   - group: UMP Group (0x0...0xF)
    @inline(__always)
    public static func tuneRequest(group: UInt4 = 0x0) -> Self {
        .tuneRequest(
            .init(group: group)
        )
    }
}

extension MIDIEvent.TuneRequest {
    /// Returns the raw MIDI 1.0 message bytes that comprise the event.
    ///
    /// - Note: This is mainly for internal use and is not necessary to access during typical usage of MIDIKit, but is provided publicly for introspection and debugging purposes.
    @inline(__always)
    public func midi1RawBytes() -> [Byte] {
        [0xF6]
    }
    
    /// Returns the raw MIDI 2.0 UMP (Universal MIDI Packet) message bytes that comprise the event.
    ///
    /// - Note: This is mainly for internal use and is not necessary to access during typical usage of MIDIKit, but is provided publicly for introspection and debugging purposes.
    @inline(__always)
    public func umpRawWords() -> [UMPWord] {
        let umpMessageType: UniversalMIDIPacketData
            .MessageType = .systemRealTimeAndCommon
        
        let mtAndGroup = (umpMessageType.rawValue.uInt8Value << 4) + group
        
        let word = UMPWord(
            mtAndGroup,
            0xF6,
            0x00, // pad empty bytes to fill 4 bytes
            0x00
        ) // pad empty bytes to fill 4 bytes
        
        return [word]
    }
}
