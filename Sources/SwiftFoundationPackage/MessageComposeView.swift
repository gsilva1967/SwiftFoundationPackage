//
//  MessageComposeView.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 7/19/23.
//

// MessageComposeView.swift

import MessageUI
import SwiftUI

public struct MessageComposeView: UIViewControllerRepresentable {
    public typealias Completion = (_ messageSent: Bool) -> Void

    static var canSendText: Bool { MFMessageComposeViewController.canSendText() }

    let recipients: [String]?
    let body: String?
    let fileAttachments: [URL]?
    let imageAttachments: [UIImage]?
    let completion: Completion?

    public func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            let errorView = MessagesUnavailableView()
            return UIHostingController(rootView: errorView)
        }

        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body

        if fileAttachments != nil && fileAttachments!.count > 0 {
            for url in fileAttachments! {
//                var x = controller.addAttachmentURL(att. , withAlternateFilename: att.lastPathComponent)
                do {
                    let accessing = url.startAccessingSecurityScopedResource()
                    defer {
                        if accessing {
                            url.stopAccessingSecurityScopedResource()
                        }
                    }

                    let fileData: Data = try Data(contentsOf: url)
                    controller.addAttachmentData(fileData as Data, typeIdentifier: "image/pdf", filename: url.lastPathComponent)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        if imageAttachments != nil && imageAttachments!.count > 0 {
            for att in imageAttachments! {
                let imageData: NSData = (att.jpegData(compressionQuality: 0.5) as? NSData)!
                controller.addAttachmentData(imageData as Data, typeIdentifier: "image/jpeg", filename: "image.jpg")
            }
        }

        return controller
    }

    public func read(from url: URL) -> Result<String, Error> {
        let accessing = url.startAccessingSecurityScopedResource()
        defer {
            if accessing {
                url.stopAccessingSecurityScopedResource()
            }
        }

        return Result { try String(contentsOf: url) }
    }

    public func updateUIViewController(_: UIViewController, context _: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    public class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        public let completion: Completion?

        public init(completion: Completion?) {
            self.completion = completion
        }

        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
}

public struct MessagesUnavailableView: View {
    public var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 64))
                .foregroundColor(.red)
            Text("Messages is unavailable")
                .font(.system(size: 24))
        }
    }
}
