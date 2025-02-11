//
//  MailComposeView.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 7/24/23.
//

import Foundation
import MessageUI
import SwiftUI

public struct MailComposeViewController: UIViewControllerRepresentable {
    var toRecipients: [String]
    var bccRecipients: [String]
    var mailBody: String

    var didFinish: () -> Void

    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(toRecipients)
        mail.setBccRecipients(bccRecipients)
        mail.setMessageBody(mailBody, isHTML: true)

        return mail
    }

    final public class Coordinator: NSObject, @preconcurrency MFMailComposeViewControllerDelegate {
        var parent: MailComposeViewController

        init(_ mailController: MailComposeViewController) {
            parent = mailController
        }

        @MainActor public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }

    public func updateUIViewController(_: MFMailComposeViewController, context _: UIViewControllerRepresentableContext<MailComposeViewController>) {}
}
