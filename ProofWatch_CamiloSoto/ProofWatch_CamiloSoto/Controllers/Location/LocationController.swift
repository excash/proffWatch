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
    var stateRoute: StateRoute?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = LocationPresenter(view: self, interactor: LocationInteractor())
        self.stateRoute = StateRoute.start
    }

    
    // View
    func showActualPosition(location: CLLocationCoordinate2D) {
        removeAnnotations()
        updatePosition(location: location)
    }
    
    func showAllRoute() {
        self.stateRoute = StateRoute.start
    }
    
    private func updatePosition(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
       
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Mi posición"
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
        
        presenter?.startRoute(state: stateRoute!)
        
        switch stateRoute! {
            
        case StateRoute.start:
            self.stateRoute = StateRoute.pause
            btnStart.setTitle("Pausar Recorrido", for: .normal)
            btnStart.setTitleColor(UIColor.red, for: .normal)
            break
            
        case StateRoute.pause:
            self.stateRoute = StateRoute.restart
            btnStart.setTitle("Reanudar Recorrido", for: .normal)
            btnStart.setTitleColor(UIColor.blue, for: .normal)
            break
            
        case StateRoute.restart:
            self.stateRoute = StateRoute.pause
            btnStart.setTitle("Pausar Recorrido", for: .normal)
            btnStart.setTitleColor(UIColor.red, for: .normal)
            break
            
        default:
            self.stateRoute = StateRoute.start
            break
        }
    }
    
}

