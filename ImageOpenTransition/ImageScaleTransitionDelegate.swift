//
//  ImageOpenTransition.swift
//  CellOpenTransition
//
//  Created by Matan Cohen on 7/12/16.
//  Copyright © 2016 Jive. All rights reserved.
//

import Foundation
import UIKit

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////


 * ImageScaleTransitionObjects should be inserted in an array, first is lowest as subview, and the last object will be the top subview
 
 * UIImageView - view to translate from, has to be:
  imageView.contentMode = UIViewContentMode.ScaleAspectFill
  imageView.clipsToBounds = true



////////////////////////////////////////////////////////////////////////////////////////////////////////
 */

public class ImageScaleTransitionDelegate : NSObject , UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    var transitionObjects : Array<ImageScaleTransitionObject>!
    var usingNavigationController : Bool
    var duration: NSTimeInterval
    public var fadeOutAnimationDuration : NSTimeInterval = 0.1 //After animation happends, this is the fade out of the image copy.
    public var fadeOutAnimationDelayPresent : NSTimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    public var fadeOutAnimationDelayDismiss : NSTimeInterval = 0.1 //After animation happends, this is the delay before fade out of the image, use if original image takes time to load.
    public var fromViewControllerScaleAnimation : CGFloat = 1.0 //When animation opens viewController, the view has a scale animation to make it zoom in. Make 1.0 for turning off.
    
    public init(transitionObjects : Array<ImageScaleTransitionObject>, usingNavigationController : Bool, duration: NSTimeInterval) {
        self.transitionObjects = transitionObjects
        self.usingNavigationController = usingNavigationController
        self.duration = duration
    }
    
    public final func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionPresent()
    }
    
    public final func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.createImageScaleTransitionDismiss()
    }
    
    //MARK: Navigation controller transition
    public final func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .Pop:
            return self.createImageScaleTransitionDismiss()
        case .Push:
            return self.createImageScaleTransitionPresent()
        case .None:
            return nil
        }
    }
    
    internal func createImageScaleTransitionDismiss()->ImageScaleTransitionDismiss {
        return  ImageScaleTransitionDismiss(transitionObjects: self.transitionObjects, usingNavigationController: self.usingNavigationController, duration : duration, fadeOutAnimationDuration : self.fadeOutAnimationDuration, fadeOutAnimationDelay : self.fadeOutAnimationDelayDismiss)
    }
    
    internal func createImageScaleTransitionPresent()->ImageScaleTransitionPresent {
        return ImageScaleTransitionPresent(transitionObjects: self.transitionObjects, duration : duration, fadeOutAnimationDuration : self.fadeOutAnimationDuration, fadeOutAnimationDelay: self.fadeOutAnimationDelayPresent, fromViewControllerScaleAnimation : self.fromViewControllerScaleAnimation, usingNavigationController: self.usingNavigationController)
    }
}