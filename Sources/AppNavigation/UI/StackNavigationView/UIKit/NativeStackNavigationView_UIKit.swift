#if canImport(UIKit)

  import SwiftDux
  import SwiftUI

  internal struct NativeStackNavigationView<RootView>: View where RootView: View {
    var animate: Bool
    var rootView: RootView

    var body: some View {
      NavigationControllerRepresentable(animate: animate, rootView: rootView).edgesIgnoringSafeArea(.all)
    }
  }

  extension NativeStackNavigationView {

    struct NavigationControllerRepresentable<RootView>: UIViewControllerRepresentable
    where RootView: View {
      @Environment(\.waypoint) private var waypoint
      @Environment(\.rootDetailWaypointContent) private var rootDetailWaypointContent
      @MappedDispatch() private var dispatch

      var animate: Bool
      var rootView: RootView

      func makeUIViewController(context: Context) -> UINavigationController {
        let coordinator = context.coordinator
        let navigationController = UINavigationController()
        coordinator.navigationController = navigationController
        return navigationController
      }

      /// Cleans up the presented `UIViewController` (and coordinator) in
      /// anticipation of their removal.
      static func dismantleUIViewController(
        _ uiViewController: UINavigationController,
        coordinator: StackNavigationCoordinator
      ) {}

      func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.waypoint = waypoint
        context.coordinator.animate = animate
        context.coordinator.setRootView(rootView: rootView)
        context.coordinator.setRootDetailView(content: rootDetailWaypointContent)
        context.coordinator.updateCurrentViewControllers(animate: animate)
      }

      func makeCoordinator() -> StackNavigationCoordinator {
        return StackNavigationCoordinator(
          dispatch: dispatch,
          waypoint: waypoint,
          detailContent: rootDetailWaypointContent,
          animate: animate,
          rootView: rootView
        )
      }
    }
  }

#endif