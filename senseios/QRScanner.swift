import UIKit
import AVFoundation
import Firebase

class QRScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
   
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    let employeeobject = employeemodel()
    var listemployee:[employeemodel]? = []
     let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       square.layer.borderColor = UIColor.red.cgColor
        square.layer.borderWidth = 2
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video){
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
        }
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: square)
        
        session.startRunning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    
                    let dataqr : [String] = object.stringValue!.components(separatedBy: ",")
                      self.session.stopRunning()
                    if(dataqr.count == 3){
                    employeeobject.activity = dataqr[1]
                    employeeobject.activityremark = dataqr[2]
                   fetchsummary(query: dataqr[0])
                    }
                    else{
                        
                        self.showToast(message: "Ops Not Found")
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchsummary(query:String){
        
        let parameters = ["query" : query  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/employeelist.php")!
        
        var items = [URLQueryItem]()
        
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlrequest = URLRequest(url: urlComp.url!)
        urlrequest.httpMethod = "GET"
        
        
        //execute the request
        
        let task = URLSession.shared.dataTask(with: urlrequest){(data,response,error)  in
            
            if let data = data {
                
           
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    if  let summaryfromjson  = json["employeelist"] as? [[String:AnyObject]]{
                        
                        for summaryfromjson in summaryfromjson {
                      
                            if let employeename = summaryfromjson["employeename"] as? String,
                                let email = summaryfromjson["email"] as? String, let staffid = summaryfromjson["staffid"], let division = summaryfromjson["division"], let uid = summaryfromjson["uid"], let regid = summaryfromjson["regid"]{
                                
                                
                                
                                self.employeeobject.name = employeename
                                self.employeeobject.division = division as? String
                                self.employeeobject.staffid = staffid as? String
                                self.employeeobject.uid = uid as? String
                                self.employeeobject.email = email
                                self.employeeobject.regid = regid as? String
                                
                                self.listemployee?.append(self.employeeobject)
                                
                            }
                          
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        
                        if((self.listemployee?.count)! > 0){
                        
                        if(Auth.auth().currentUser?.email == self.employeeobject.email){
                            
                            self.showToast(message: "You cannot rate yourself")
                            
                        }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectsmiley") as! selectsmiley
                        
                        
                        initialViewController2.employeeinfo = self.employeeobject
                        
                        self.navigationController?.pushViewController(initialViewController2, animated: true)
                        }
                    }
                        else{
                            
                            self.showToast(message: "Ops Not Found")
                        }
                  }
                    
                }
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    self.showToast(message: error.localizedDescription)
                }
                
            }
                
                
            else if let error = error {
                print(error.localizedDescription)
                self.showToast(message: error.localizedDescription)
            }
            
            
        }
        
        task.resume()
        
    }
}
