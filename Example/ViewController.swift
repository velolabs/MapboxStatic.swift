import UIKit
import CoreLocation
import MapboxStatic

class ViewController: UIViewController {
    // You can also specify the access token with the `MGLMapboxAccessToken` key in Info.plist.
    let accessToken = "pk.eyJ1IjoianVzdGluIiwiYSI6IlpDbUJLSUEifQ.4mG8vhelFMju6HpIY-Hi5A"
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: view.bounds)
        imageView.backgroundColor = .black
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let camera = SnapshotCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: 45, longitude: -122), zoomLevel: 6)
        let options = SnapshotOptions(
            styleURL: URL(string: "mapbox://styles/mapbox/streets-v9")!,
            camera: camera,
            size: imageView.bounds.size)
        _ = Snapshot(options: options, accessToken: accessToken).image { [weak self] (image, error) in
            if let error = error {
                print(error)
                return
            }
            
            self?.imageView.image = image
        }
    }
}
