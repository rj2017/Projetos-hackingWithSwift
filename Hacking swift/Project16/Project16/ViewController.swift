//
//  ViewController.swift
//  Project16
//
//  Created by Raphael de Jesus on 14/02/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home of the 2012 summer olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light")
        let rome = Capital(title: "Roma", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "has a whole country inside it.")
        let washington = Capital(title: "Whashington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openMapTypeOption))
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func openMapTypeOption() {
        let ac = UIAlertController(title: "Map Type options", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .satellite)
        })
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .hybrid)
        })
        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .hybridFlyover)
        })
        ac.addAction(UIAlertAction(title: "MutedStandard", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .mutedStandard)
        })
        ac.addAction(UIAlertAction(title: "SatelliteFlyover", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .satelliteFlyover)
        })
        ac.addAction(UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.changeMapType(mapType: .standard)
        })
        present(ac,animated: true)
    }
    
    private func changeMapType(mapType: MKMapType) {
        mapView.mapType = mapType
        mapView.reloadInputViews()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let vc = WikiViewController()
        vc.country = placeName ?? ""
        navigationController?.pushViewController(vc, animated: true)
//        let placeName = capital.title
//        let placeInfo = capital.info
//        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .default))
//        present(ac, animated: true)
    }


}

