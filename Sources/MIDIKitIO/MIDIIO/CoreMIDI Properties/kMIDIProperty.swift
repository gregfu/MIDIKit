//
//  kMIDIProperty.swift
//  MIDIKit
//
//  Created by Steffan Andrews on 2021-02-27.
//

import Foundation

// MARK: - kMIDIProperty

extension MIDIIO {
	
	internal enum kMIDIProperty: CaseIterable, Hashable {
		
		// MARK: Identification
		case name
		case model
		case manufacturer
		case uniqueID
		case deviceID
		
		// MARK: Capabilities
		case supportsMMC
		case supportsGeneralMIDI
		case supportsShowControl
		
		// MARK: Configuration
		case nameConfigurationDictionary
		case maxSysExSpeed
		case driverDeviceEditorApp
		
		// MARK: Presentation
		case propertyImage
		case displayName
		
		// MARK: Audio
		case panDisruptsStereo
		
		// MARK: Protocols
		case protocolID
		
		// MARK: Timing
		case transmitsMTC
		case receivesMTC
		case transmitsClock
		case receivesClock
		case advanceScheduleTimeMuSec
		
		// MARK: Roles
		case isMixer
		case isSampler
		case isEffectUnit
		case isDrumMachine
		
		// MARK: Status
		case isOffline
		case isPrivate
		
		// MARK: Drivers
		case driverOwner
		case driverVersion
		
		// MARK: Connections
		case canRoute
		case isBroadcast
		case connectionUniqueID
		case isEmbeddedEntity
		case singleRealtimeEntity
		
		// MARK: Channels
		case receiveChannels
		case transmitChannels
		case maxReceiveChannels
		case maxTransmitChannels
		
		// MARK: Banks
		case receivesBankSelectLSB
		case receivesBankSelectMSB
		case transmitsBankSelectLSB
		case transmitsBankSelectMSB
		
		// MARK: Notes
		case receivesNotes
		case transmitsNotes
		
		// MARK: Program Changes
		case receivesProgramChanges
		case transmitsProgramChanges
		
	}
	
}

extension MIDIIO.kMIDIProperty {
	
	internal var relevantObjects: Set<MIDIIO.ObjectType> {
		
		switch self {
		
		// MARK: Identification
		case .name: return [.device, .entity, .endpoint]
		case .model: return [.device, .endpoint]
		case .manufacturer: return [.device, .endpoint]
		case .uniqueID: return [.device, .entity, .endpoint]
		case .deviceID: return [.device, .entity]
			
		// MARK: Capabilities
		case .supportsMMC: return [.device, .entity]
		case .supportsGeneralMIDI: return [.device, .entity]
		case .supportsShowControl: return [.device]
			
		// MARK: Configuration
		case .nameConfigurationDictionary: return [.device]
		case .maxSysExSpeed: return [.device] // + .entity? .endpoint?
		case .driverDeviceEditorApp: return [.device]
			
		// MARK: Presentation
		case .propertyImage: return [.device]
		case .displayName: return [.device, .entity, .endpoint]
			
		// MARK: Audio
		case .panDisruptsStereo: return [.device, .entity]
			
		// MARK: Protocols
		case .protocolID: return [.endpoint]
			
		// MARK: Timing
		case .transmitsMTC: return [.device, .entity]
		case .receivesMTC: return [.device, .entity]
		case .transmitsClock: return [.device, .entity]
		case .receivesClock: return [.device, .entity]
		case .advanceScheduleTimeMuSec: return [.device, .entity] // + .endpoint?
			
		// MARK: Roles
		case .isMixer: return [.device, .entity]
		case .isSampler: return [.device, .entity]
		case .isEffectUnit: return [.device, .entity]
		case .isDrumMachine: return [.device, .entity]
			
		// MARK: Status
		case .isOffline: return [.device, .entity, .endpoint]
		case .isPrivate: return [.endpoint]
			
		// MARK: Drivers
		case .driverOwner: return [.device, .entity, .endpoint]
		case .driverVersion: return [.device, .entity, .endpoint]
			
		// MARK: Connections
		case .canRoute: return [.device, .entity]
		case .isBroadcast: return [.endpoint]
		case .connectionUniqueID: return [.endpoint] // ?
		case .isEmbeddedEntity: return [.entity, .endpoint]
		case .singleRealtimeEntity: return [.device, .endpoint] // ?
			
		// MARK: Channels
		case .receiveChannels: return [.device, .entity, .endpoint] // ?
		case .transmitChannels: return [.device, .entity, .endpoint] // ?
		case .maxReceiveChannels: return [.device]
		case .maxTransmitChannels: return [.device]
			
		// MARK: Banks
		case .receivesBankSelectLSB: return [.device, .entity]
		case .receivesBankSelectMSB: return [.device, .entity]
		case .transmitsBankSelectLSB: return [.device, .entity]
		case .transmitsBankSelectMSB: return [.device, .entity]
			
		// MARK: Notes
		case .receivesNotes: return [.device, .entity]
		case .transmitsNotes: return [.device, .entity]
			
		// MARK: Program Changes
		case .receivesProgramChanges: return [.device, .entity]
		case .transmitsProgramChanges: return [.device, .entity]
			
		}
		
	}
	
}

extension MIDIIO.ObjectType {
	
	internal var relevantProperties: [MIDIIO.kMIDIProperty] {
		
		MIDIIO.kMIDIProperty.allCases
			.filter {
				$0.relevantObjects.contains(self)
			}
		
	}
	
}
