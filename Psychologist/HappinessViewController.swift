//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Lee on 2015/3/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
	@IBOutlet weak var faceView: FaceView! {
		didSet {
			faceView.dataSource = self
			faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
			
		}
	}
	private struct Constants {
		static let happinessGestureScale:CGFloat = 4
	}
	
	@IBAction func changedHappiness(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .Ended: fallthrough
		case .Changed:
			let translation = gesture.translationInView(faceView)
			let happinessChange	= -Int(translation.y / Constants.happinessGestureScale)
			println("\(happinessChange)")
			if happinessChange != 0 {
				happiness += happinessChange
				gesture.setTranslation(CGPointZero, inView: faceView)
			}
		default: break
		}
	}

	var happiness: Int = 50 {
		didSet{
			happiness = min(max(happiness, 0), 100)
			println("happiness = \(happiness)")
			updateUI()
		}
	}
	private func updateUI() {
		faceView?.setNeedsDisplay()
		self.title = "\(happiness)"
	}
	
	func smilinessForFaceView(sender: FaceView) -> Double? {
		return Double(happiness - 50)/50
	}
}
