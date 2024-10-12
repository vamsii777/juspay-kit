import Foundation

/// Represents the health status of the Juspay API.
///
/// This structure provides information about the operational status, current status,
/// active incidents, and ongoing maintenances affecting the Juspay API.
public struct JuspayHealthStatus: Codable, Sendable {
    /// Indicates whether the Juspay API is operational.
    ///
    /// A value of `true` means the API is functioning normally, while `false` indicates issues.
    public let isOperational: Bool
    
    /// The current status of the Juspay API.
    ///
    /// This string provides a descriptive status of the API's current state.
    public let status: String
    
    /// The active incidents affecting the Juspay API.
    ///
    /// An array of `Incident` objects representing ongoing issues or disruptions.
    public let activeIncidents: [Incident]
    
    /// The active maintenances affecting the Juspay API.
    ///
    /// An array of `Maintenance` objects representing scheduled or ongoing maintenance activities.
    public let activeMaintenances: [Maintenance]
    
    /// Initializes a new `JuspayHealthStatus` instance from a `JuspaySummary`.
    ///
    /// - Parameter summary: A `JuspaySummary` object containing the health status information.
    init(summary: JuspaySummary) {
        self.isOperational = summary.page.status == "UP"
        self.status = summary.page.status
        self.activeIncidents = summary.activeIncidents
        self.activeMaintenances = summary.activeMaintenances
    }
}

/// Internal structure representing the summary of Juspay's health status.
struct JuspaySummary: Codable, Sendable {
    /// The page information containing overall status.
    let page: Page
    
    /// List of active incidents.
    let activeIncidents: [Incident]
    
    /// List of active maintenances.
    let activeMaintenances: [Maintenance]
}

/// Represents a page in the Juspay health status report.
struct Page: Codable, Sendable {
    /// The name of the page.
    let name: String
    
    /// The URL of the page.
    let url: String
    
    /// The status of the page.
    let status: String
}

/// Represents an incident affecting the Juspay API.
public struct Incident: Codable, Sendable {
    /// The name or title of the incident.
    public let name: String
    
    /// The start time of the incident.
    public let started: String
    
    /// The current status of the incident.
    public let status: String
    
    /// The impact level of the incident.
    public let impact: String
    
    /// The URL for more information about the incident.
    public let url: String
}

/// Represents a maintenance activity affecting the Juspay API.
public struct Maintenance: Codable, Sendable {
    /// The name or title of the maintenance activity.
    public let name: String
    
    /// The start time of the maintenance.
    public let start: String
    
    /// The current status of the maintenance.
    public let status: String
    
    /// The expected duration of the maintenance.
    public let duration: String
    
    /// The URL for more information about the maintenance.
    public let url: String
}