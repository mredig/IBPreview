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

	/// A list of all subviews that forward their actions through this PreviewControl
	public private(set) var actionForwardingSubviews: Set<UIControl> = []

	/// If you are addinga a subview that is a UIControl, you can pass it into this function to have the preview control forward all its actions. A list is maintained in `actionForwardingSubviews`. Throws if view passed in is not a subview.
	public func forwardTargetActionsFrom(subviewControl control: UIControl) throws {
		guard control.isDescendant(of: self) else { throw NSError(domain: "Some Domain", code: -1, userInfo: [NSLocalizedDescriptionKey: "view: '\(control)' is not a descendent of superview: '\(self)'"]) }
		actionForwardingSubviews.insert(control)
		control.addTarget(self, action: #selector(handleTouchDown(_:)), for: .touchDown)
		control.addTarget(self, action: #selector(handleTouchDownRepeat(_:)), for: .touchDownRepeat)
		control.addTarget(self, action: #selector(handleTouchUpInside(_:)), for: .touchUpInside)
		control.addTarget(self, action: #selector(handleTouchUpOutside(_:)), for: .touchUpOutside)
		control.addTarget(self, action: #selector(handleTouchCancel(_:)), for: .touchCancel)
		control.addTarget(self, action: #selector(handleTouchDragExit(_:)), for: .touchDragExit)
		control.addTarget(self, action: #selector(handleTouchDragEnter(_:)), for: .touchDragEnter)
		control.addTarget(self, action: #selector(handleTouchDragOutside(_:)), for: .touchDragOutside)
		control.addTarget(self, action: #selector(handleTouchDragInside(_:)), for: .touchDragInside)
		control.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)
		control.addTarget(self, action: #selector(handleEditingDidEnd(_:)), for: .editingDidEnd)
		control.addTarget(self, action: #selector(handleEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
		control.addTarget(self, action: #selector(handleEditingDidBegin(_:)), for: .editingDidBegin)
		control.addTarget(self, action: #selector(handleEditingChanged(_:)), for: .editingChanged)
		control.addTarget(self, action: #selector(handlePrimaryActionTriggered(_:)), for: .primaryActionTriggered)
	}

	#if DEBUG
	override public func draw(_ rect: CGRect) {
		let myPreviewString: NSString = previewString as NSString? ?? String(describing: type(of: self)) as NSString
		IBPreviewClosures.drawClosure(inIB, rect, self, myPreviewString)
	}
	#endif
}

// MARK: - Target Action Forwards
extension IBPreviewControl {

	open override func resignFirstResponder() -> Bool {
		actionForwardingSubviews.forEach { $0.resignFirstResponder() }
		return super.resignFirstResponder()
	}

	@objc private func handleTouchDown(_ sender: UIControl) {
		sendActions(for: .touchDown)
	}

	@objc private func handleTouchDownRepeat(_ sender: UIControl) {
		sendActions(for: .touchDownRepeat)
	}

	@objc private func handleTouchUpInside(_ sender: UIControl) {
		sendActions(for: .touchUpInside)
	}

	@objc private func handleTouchUpOutside(_ sender: UIControl) {
		sendActions(for: .touchUpOutside)
	}

	@objc private func handleTouchCancel(_ sender: UIControl) {
		sendActions(for: .touchCancel)
	}

	@objc private func handleTouchDragExit(_ sender: UIControl) {
		sendActions(for: .touchDragExit)
	}

	@objc private func handleTouchDragEnter(_ sender: UIControl) {
		sendActions(for: .touchDragEnter)
	}

	@objc private func handleTouchDragOutside(_ sender: UIControl) {
		sendActions(for: .touchDragOutside)
	}

	@objc private func handleTouchDragInside(_ sender: UIControl) {
		sendActions(for: .touchDragInside)
	}

	@objc private func handleValueChanged(_ sender: UIControl) {
		sendActions(for: .valueChanged)
	}

	@objc private func handleEditingDidEnd(_ sender: UIControl) {
		sendActions(for: .editingDidEnd)
	}

	@objc private func handleEditingDidEndOnExit(_ sender: UIControl) {
		sendActions(for: .editingDidEndOnExit)
	}

	@objc private func handleEditingDidBegin(_ sender: UIControl) {
		sendActions(for: .editingDidBegin)
	}

	@objc private func handleEditingChanged(_ sender: UIControl) {
		sendActions(for: .editingChanged)
	}

	@objc private func handlePrimaryActionTriggered(_ sender: UIControl) {
		sendActions(for: .primaryActionTriggered)
	}
}
