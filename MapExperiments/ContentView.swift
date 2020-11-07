//
//  ContentView.swift
//  MapExperiments
//
//  Created by Neil Marcellini on 11/6/20.
//

import SwiftUI
import MapKit
import CoreGPX

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.81062103807926177978515625, longitude: -122.45675641112029552459716796875), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    
    init() {
        let coordinates = getCoordinates()
        let track_line = MKPolyline(coordinates: coordinates, count: coordinates.count)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.8119495697319507598876953125, longitude: -122.45539963245391845703125)
        annotation.title = "A Place"
        MKMapView.appearance().addAnnotation(annotation)
        MKMapView.appearance().addOverlay(track_line)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: nil)
    }
    
}

func getCoordinates()->[CLLocationCoordinate2D] {
    var coordinates = [CLLocationCoordinate2D()]
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
