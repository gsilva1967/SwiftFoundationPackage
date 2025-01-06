//
//  ToastView.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 7/5/24.
//

import SwiftUI

public enum ToastType {
    case Success
    case Warning
    case Failure
    case Offline
}

public struct ToastView: View {
    public var toastType: ToastType = .Success
    public var isShortSuccess: Bool = true
    @State var title = ""
    public var details: String = "your message"
    public var technicalDetails = ""

    @State var animateCircle = false
    @State var icon: Image = .init(systemName: "checkmark.circle.fill")
    @State var gridentColor: Color = .green
    @State var circleAColor: Color = .green
    @State var corner: CGFloat = 30
    @State var showTechnicalDetails: Bool = false

    public init(toastType: ToastType, isShortSuccess: Bool, title: String = "", details: String, technicalDetails: String = "", animateCircle: Bool = false, icon: Image, gridentColor: Color, circleAColor: Color, corner: CGFloat, showTechnicalDetails: Bool) {
        self.toastType = toastType
        self.isShortSuccess = isShortSuccess
        self.title = title
        self.details = details
        self.technicalDetails = technicalDetails
        self.animateCircle = animateCircle
        self.icon = icon
        self.gridentColor = gridentColor
        self.circleAColor = circleAColor
        self.corner = corner
        self.showTechnicalDetails = showTechnicalDetails
    }
    
    public var body: some View {
        if getHeight() < 100 {
            VStack {
                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: corner)
                        .foregroundColor(.white)
                        .frame(height: getHeight())
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 0.0, y: 0.0)
                        .shadow(color: .black.opacity(0.1), radius: 30, x: 0.0, y: 0.0)
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 32, height: 32)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: animateCircle)

                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 32, height: 32)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2).delay(1.5).repeatForever(autoreverses: false), value: animateCircle)
                                .onAppear {
                                    animateCircle.toggle()
                                }

                            icon
                                .font(.system(size: 32))
                                .foregroundColor(circleAColor)
                        }
                        .padding()
                        Spacer()
                    }
                    Text(title).fontWeight(.semibold).font(.title3).foregroundColor(.black)
                }
                .ignoresSafeArea(edges: [.horizontal, .top])
                .task {
                    setColors()
                    setTitle()
                    // animateCircle.toggle()
                }
            }
            .padding()
        } else {
            VStack {
                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: corner)
                        .foregroundColor(.white)
                        .frame(height: getHeight())
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 0.0, y: 0.0)
                        .shadow(color: .black.opacity(0.1), radius: 30, x: 0.0, y: 0.0)

                    VStack(spacing: 5) {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 64, height: 64)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2).delay(1).repeatForever(autoreverses: false), value: animateCircle)

                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(circleAColor)
                                .frame(width: 64, height: 64)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2).delay(1.5).repeatForever(autoreverses: false), value: animateCircle)
                                .onAppear {
                                    animateCircle.toggle()
                                }

                            icon
                                .font(.system(size: 64))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, circleAColor)
                        }
                        .padding(.top, -20)

                        Text(title).bold().font(.system(size: 30)).foregroundColor(.black)
                            .padding(.top)
                            .padding(.bottom, 8)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)

                        Text(details).foregroundColor(.black).opacity(0.5)
                            .padding([.horizontal, .bottom])
                            .minimumScaleFactor(0.75)
                            .lineLimit(4)
                            .truncationMode(.tail)
                            .font(.subheadline)

                        if technicalDetails.isBlank == false {
                            Button(action: {
                                showTechnicalDetails.toggle()
                            }, label: {
                                Text(showTechnicalDetails ? "Hide Technical Details" : "Show Technical Details")
                                    .font(.caption)
                            })
                            .padding()
                        }

                        if showTechnicalDetails {
                            Text(technicalDetails).foregroundColor(.black).opacity(0.5)
                                .padding([.horizontal, .bottom])
                                .minimumScaleFactor(0.75)
                                .lineLimit(4)
                                .truncationMode(.tail)
                                .font(.subheadline)
                        }

                        Text("Done")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.bottom)
                }.padding()
            }
            .ignoresSafeArea(edges: [.horizontal, .top])
            .task {
                setColors()
                setTitle()
            }
        }
    }

    public func setColors() {
        switch self.toastType {
        case .Success:
            self.icon = Image(systemName: "checkmark.circle.fill")
            self.gridentColor = Color("successToast", bundle: .main)
            self.circleAColor = Color("successToast", bundle: .main)

        case .Warning:
            self.icon = Image(systemName: "exclamationmark.circle.fill")
            self.gridentColor = Color("warningToast", bundle: .main)
            self.circleAColor = Color("warningToast", bundle: .main)

        case .Failure:
            self.icon = Image(systemName: "exclamationmark.circle.fill")
            self.gridentColor = Color("errorToast", bundle: .main)
            self.circleAColor = Color("errorToast", bundle: .main)

        case .Offline:
            self.icon = Image(systemName: "wifi.exclamationmark.circle.fill")
            self.gridentColor = Color("disconnectedBackground", bundle: .main)
            self.circleAColor = Color("disconnectedBackground", bundle: .main)
        }
    }

    public func setTitle() {
        if self.title.isBlank {
            switch self.toastType {
            case .Success:
                self.title = "Success"

            case .Warning:
                self.title = "Warning"

            case .Failure:
                self.title = "Failure"

            case .Offline:
                self.title = "Offline"
            }
        }
    }

    public func getHeight() -> CGFloat {
        var rtnVal = (self.details.count / 40) > 1 ? Double((self.details.count / 40) * 62) : 200.0
        if self.toastType == .Success && self.isShortSuccess {
            rtnVal = 60
        }

        if self.technicalDetails.isBlank == false {
            rtnVal = rtnVal + 60
        }

        if self.showTechnicalDetails {
            rtnVal = rtnVal + Double((self.technicalDetails.count / 40) * 30)
        }

        return rtnVal
    }
}


