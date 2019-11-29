//
//  IBPreviewClosures.swift
//  IBPreview
//
//  Created by Michael Redig on 11/19/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

protocol HasColor: AnyObject {
	var isInterfaceBuilder: Bool { get }
	var backgroundColor: UIColor? { get }
	func getColor() -> UIColor
}

extension HasColor {
	func getColor() -> UIColor {
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
}

enum IBPreviewClosures {
	static let drawClosure: (Bool, CGRect, HasColor, NSString) -> Void = { inIB, bounds, view, text in
		guard inIB, let context = UIGraphicsGetCurrentContext() else { return }

		let color = view.getColor()
		context.setStrokeColor(color.cgColor)
		context.stroke(bounds, width: 2)
		let topLeft = CGPoint.zero
		let topRight = CGPoint(x: bounds.maxX, y: 0)
		let botLeft = CGPoint(x: 0, y: bounds.maxY)
		let botRight = CGPoint(x: bounds.maxX, y: bounds.maxY)
		context.setStrokeColor(color.withAlphaComponent(0.35).cgColor)
		context.strokeLineSegments(between: [topLeft, botRight])
		context.strokeLineSegments(between: [botLeft, topRight])

//		let text: NSString = previewString as NSString
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
}
