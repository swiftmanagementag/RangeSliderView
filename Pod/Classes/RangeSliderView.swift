//
//  RangeSliderView.swift
//  DublinBusMenu
//
//  Created by Omar Abdelhafith on 04/02/2016.
//  Copyright © 2016 Omar Abdelhafith. All rights reserved.
//

protocol RangeSlider: AnyObject {
    var minimumValue: Int { get set }
    var maximumValue: Int { get set }

    var minimumSelectedValue: Int { get set }
    var maximumSelectedValue: Int { get set }

    var backgroundView: SliderBackground { get set }
    var minimumKnobView: SliderKnob { get set }
    var maximumKnobView: SliderKnob { get set }

    var fullRange: Range<Int> { get set }
    var selectedRange: Range<Int> { get set }

    var bounds: CGRect { get set }

    var selectedValuesChanged: ((Int, Int) -> Void)? { get set }

    func addViewsAndRegisterCallbacks()

    func updateKnobsPlacements()

    func informAboutValueChanged()

    #if os(OSX)
        func addSubview(view: NSView)
    #else
        func addSubview(_ view: UIView)
    #endif
}

extension RangeSlider {
    fileprivate var width: CGFloat {
        return bounds.width
    }

    func addViewsAndRegisterCallbacks() {
        addToView(backgroundView.view)
        addToView(minimumKnobView.view)
        addToView(maximumKnobView.view)

        minimumKnobView.knobMovementCallback = { _ in
            self.updateKnobViews()
        }

        maximumKnobView.knobMovementCallback = { _ in
            self.updateKnobViews()
        }

        fullRange = 0 ..< 100
    }

    #if os(OSX)
        private func addToView(subView: NSView) {
            addSubview(subView)
            subView.frame = bounds
        }
    #else
        fileprivate func addToView(_ subView: UIView) {
            addSubview(subView)
            subView.frame = bounds
        }
    #endif

    fileprivate func updateKnobViews() {
        let minimumXAllowed = minimumKnobView.knobFrame.maxX
        maximumKnobView.boundRange.moveStart(minimumXAllowed)
        backgroundView.boundRange.moveStart(minimumXAllowed)

        let maximumXAllowed = maximumKnobView.knobFrame.minX
        minimumKnobView.boundRange.moveEnd(maximumXAllowed)
        backgroundView.boundRange.moveEnd(maximumXAllowed)

        updateSelectedRange()
    }

    fileprivate func updateSelectedRange() {
        let start = Int(locationForView(minimumKnobView.view))
        let end = Int(locationForView(maximumKnobView.view))

        if start == 0, end == 0 { return }

        selectedRange = start ..< end

        informAboutValueChanged()
        selectedValuesChanged?(minimumSelectedValue, maximumSelectedValue)
    }

    fileprivate func locationForView(_ view: SliderKnobView) -> CGFloat {
        let xLocation = getViewCenterX(view)
        return locationInRange(range: fullRange, viewWidth: width, xLocationInView: xLocation,
                               itemWidth: minimumKnobView.knobFrame.size.width)
    }

    fileprivate func getViewCenterX(_ view: SliderKnobView) -> CGFloat {
        return view.knobFrame.minX + view.knobFrame.width / 2.0
    }

    func updateKnobsPlacements() {
        let range = BoundRange.range(
            withFullRange: fullRange,
            selectedRange: selectedRange,
            fullWidth: width
        )

        backgroundView.boundRange = range.boundByApplyingInset(7)

        minimumKnobView.boundRange = BoundRange(start: 0, width: width)
        maximumKnobView.boundRange = BoundRange(start: 0, width: width)

        minimumKnobView.knobFrame = KnobPlacment.rangeStart.placeRect(forRange: range, size: minimumKnobView.knobFrame.size)
        maximumKnobView.knobFrame = KnobPlacment.rangeEnd.placeRect(forRange: range, size: maximumKnobView.knobFrame.size)
    }
}
