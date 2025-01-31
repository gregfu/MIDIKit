//
//  MTCGenContentView.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Combine
import SwiftUI
import MIDIKitIO
import MIDIKitSync
import TimecodeKit
import OTCore
import SwiftRadix

struct MTCGenContentView: View {
    weak var midiManager: MIDIManager?
    
    init(midiManager: MIDIManager?) {
        // normally in SwiftUI we would pass midiManager in as an EnvironmentObject
        // but that only works on macOS 11.0+ and for sake of backwards compatibility
        // we will do it old-school weak delegate storage pattern
        self.midiManager = midiManager
    }
    
    // MARK: - MIDI state
    
    @State var mtcGen: MTCGenerator = .init()
    
    @State var localFrameRate: Timecode.FrameRate = ._24
    
    @State var locateBehavior: MTCEncoder.FullFrameBehavior = .ifDifferent
    
    // MARK: - UI state
    
    @State var mtcGenState = false
    
    @State var generatorTC: Timecode = .init(at: ._24)
    
    // MARK: - Internal State
    
    @State private var lastSeconds = 0
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(generatorTC.stringValue)
                .font(.system(size: 48, weight: .regular, design: .monospaced))
                .frame(maxWidth: .infinity)
            
            Spacer()
                .frame(height: 15)
            
            VStack {
                Button(
                    "Locate to "
                        + TCC(h: 1, m: 00, s: 00, f: 00, sf: 00)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames,
                            format: [.showSubFrames]
                        )
                        .stringValue
                ) {
                    locate(to: TCC(h: 1, m: 00, s: 00, f: 00, sf: 00))
                }
                .disabled(mtcGenState)
                
                Button("Start at Current Timecode") {
                    mtcGenState = true
                    if mtcGen.localFrameRate != localFrameRate {
                        // update generator frame rate by triggering a locate
                        locate()
                    }
                    logger.debug("Starting at \(generatorTC.stringValue)")
                    mtcGen.start(now: generatorTC)
                }
                .disabled(mtcGenState)
                
                Button(
                    "Start at "
                        + TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames,
                            format: [.showSubFrames]
                        )
                        .stringValue
                        + " (as Timecode)"
                ) {
                    mtcGenState = true
                    if mtcGen.localFrameRate != localFrameRate {
                        // update generator frame rate by triggering a locate
                        locate()
                    }
                    
                    let startTC = TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames
                        )
                    
                    mtcGen.start(now: startTC)
                }
                .disabled(mtcGenState)
                
                Button(
                    "Start at "
                        + TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames,
                            format: [.showSubFrames]
                        )
                        .stringValue
                        + " (as Timecode Components)"
                ) {
                    mtcGenState = true
                    if mtcGen.localFrameRate != localFrameRate {
                        // update generator frame rate by triggering a locate
                        locate()
                    }
                    
                    let startTC = TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames
                        )
                    
                    mtcGen.start(
                        now: startTC.components,
                        frameRate: startTC.frameRate,
                        base: startTC.subFramesBase
                    )
                }
                .disabled(mtcGenState)
                
                Button(
                    "Start at "
                        + TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames,
                            format: [.showSubFrames]
                        )
                        .stringValue
                        + " (as TimeInterval)"
                ) {
                    mtcGenState = true
                    if mtcGen.localFrameRate != localFrameRate {
                        // update generator frame rate by triggering a locate
                        locate()
                    }
                    
                    let startRealTimeSeconds = TCC(h: 1, m: 00, s: 00, f: 00, sf: 35)
                        .toTimecode(
                            rawValuesAt: localFrameRate,
                            base: ._100SubFrames
                        )
                        .realTimeValue
                    
                    mtcGen.start(
                        now: startRealTimeSeconds,
                        frameRate: localFrameRate
                    )
                }
                .disabled(mtcGenState)
                
                Button("Stop") {
                    mtcGenState = false
                    mtcGen.stop()
                }
                .disabled(!mtcGenState)
            }
            
            Spacer()
                .frame(height: 15)
            
            Picker("Local Frame Rate", selection: $localFrameRate) {
                ForEach(Timecode.FrameRate.allCases) { fRate in
                    Text(fRate.stringValue)
                        .tag(fRate)
                }
            }
            .frame(width: 250)
            .disabled(mtcGenState)
            .onHover { _ in
                guard !mtcGenState else { return }
                
                // this is a stupid SwiftUI workaround, but it works fine for our purposes
                if mtcGen.localFrameRate != localFrameRate {
                    locate()
                }
            }
            
            Text("will be transmit as \(localFrameRate.mtcFrameRate.stringValue)")
            
            Spacer()
                .frame(height: 15)
            
            Picker("Locate Behavior", selection: $locateBehavior) {
                ForEach(
                    MTCEncoder.FullFrameBehavior.allCases,
                    id: \.self
                ) { locateBehaviorType in
                    Text(locateBehaviorType.nameForUI)
                        .tag(locateBehaviorType)
                }
            }
            .frame(width: 250)
            .disabled(mtcGenState)
            .onHover { _ in
                guard !mtcGenState else { return }
                
                // this is a stupid SwiftUI workaround, but it works fine for our purposes
                if mtcGen.locateBehavior != locateBehavior {
                    mtcGen.locateBehavior = locateBehavior
                }
            }
        }
        .frame(
            minWidth: 400,
            maxWidth: .infinity,
            minHeight: 300,
            maxHeight: .infinity,
            alignment: .center
        )
        .onAppear {
            // create MTC generator MIDI endpoint
            do {
                let udKey = "\(kMIDISources.MTCGen.tag) - Unique ID"
                
                try midiManager?.addOutput(
                    name: kMIDISources.MTCGen.name,
                    tag: kMIDISources.MTCGen.tag,
                    uniqueID: .userDefaultsManaged(key: udKey)
                )
            } catch {
                logger.error(error)
            }
            
            // set up new MTC receiver and configure it
            mtcGen = MTCGenerator(
                name: "main",
                midiOutHandler: { midiEvents in
                    try? midiManager?
                        .managedOutputs[kMIDISources.MTCGen.tag]?
                        .send(events: midiEvents)
                    
                    // NOTE: normally you should not run any UI updates from this handler; this is only being done here for sake of demonstration purposes
                    
                    DispatchQueue.main.async {
                        let tc = mtcGen.timecode
                        generatorTC = tc
                        
                        if tc.seconds != lastSeconds {
                            if mtcGenState { playClickA() }
                            lastSeconds = tc.seconds
                        }
                    }
                }
            )
            
            mtcGen.locateBehavior = locateBehavior
            
            locate()
        }
    }
    
    /// Locate to a timecode, or 00:00:00:00 by default.
    func locate(
        to components: Timecode.Components = TCC(h: 00, m: 00, s: 00, f: 00)
    ) {
        let tc = components.toTimecode(rawValuesAt: localFrameRate)
        generatorTC = tc
        mtcGen.locate(to: tc)
    }
}

struct mtcGenContentView_Previews: PreviewProvider {
    static var previews: some View {
        MTCGenContentView(midiManager: nil)
    }
}
