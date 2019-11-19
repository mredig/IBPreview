//
//  IBPreviewControl.swift
//  IBPreview
//
//  Created by Michael Redig on 11/19/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//
import UIKit

@IBDesignable
open class IBPreviewControl: UIControl, HasColor {
	private var inIB = false

	@IBInspectable public var previewString: String?

	override public func prepareForInterfaceBuilder() {
		inIB = true
	}

	#if DEBUG
	override public func draw(_ rect: CGRect) {
		let myPreviewString: NSString = previewString as NSString? ?? String(describing: type(of: self)) as NSString
		IBPreviewClosures.drawClosure(inIB, rect, self, myPreviewString)
	}
	#endif
}
