//
//  EmailHelper.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 4/8/24.
//

import Foundation
import UIKit
import StringExtensions

public class EmailHelper {
    public static func sendEmail(to: String?, cc: String?, bcc: String?, subject: String?, body: String?) {
        var emailQueryString: String {
            var firstParameter = ""
            var rtnVal: String
            if to.isNotNilOrEmpty {
                firstParameter = "to"
            } else if cc.isNotNilOrEmpty {
                firstParameter = "cc"
            } else if bcc.isNotNilOrEmpty {
                firstParameter = "bcc"
            } else if subject.isNotNilOrEmpty {
                firstParameter = "subject"
            } else if body.isNotNilOrEmpty {
                firstParameter = "body"
            }

            rtnVal = "\(firstParameter == "to" && to.isNotNilOrEmpty ? "?to=\(to.displayOptionalText)" : "")"
            rtnVal = rtnVal + "\(firstParameter == "cc" && cc.isNotNilOrEmpty ? "?cc=\(cc.displayOptionalText)" : cc.isNotNilOrEmpty ? "&cc=\(cc.displayOptionalText)" : "")"
            rtnVal = rtnVal + "\(firstParameter == "bcc" && bcc.isNotNilOrEmpty ? "?bcc=\(bcc.displayOptionalText)" : bcc.isNotNilOrEmpty ? "&bcc=\(bcc.displayOptionalText)" : "")"
            rtnVal = rtnVal + "\(firstParameter == "subject" && subject.isNotNilOrEmpty ? "?subject=\(subject.displayOptionalText)" : subject.isNotNilOrEmpty ? "&subject=\(subject.displayOptionalText)" : "")"
            rtnVal = rtnVal + "\(firstParameter == "body" && body.isNotNilOrEmpty ? "?body=\(body.displayOptionalText)" : body.isNotNilOrEmpty ? "&body=\(body.displayOptionalText)" : "")"
            return rtnVal
        }

        let mailtoString = "mailto:\(emailQueryString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl, options: [:])
        }

    }
}
