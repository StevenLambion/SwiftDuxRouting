import SwiftDux
import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(OSX, unavailable)
internal struct AlertRouteViewModifier: ViewModifier {
  @MappedDispatch() private var dispatch

  var name: String
  var alert: () -> Alert

  init(name: String, alert: @escaping () -> Alert) {
    self.name = name
    self.alert = alert
  }

  public func body(content: Content) -> some View {
    RouteContents {
      self.routeContents(content: content, currentRoute: $0, leg: $1, route: $2)
    }
  }

  private func routeContents(content: Content, currentRoute: CurrentRoute, leg: RouteLeg?, route: RouteState) -> some View {
    let isActive = leg?.component == name
    let binding = Binding(
      get: { isActive },
      set: {
        if !$0 {
          self.dispatch(currentRoute.navigate(to: currentRoute.path))
        }
      }
    )
    return
      content
      .environment(\.currentRoute, isActive ? currentRoute.next(with: name) : currentRoute)
      .alert(isPresented: binding, content: self.alert)
  }
}

extension View {

  /// Create a route that displays an alert.
  ///
  /// - Parameters:
  ///   - name: The name of the route
  ///   - content: The alert to display.
  /// - Returns: A view.
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  @available(OSX, unavailable)
  public func alertRoute(_ name: String, @ViewBuilder content: @escaping () -> Alert) -> some View {
    self.modifier(AlertRouteViewModifier(name: name, alert: content))
  }
}