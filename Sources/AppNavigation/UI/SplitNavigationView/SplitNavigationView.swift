#if canImport(UIKit) || os(macOS)
  import SwiftDux
  import SwiftUI

  /// Create a master-detail style split navigation view.
  public struct SplitNavigationView<MasterContent>: WaypointResolverView where MasterContent: View {
    private var masterContent: MasterContent

    /// Initiate a `SplitNavigationView` with a root view.
    /// 
    /// - Parameter masterContent: The master view.
    public init(@ViewBuilder masterContent: () -> MasterContent) {
      self.masterContent = masterContent()
    }

    public func body(info: ResolvedWaypointInfo) -> some View {
      NativeSplitNavigationView(
        masterContent: masterContent.waypoint(with: info.nextWaypoint)
      )
      .edgesIgnoringSafeArea(.all)
      .waypoint(with: info.nextWaypoint)
    }
  }
#endif
