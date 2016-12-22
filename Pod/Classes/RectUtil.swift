//
//  RectUtil.swift
//  Pods
//
//  Created by Omar Abdelhafith on 06/02/2016.
//
//

import Foundation


class RectUtil {
  
  static func updateRectHorizontalCenter(xCenter: CGFloat, _ rect: CGRect) -> CGRect {
    return CGRect(
      x: xCenter - (rect.size.height / 2.0),
      y: 0,
      width: rect.size.width,
      height: rect.size.height)
  }

  static func pointHorizontalDistanceFromCenter(forRect rect: CGRect, point: CGPoint) -> CGFloat {
    return (rect.width / 2.0) - point.x
  }
  
  static func moveRect(toLeft xValue: CGFloat, _ rect: CGRect) -> CGRect {
    var newRect = rect
    newRect.origin.x += xValue
    return newRect
  }
  
  static func centerRectVertically(height: CGFloat, _ rect: CGRect) -> CGRect {
    return CGRect(
      x: rect.origin.x,
      y: (height - rect.size.height) / 2.0,
      width: rect.size.width,
      height: rect.size.height)
  }
  
  static func constraintRectWithinBounds(boundsToConstraint boundRange: BoundRange, original source: CGRect) -> CGRect {
    var destinationRect = source
    
    if source.minX < boundRange.start {
      destinationRect.origin.x = boundRange.start
    }
    
    if source.maxX > boundRange.end {
      destinationRect.origin.x = boundRange.end - source.width
    }
    
    return destinationRect
  }

  static func applyBoundRange(boundRange: BoundRange, _ frame: CGRect) -> CGRect {
    var rect = frame
    rect.origin.x = boundRange.start
    rect.size.width = boundRange.width
    return rect
  }
  
  static func setRectHeight(height: CGFloat, _ rect: CGRect) -> CGRect {
    var frame = rect
    frame.size.height = height
    return frame
  }
  
}
