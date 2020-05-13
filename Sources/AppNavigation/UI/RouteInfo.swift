import SwiftUI

/// Relative routing information that is injected into the environment.
public struct RouteInfo {

  /// The scene name.
  public var sceneName: String

  /// The active path relative to the view.
  public var path: String

  public var isBranch: Bool = false

  /// Resolve the `RouteState` relative to the view from the application state.
  /// - Parameter state: The application state.
  /// - Returns: The `RouteState`.
  public func resolve(in state: NavigationStateRoot) -> RouteState? {
    state.navigation.sceneByName[sceneName]?.route
  }

  /// Resolve the `RouteLeg` relative to the view from the application state.
  /// - Parameter state: The application state.
  /// - Returns: The `RouteLeg`.
  public func resolveLeg(in state: NavigationStateRoot) -> RouteLeg? {
    resolve(in: state)?.legsByPath[path]
  }

  /// Get the next RouteInfo object for the provided component.
  /// - Parameters:
  ///   - component: The next component
  ///   - isBranch: Indicates if the next route is a branch of a route.
  /// - Returns: A new `RouteInfo`
  public func next<T>(with component: T, isBranch: Bool = false) -> RouteInfo where T: LosslessStringConvertible {
    RouteInfo(sceneName: sceneName, path: "\(path)\(component)/", isBranch: isBranch)
  }
}

public final class RouteInfoKey: EnvironmentKey {
  public static var defaultValue = RouteInfo(sceneName: SceneState.mainSceneName, path: "/")
}

extension EnvironmentValues {

  public var routeInfo: RouteInfo {
    get { self[RouteInfoKey] }
    set { self[RouteInfoKey] = newValue }
  }
}

extension View {

  public func scene(named name: String) -> some View {
    self.environment(\.routeInfo, RouteInfo(sceneName: name, path: "/"))
  }
}