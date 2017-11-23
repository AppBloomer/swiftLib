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
import Contacts
import CloudKit

class DeviceData {
    public var connectivty : String = ""
    
    
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
      let telephonyInfo = CTTelephonyNetworkInfo()
       let carrier = telephonyInfo.subscriberCellularProvider?.carrierName
        print("Carrierr name: " , carrier)
        if(carrier != nil){
            return carrier!
        }
        return "No sim"
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
        return "1250"
    }
    
    func age() -> String {
        return "min 21"
    }
    
    func language( ) -> String {
        let pre = Locale.preferredLanguages[0]
        
        return String(pre)

    }
    
    func location( ) -> String {
        
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print("get country code :",countryCode)
             return countryCode
        }else{
             print("get country code else:","")
             return "IN"
        }
        
        
    }
    
    func email() -> String {
       //  iCloudUserIDAsync { (recordID: CKRecordID?, error: NSError?) in
//if let userID = recordID?.recordName {
       // print("received iCloudID \(userID)")
        //    print("Fetched iCloudID was nil")
         //  }
        //}
        return getEmail()
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
            print("Phone model : " , model)
            return String(model)
        }else{
            print("Phone model else : " , "unknown")
            return "no model"
        }

    }
    
    func getEmail() -> String {
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])) {
                (contact, cursor) -> Void in
                if (!contact.emailAddresses.isEmpty){
                    //Add to your array
                    print("Contact Details : " , contact.emailAddresses)
                }
            }
        }
        catch{
            print("Handle the error please")
        }
        return "email"
    }
    func iCloudUserIDAsync(complete: @escaping (_ instance: CKRecordID?, _ error: NSError?) -> ()) {
        
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in
            CKContainer.default().fetchUserRecordID { (record, error) in
                CKContainer.default().discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in
                    print(userID?.hasiCloudAccount)
                    print(userID?.lookupInfo?.phoneNumber)
                    print(userID?.lookupInfo?.emailAddress)
                    print((userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!)
                })
            }
        }
    }
    
}
