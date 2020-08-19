//
//  SliderKnobViewiOS.swift
//  Pods
//
//  Created by Omar Abdelhafith on 07/02/2016.
//
//

#if os(iOS)
    import UIKit

    class SliderKnobView: UIView {
        var boundRange: BoundRange = BoundRange.emptyRange {
            didSet {
                setNeedsDisplay()
            }
        }

        var knobFrame: CGRect {
            get {
                return knobView.frame
            }

            set {
                knobView.frame = SliderKnobViewImpl.adjustKnobFrame(newValue, viewFrame: frame, boundRange: boundRange)
            }
        }

        var knobView: KnobView!

        var knobMovementCallback: ((CGRect) -> Void)?

        init() {
            super.init(frame: CGRect.zero)
            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }

        func commonInit() {
            knobView = KnobView()
            knobView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

            addSubview(knobView)
        }

        override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
            let isIn = knobView.frame.contains(point)
            return isIn ? knobView : nil
        }

        var draggingPoint: CGFloat = 0

        override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
            let pointInKnob = touches.first!.location(in: knobView)
            draggingPoint = RectUtil.pointHorizontalDistanceFromCenter(forRect: knobFrame, point: pointInKnob)
        }

        override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
            let point = touches.first!.location(in: self)

            knobFrame = RectUtil.updateRectHorizontalCenter(xCenter: point.x, rect: knobFrame)
            knobFrame = RectUtil.moveRect(toLeft: draggingPoint, knobFrame)

            knobMovementCallback?(knobView.frame)
        }
    }

    extension SliderKnobView: SliderKnob {
        var view: SliderKnobView { return self }
    }
#endif
