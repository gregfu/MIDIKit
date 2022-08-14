//
//  Note Pressure.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

extension MIDIEvent.Note {
    /// Channel Voice Message: Polyphonic Aftertouch
    /// (MIDI 1.0 / 2.0)
    ///
    /// Also known as:
    /// - Pro Tools: "Polyphonic Aftertouch"
    /// - Logic Pro: "Polyphonic Aftertouch"
    /// - Cubase: "Poly Pressure"
    public struct Pressure: Equatable, Hashable {
        /// Note Number for which pressure is applied
        public var note: MIDINote
        
        /// Pressure Amount
        @AmountValidated
        public var amount: Amount
        
        /// Channel Number (0x0...0xF)
        public var channel: UInt4
        
        /// UMP Group (0x0...0xF)
        public var group: UInt4 = 0x0
        
        /// Channel Voice Message: Polyphonic Aftertouch
        /// (MIDI 1.0 / 2.0)
        ///
        /// Also known as:
        /// - Pro Tools: "Polyphonic Aftertouch"
        /// - Logic Pro: "Polyphonic Aftertouch"
        /// - Cubase: "Poly Pressure"
        public init(
            note: UInt7,
            amount: Amount,
            channel: UInt4,
            group: UInt4 = 0x0
        ) {
            self.note = MIDINote(note)
            self.amount = amount
            self.channel = channel
            self.group = group
        }
        
        /// Channel Voice Message: Polyphonic Aftertouch
        /// (MIDI 1.0 / 2.0)
        ///
        /// Also known as:
        /// - Pro Tools: "Polyphonic Aftertouch"
        /// - Logic Pro: "Polyphonic Aftertouch"
        /// - Cubase: "Poly Pressure"
        public init(
            note: MIDINote,
            amount: Amount,
            channel: UInt4,
            group: UInt4 = 0x0
        ) {
            self.note = note
            self.amount = amount
            self.channel = channel
            self.group = group
        }
    }
}

extension MIDIEvent {
    /// Channel Voice Message: Polyphonic Aftertouch
    /// (MIDI 1.0 / 2.0)
    ///
    /// Also known as:
    /// - Pro Tools: "Polyphonic Aftertouch"
    /// - Logic Pro: "Polyphonic Aftertouch"
    /// - Cubase: "Poly Pressure"
    ///
    /// - Parameters:
    ///   - note: Note Number for which pressure is applied
    ///   - amount: Pressure Amount
    ///   - channel: Channel Number (0x0...0xF)
    ///   - group: UMP Group (0x0...0xF)
    @inline(__always)
    public static func notePressure(
        note: UInt7,
        amount: Note.Pressure.Amount,
        channel: UInt4,
        group: UInt4 = 0x0
    ) -> Self {
        .notePressure(
            .init(
                note: note,
                amount: amount,
                channel: channel,
                group: group
            )
        )
    }
    
    /// Channel Voice Message: Polyphonic Aftertouch
    /// (MIDI 1.0 / 2.0)
    ///
    /// Also known as:
    /// - Pro Tools: "Polyphonic Aftertouch"
    /// - Logic Pro: "Polyphonic Aftertouch"
    /// - Cubase: "Poly Pressure"
    ///
    /// - Parameters:
    ///   - note: Note Number for which pressure is applied
    ///   - amount: Pressure Amount
    ///   - channel: Channel Number (0x0...0xF)
    ///   - group: UMP Group (0x0...0xF)
    @inline(__always)
    public static func notePressure(
        note: MIDINote,
        amount: Note.Pressure.Amount,
        channel: UInt4,
        group: UInt4 = 0x0
    ) -> Self {
        .notePressure(
            .init(
                note: note.number,
                amount: amount,
                channel: channel,
                group: group
            )
        )
    }
}

extension MIDIEvent.Note.Pressure {
    /// Returns the raw MIDI 1.0 message bytes that comprise the event.
    ///
    /// - Note: This is mainly for internal use and is not necessary to access during typical usage of MIDIKit, but is provided publicly for introspection and debugging purposes.
    @inline(__always)
    public func midi1RawBytes() -> [Byte] {
        [
            0xA0 + channel.uInt8Value,
            note.number.uInt8Value,
            amount.midi1Value.uInt8Value
        ]
    }
    
    @inline(__always)
    private func umpMessageType(
        protocol midiProtocol: MIDIProtocolVersion
    ) -> UniversalMIDIPacketData.MessageType {
        switch midiProtocol {
        case ._1_0:
            return .midi1ChannelVoice
            
        case ._2_0:
            return .midi2ChannelVoice
        }
    }
    
    /// Returns the raw MIDI 2.0 UMP (Universal MIDI Packet) message bytes that comprise the event.
    ///
    /// - Note: This is mainly for internal use and is not necessary to access during typical usage of MIDIKit, but is provided publicly for introspection and debugging purposes.
    @inline(__always)
    public func umpRawWords(
        protocol midiProtocol: MIDIProtocolVersion
    ) -> [UMPWord] {
        let mtAndGroup = (umpMessageType(protocol: midiProtocol).rawValue.uInt8Value << 4) + group
        
        switch midiProtocol {
        case ._1_0:
            let word = UMPWord(
                mtAndGroup,
                0xA0 + channel.uInt8Value,
                note.number.uInt8Value,
                amount.midi1Value.uInt8Value
            )
            
            return [word]
            
        case ._2_0:
            let word1 = UMPWord(
                mtAndGroup,
                0xA0 + channel.uInt8Value,
                note.number.uInt8Value,
                0x00
            ) // reserved
            
            let word2 = amount.midi2Value
            
            return [word1, word2]
        }
    }
}
