//
//  IBPreviewView.swift
//  IBPreview
//
//  Created by Michael Redig on 11/19/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

@IBDesignable
open class IBPreviewView: UIView {
	private var inIB = false

	@IBInspectable public var previewString: String?

	override public func prepareForInterfaceBuilder() {
		inIB = true
	}

	#if DEBUG
	override public func draw(_ rect: CGRect) {
		guard inIB, let context = UIGraphicsGetCurrentContext() else { return }

		let color = getColor()
		context.setStrokeColor(color.cgColor)
		context.stroke(rect, width: 2)
		let topLeft = CGPoint.zero
		let topRight = CGPoint(x: bounds.maxX, y: 0)
		let botLeft = CGPoint(x: 0, y: bounds.maxY)
		let botRight = CGPoint(x: bounds.maxX, y: bounds.maxY)
		context.strokeLineSegments(between: [topLeft, botRight])
		context.strokeLineSegments(between: [botLeft, topRight])

		let text: NSString = (previewString ?? String(describing: type(of: self))) as NSString
		let font = UIFont.systemFont(ofSize: 14, weight: .medium)
		let textAttributes: [NSAttributedString.Key : Any] = [
			NSAttributedString.Key.foregroundColor: color,
			NSAttributedString.Key.font: font
		]
		let midPoint = CGPoint(x: bounds.midX, y: bounds.midY)
		let labelSize = text.size(withAttributes: textAttributes)
		let textPoint = CGPoint(x: midPoint.x - labelSize.width / 2,
								y: midPoint.y - labelSize.height / 2)
		text.draw(in: CGRect(origin: textPoint, size: labelSize), withAttributes: textAttributes)
	}

	private func getColor() -> UIColor {
		let bgColor: UIColor
		if #available(iOS 13.0, *) {
			bgColor = backgroundColor ?? .systemBackground
		} else {
			bgColor = backgroundColor ?? .white
		}
		var value: CGFloat = 0
		bgColor.getHue(nil, saturation: nil, brightness: &value, alpha: nil)
		value += 0.55
		while value > 1 {
			value -= 1
		}
		return UIColor(hue: 0, saturation: 0, brightness: value, alpha: 1.0)
	}
	#endif
}
