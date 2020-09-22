//
//  RouteController.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import UIKit
import MapKit

class RouteController: UIViewController, RouteContractView, MKMapViewDelegate {

    @IBOutlet weak var textDistance: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    
    var presenter: RouteContractPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        
        presenter = RoutePresenter(view: self, interactor: RouteInteractor())
    }
    
    //View
    func showDistance(distance: String) {
        self.textDistance.text = "Distancia recorrida: \(distance)"
    }
    
    // Visualización de la ruta
    func showRoute(locations: [CLLocationCoordinate2D]) {
        guard !locations.isEmpty else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locations[0], span: span)
        map.setRegion(region, animated: true)
        
        createRoute(locations: locations)
    }
    
    //Dibujar la ruta realizada
    private func createRoute(locations: [CLLocationCoordinate2D]){
        // crear una Polyline
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        
        // Dibujar en el mapa
        map.addOverlay(polyline)
        
        // Añadir anotacion Inicial y Final
        let annotationInit = MKPointAnnotation()
        let annotationEnd = MKPointAnnotation()
        annotationInit.coordinate = locations.first!
        annotationInit.title = "Inicio"
        
        annotationEnd.coordinate = locations.last!
        annotationEnd.title = "Final"
        
        map.addAnnotation(annotationInit)
        map.addAnnotation(annotationEnd)
    }
    
    // Deklegate para las propiedades de la Polyline
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKPolyline.self){
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.fillColor = UIColor.blue
            polylineRenderer.strokeColor = UIColor.blue.withAlphaComponent(0.9)
            polylineRenderer.lineWidth = 2
            return polylineRenderer
            
        }
        
        return MKOverlayRenderer(overlay: overlay)
        
    }
    
    //Accion para el boton atras
    @IBAction func back(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
