import Foundation

public protocol TutorialAnalyticsProviderProtocol {
    func trackEvent(_ event: TutorialAnalyticsEvent)
}

final class TutorialAnalyticsProvider {
    private let analyticsManager: AnalyticsManagerProtocol

    init(analyticsManager: AnalyticsManagerProtocol) {
        self.analyticsManager = analyticsManager
    }
}

extension TutorialAnalyticsProvider: TutorialAnalyticsProviderProtocol {
    func trackEvent(_ event: TutorialAnalyticsEvent) {
        // map to analytics event from analytics manager
    }
}
