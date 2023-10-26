

import Foundation
enum Localizable: String {
    // MARK: List joke View
    case navigationTitleListJokesView = "NAVIGATION_TITLE_LIST_JOKES_VIEW"
    // MARK: Alert
    case alertTitleError = "ALERT_TITLE_ERROR"
    case alertButtonOK = "ALERT_BUTTON_OK"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
