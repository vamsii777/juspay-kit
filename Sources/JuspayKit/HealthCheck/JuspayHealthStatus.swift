import Foundation

/// Internal structure representing the summary of Juspay's health status.
public struct JuspayHealthStatus: Codable, Sendable {
    /// The page information containing overall status.
    let page: Page

    /// List of active incidents.
    let activeIncidents: [Incident]?

    /// List of active maintenances.
    let activeMaintenances: [Maintenance]?
}

/// Represents a page in the Juspay health status report.
struct Page: Codable, Sendable {
    /// The name of the page.
    let name: String

    /// The URL of the page.
    let url: String

    /// The status of the page.
    let status: HealthStatus
}

/// Represents an incident affecting the Juspay API.
public struct Incident: Codable, Sendable {
    /// The name or title of the incident.
    public let name: String

    /// The start time of the incident.
    public let started: String

    /// The current status of the incident.
    public let status: HealthStatus

    /// The impact level of the incident.
    public let impact: HealthStatus

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
    public let status: HealthStatus

    /// The expected duration of the maintenance.
    public let duration: String

    /// The URL for more information about the maintenance.
    public let url: String
}


public enum HealthStatus: String, Codable, Sendable {
    case up = "UP"
    case hasIssues = "HASISSUES" 
    case underMaintenance = "UNDERMAINTENANCE"
    case identified = "IDENTIFIED"
    case investigating = "INVESTIGATING"
    case monitoring = "MONITORING"
    case resolved = "RESOLVED"
    case majorOutage = "MAJOROUTAGE"
    case partialOutage = "PARTIALOUTAGE"    
    case minorOutage = "MINOROUTAGE"     
    case operational = "OPERATIONAL"    
    case notStartedYet = "NOTSTARTEDYET"
    case inProgress = "INPROGRESS"
    case completed = "COMPLETED"    
}
