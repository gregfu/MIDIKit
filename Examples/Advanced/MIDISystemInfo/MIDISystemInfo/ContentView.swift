//
//  ContentView.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import MIDIKit
import OTCore

struct ContentView: View {
    // if you declare a view that creates its own @ObservedObject instance, that instance is replaced every time SwiftUI decides that it needs to discard and redraw that view.
    // it should instead be used to retain a weak reference from the view's initializer, with the original instance of the object stored in a parent scope as either a var or @StateObject but not an @ObservedObject
    
    @ObservedObject var midiManager: MIDIManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device Tree")) {
                    let items: [AnyMIDIIOObject] = midiManager.devices.devices
                        .sortedByName()
                        .flatMap {
                            [$0.asAnyMIDIIOObject()]
                                + $0.entities
                                .flatMap {
                                    [$0.asAnyMIDIIOObject()]
                                        + $0.inputs.asAnyMIDIIOObjects()
                                        + $0.outputs.asAnyMIDIIOObjects()
                                }
                        }
    
                    ForEach(items) { item in
                        let detailsView = DetailsView(object: item.asAnyMIDIIOObject())
    
                        NavigationLink(destination: detailsView) {
                            switch item.objectType {
                            case .device:
                                // SwiftUI doesn't allow 'break' in a switch case
                                // so just put a 0x0 pixel spacer here
                                Spacer().frame(width: 0, height: 0, alignment: .center)
    
                            case .entity:
                                Spacer()
                                    .frame(width: 24, height: 18, alignment: .center)
    
                            case .inputEndpoint, .outputEndpoint:
                                Spacer()
                                    .frame(width: 48, height: 18, alignment: .center)
                            }
    
                            Group {
                                if let nsImg = item.getImageAsNSImage() {
                                    Image(nsImage: nsImg)
                                        .resizable()
                                } else {
                                    Text("🎹")
                                }
                            }
                            .frame(width: 18, height: 18, alignment: .center)
    
                            Text("\(item.name)")
                            if item.objectType == .inputEndpoint {
                                Text("(In)")
                            } else if item.objectType == .outputEndpoint {
                                Text("(Out)")
                            }
                        }
                    }
                }
    
                Section(header: Text("Other Inputs")) {
                    // filter out endpoints that have an entity because
                    // they are already being displayed in the Devices tree
                    let items = midiManager.endpoints.inputs.sortedByName()
                        .filter { $0.getEntity() == nil }
    
                    ForEach(items) { item in
                        let detailsView = DetailsView(object: item.asAnyMIDIIOObject())
    
                        NavigationLink(destination: detailsView) {
                            Group {
                                if let nsImg = item.getImageAsNSImage() {
                                    Image(nsImage: nsImg)
                                        .resizable()
                                } else {
                                    Text("🎵")
                                }
                            }
                            .frame(width: 18, height: 18, alignment: .center)
    
                            Text("\(item.name)")
                        }
                    }
                }
    
                Section(header: Text("Other Outputs")) {
                    // filter out endpoints that have an entity because
                    // they are already being displayed in the Devices tree
                    let items = midiManager.endpoints.outputs.sortedByName()
                        .filter { $0.getEntity() == nil }
    
                    ForEach(items) { item in
                        let detailsView = DetailsView(object: item.asAnyMIDIIOObject())
    
                        NavigationLink(destination: detailsView) {
                            Group {
                                if let nsImg = item.getImageAsNSImage() {
                                    Image(nsImage: nsImg)
                                        .resizable()
                                } else {
                                    Text("🎵")
                                }
                            }
                            .frame(width: 18, height: 18, alignment: .center)
    
                            Text("\(item.name)")
                        }
                    }
                }
            }
            .frame(width: 300)
    
            EmptyDetailsView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentViewCatalina_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(midiManager: .init(clientName: "Preview", model: "", manufacturer: ""))
    }
}
