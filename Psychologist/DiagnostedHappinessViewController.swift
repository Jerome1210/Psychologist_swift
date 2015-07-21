//
//  DiagnostedHappinessViewController.swift
//  Psychologist
//
//  Created by Lee on 2015/4/7.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

import UIKit

class DiagnostedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
	override var happiness: Int {
		didSet {
			diagnosticHistory += [happiness]
		}
	}
	
	private let defaults = NSUserDefaults.standardUserDefaults()
	
	var diagnosticHistory: [Int] {
		get {
			return defaults.objectForKey(History.DefaultKeys) as? [Int] ?? []
		}
		set {
			defaults.setObject(newValue, forKey: History.DefaultKeys)
		}
	}
	private struct History {
		static let SegueIdentifier = "Show Diagnostic History"
		static let DefaultKeys = "DiagnosedHappinessViewController.History"
	}
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let identifier = segue.identifier {
			switch identifier {
			case History.SegueIdentifier:
				if let tvc = segue.destinationViewController as? TextUIViewController {
					if let ppc = tvc.popoverPresentationController {
						ppc.delegate = self
					}
					tvc.text = "\(diagnosticHistory)"
				}
			default: break
			}
		}
	}
	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.None
	}
}
