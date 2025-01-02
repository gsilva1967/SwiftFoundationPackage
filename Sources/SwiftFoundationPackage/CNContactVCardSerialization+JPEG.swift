//
//  CNContactVCardSerialization+JPEG.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 2/14/24.
//

import Contacts
import Foundation

public extension CNContactVCardSerialization {
     class func vcardDataAppendingPhoto(vcard: Data, photoAsBase64String photo: String) -> Data? {
        let vcardAsString = String(data: vcard, encoding: .utf8)
        let vcardPhoto = "PHOTO;TYPE=JPEG;ENCODING=BASE64:".appending(photo)
        let vcardPhotoThenEnd = vcardPhoto.appending("\nEND:VCARD")
        if let vcardPhotoAppended = vcardAsString?.replacingOccurrences(of: "END:VCARD", with: vcardPhotoThenEnd) {
            return vcardPhotoAppended.data(using: .utf8)
        }
        return nil
    }

     class func data(jpegPhotoContacts: [CNContact]) throws -> Data {
        var overallData = Data()
        for contact in jpegPhotoContacts {
            let data = try CNContactVCardSerialization.data(with: [contact])
            if contact.imageDataAvailable {
                if let base64imageString = contact.imageData?.base64EncodedString(),
                   let updatedData = vcardDataAppendingPhoto(vcard: data, photoAsBase64String: base64imageString)
                {
                    overallData.append(updatedData)
                }
            } else {
                overallData.append(data)
            }
        }
        return overallData
    }
}
