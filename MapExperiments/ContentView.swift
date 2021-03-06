//
//  ContentView.swift
//  MapExperiments
//
//  Created by Neil Marcellini on 11/6/20.
//

import SwiftUI
import MapKit
import CoreGPX


class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MKMapView

    init(_ parent: MKMapView) {
        self.parent = parent
    }
}

struct ContentView: View {
    @State var route: MKPolyline?
    
    var body: some View {
        MapView(route: $route).onAppear() {
            addTrack()
        }
    }
    
}

private extension ContentView {
    func addTrack() {
        var coordinates = getCoordinates()
        let track_line = MKPolyline(coordinates: &coordinates, count: coordinates.count)
       route = track_line
    }
}


func getCoordinates()->[CLLocationCoordinate2D] {
    var coordinates = Array<CLLocationCoordinate2D>()
    guard let fileURL = Bundle.main.url(forResource: "Crissy-8-13", withExtension: "gpx") else { return coordinates}
    guard let gpx = GPXParser(withURL: fileURL)?.parsedData() else { return coordinates }
    for track in gpx.tracks {
        for seg in track.tracksegments {
            for trackpoint in seg.trackpoints {
                let lat = trackpoint.latitude
                let lng = trackpoint.longitude
                if lat != nil && lng != nil {
                    coordinates.append(CLLocationCoordinate2D(latitude: lat!, longitude: lng!))
                }
            }
        }
    }
    return coordinates
}



    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
