import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var placeViewModel: PlaceViewModel
    
    var city: City {
        placeViewModel.selectedCity
    }
    
    var places: [PlaceModel] {
        placeViewModel.places.filter { $0.city == city }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
        // Add annotations for places in the selected city
        let annotations = places.map { place -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
            return annotation
        }
        
        uiView.addAnnotations(annotations)
        updateRegion(for: city, mapView: uiView)
    }
    
    private func updateRegion(for city: City, mapView: MKMapView) {
        let centerCoordinate: CLLocationCoordinate2D
        switch city {
        case .riyadh:
            centerCoordinate = CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753)
        case .jeddah:
            centerCoordinate = CLLocationCoordinate2D(latitude: 21.4858, longitude: 39.1925)
        }
        
        
        let region = MKCoordinateRegion(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "PlaceAnnotation"
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                
                
                if let place = parent.getPlace(for: annotation),
                   let placeType = place.type {
                    annotationView.image = UIImage(named: placeType.imageName)
                    
                    // Set the image size to be smaller
                    annotationView.frame.size = CGSize(width: 30, height: 30)
                } else {
                    annotationView.image = UIImage(named: "default_icon")
                    annotationView.frame.size = CGSize(width: 30, height: 30) // Default size
                }
                
                return annotationView
            }
        }
    }
    
    
    private func getPlace(for annotation: MKAnnotation) -> PlaceModel? {
        return places.first { $0.name == annotation.title }
    }
}
