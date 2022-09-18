import Foundation
import UIKit

typealias StoryboardName = String

protocol ViewControllerFactory {
    func getInitialController(_ storyboard: StoryboardName) -> UIViewController
}

class ViewControllerFactoryImpl: ViewControllerFactory {
    
    func getInitialController(_ storyboard: StoryboardName) -> UIViewController {
        return autoreleasepool { () -> UIViewController in
            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
            return storyboard.instantiateInitialViewController()!
        }
    }
}
