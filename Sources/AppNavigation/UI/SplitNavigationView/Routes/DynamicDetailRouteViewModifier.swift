#if canImport(UIKit)

  import SwiftDux
  import SwiftUI

  internal struct DynamicDetailRouteViewModifier<T, DetailContent>: ViewModifier
  where T: LosslessStringConvertible & Equatable, DetailContent: View {
    @Environment(\.detailRoutes) private var detailRoutes

    var name: String?
    var detailContent: (T) -> DetailContent

    func body(content: Content) -> some View {
      var detailRoutes = self.detailRoutes
      detailRoutes[name ?? "/"] = {
        AnyView(
          DynamicDetailView(content: self.detailContent).resetRoute(with: "/\(self.name ?? "")/", isDetail: true)
        )
      }
      return content.environment(\.detailRoutes, detailRoutes)
    }
  }

  extension View {

    /// Create a detail route that accepts a parameter.
    /// 
    /// - Parameters:
    ///   - name: The name of the route.
    ///   - content: The content of the route.
    /// - Returns: The view.
    public func detailRoute<T, Content>(_ name: String? = nil, @ViewBuilder content: @escaping (T) -> Content) -> some View
    where T: LosslessStringConvertible & Equatable, Content: View {
      self.modifier(DynamicDetailRouteViewModifier(name: name, detailContent: content))
    }
  }

#endif
