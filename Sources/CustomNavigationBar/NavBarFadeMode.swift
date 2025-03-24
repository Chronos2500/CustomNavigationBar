import SwiftUI
import UIKit

public enum NavBarFadeMode {
    // progressive: fade in/out the navigation bar background as the user scrolls
    // threshold: fade in/out the navigation bar background when the user scrolls past a certain point
    case progressive
    case threshold
}
