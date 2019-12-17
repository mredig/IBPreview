//
//  IBPreviewView.swift
//  IBPreview
//
//  Created by Michael Redig on 11/19/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

@IBDesignable
open class IBPreviewView: UIView, HasColor {
	public let isInterfaceBuilder: Bool = {
		#if TARGET_INTERFACE_BUILDER
		return true
		#else
		return false
		#endif
	}()

	@IBInspectable public var previewString: String?

	#if DEBUG
	override public func draw(_ rect: CGRect) {
		let myPreviewString: NSString = previewString as NSString? ?? String(describing: type(of: self)) as NSString
		IBPreviewClosures.drawClosure(isInterfaceBuilder, rect, self, myPreviewString)
	}
	#endif
}
