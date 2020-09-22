//
//  ViewController.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import UIKit
import MapKit

class LocationController: UIViewController, LocationContractView {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btnStart: UIButton!
    
    var presenter: LocationContractPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = LocationPresenter(view: self, interactor: LocationInteractor())

    }

    
    // View
    func showActualPosition(location: CLLocationCoordinate2D) {
        removeAnnotations()
        updatePosition(location: location)
    }
    
    private func updatePosition(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
       
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Mi posición"
        annotation.subtitle = "Actual"
        map.addAnnotation(annotation)
    }
    
    private func removeAnnotations(){
        let annotations = map.annotations
        guard annotations.count > 0 else { return }
        for annotation in annotations {
          map.removeAnnotation(annotation)
        }
    }

    @IBAction func start(_ sender: UIButton) {
        presenter?.startRoute()
    }
    
}

