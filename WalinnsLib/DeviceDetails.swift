//
//  DeviceDetails.swift
//  Pods
//
//  Created by WALINNS INNOVATION on 11/11/17.
//
//

import Foundation
import UIKit
import CoreTelephony
import CoreLocation


class DeviceData {
    static let sharedInstance = DeviceData()
    public var connectivty : String = ""
    var locationManager: CLLocationManager!
    
    func os_name() -> String {
       return "ios"
    }
    
    func os_version() -> String {
        
        return UIDevice.current.systemVersion
    }
    
    func app_version() -> String {
        
        return getVersion()
    }
    func getVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "no version info"
        }
        return version
    }
   func carrierName() -> String {
       // let networkInfoo = CTTelephonyNetworkInfo()
      //  let carrier = networkInfoo.subscriberCellularProvider
       // let carrierval  = carrier?.carrierName
        let carrierval = "No sim"
        return carrierval
    }
    
    func Connectivy_gen() -> String {
        let networkInfoo = CTTelephonyNetworkInfo()
        if(networkInfoo != nil){
            if(networkInfoo.currentRadioAccessTechnology != nil){
            let networkString = networkInfoo.currentRadioAccessTechnology!
            
            switch (networkString){
            case "CTRadioAccessTechnologyCDMA1x":
                print("2g")
                connectivty="2g"
            case  "CTRadioAccessTechnologyEdge" :
                print("2g")
                connectivty="2g"
                
            case "CTRadioAccessTechnologyGPRS":
                print("2g")
                connectivty="2g"
            case "CTRadioAccessTechnologyeHRPD":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyHSDPA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyHSUPA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyLTE":
                print("4g")
                connectivty="4g"
            case "CTRadioAccessTechnologyCDMAEVDORev0":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyCDMAEVDORevA":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyCDMAEVDORevB":
                print("3g")
                connectivty="3g"
            case "CTRadioAccessTechnologyWCDMA":
                print("3g")
                connectivty="3g"
            default:
                print("2g")
                connectivty="2g"
            }
            
                        }else{
                 return "2g"
            }
            return connectivty


        }else{
            return "2g"
        }
           
    }
    
    func screenHeight() -> String {
        return String(describing: UIScreen.main.nativeBounds.height)
     }
    
    func screenWidth( ) -> String {
        return String(describing: UIScreen.main.nativeBounds.width)
    }
    
    func screendpi() -> String {
        let ppi = UIScreen.main.bounds       // #> 326]
        return String(describing: ppi)
    }
    
    func age() -> String {
        return "min 21"
    }
    
    func language( ) -> String {
        let pre = Locale.preferredLanguages[0]
        
        return String(pre)

    }
    
    func location( ) -> String {
        let countryCode = NSLocale.current.regionCode
        print("Country code" , countryCode)

        return countryCode!
        
    }
    
  
    
    func email() -> String {
        return "example@gmail.com"
    }

    func device_model() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let size = MemoryLayout<CChar>.size
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: size) {
                String(cString: UnsafePointer<CChar>($0))
            }
        }
        if let model = String(validatingUTF8: modelCode) {
            
            return String(model)
        }else{
            return "no model"
        }

    }
    
    
}
