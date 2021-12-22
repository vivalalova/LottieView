//
//  LottieView.swift
//
//  Created by Lova on 2021/12/16.
//

import Lottie
import SwiftUI

@available(iOS 14.0.0, *)
public struct LottieView: UIViewRepresentable {
    public typealias Context = UIViewRepresentableContext<LottieView>

    public let name: String
    @Binding public var status: LottieView.Status?

    public init(name: String, status: Binding<LottieView.Status?>) {
        self.name = name
        self._status = status
    }

    var animationView = AnimationView()

    public func makeUIView(context: Context) -> UIView {
        let containerView = UIView(frame: .zero)

        self.animationView.animation = Animation.named(self.name)
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.loopMode = .playOnce
        self.animationView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(self.animationView)

        NSLayoutConstraint.activate([
            self.animationView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            self.animationView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        ])

        return containerView
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.animate(status: self.status)
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

@available(iOS 14.0.0, *)
public extension LottieView {
    class Coordinator: NSObject {
        var parent: LottieView

        init(_ parent: LottieView) {
            self.parent = parent
        }

        func animate(status: Status?) {
            switch status {
            case .none:
                self.parent.animationView.stop()
            case let .play(stop, speed, fromFrame, toFrame, loopMode):
                if stop {
                    self.parent.animationView.stop()
                }

                self.parent.animationView.animationSpeed = speed
                self.parent.animationView.play(fromFrame: fromFrame, toFrame: toFrame, loopMode: loopMode)
            }
        }
    }

    enum Status {
        case play(
            stop: Bool = false,
            speed: CGFloat = 1,
            fromFrame: CGFloat,
            toFrame: CGFloat,
            loopMode: LottieLoopMode = .playOnce
        )
    }
}
