#if canImport(UIKIt)

  import SwiftUI
  import SwiftDux

  internal struct SplitNavigationOptions: Equatable {
    var preferredDisplayMode: UISplitViewController.DisplayMode = .allVisible
    var primaryEdge: UISplitViewController.PrimaryEdge = .leading
    var presentsWithGesture: Bool = true
    var preferredPrimaryColumnWidthFraction: CGFloat = UISplitViewController.automaticDimension
    var primaryBackgroundStyle: UISplitViewController.BackgroundStyle = .none

    func apply(with options: SplitNavigationOptions) -> SplitNavigationOptions {
      var newOptions = self
      newOptions.preferredDisplayMode = options.preferredDisplayMode
      newOptions.primaryEdge = options.primaryEdge
      newOptions.presentsWithGesture = options.presentsWithGesture
      newOptions.preferredPrimaryColumnWidthFraction = options.preferredPrimaryColumnWidthFraction
      newOptions.primaryBackgroundStyle = options.primaryBackgroundStyle
      return newOptions
    }
  }

  internal final class SplitNavigationPreferenceKey: PreferenceKey {
    static var defaultValue = SplitNavigationOptions()

    static func reduce(value: inout SplitNavigationOptions, nextValue: () -> SplitNavigationOptions) {
      value = nextValue()
    }
  }

  extension View {

    internal func setSplitNavigationOption(_ updater: @escaping (inout SplitNavigationOptions) -> Void) -> some View {
      self.transformPreference(SplitNavigationPreferenceKey.self, updater)
    }

    /// Set the preferred display mode.
    ///
    /// - Parameter displayMode: The display mode.
    /// - Returns: The view.
    public func splitNavigationPreferredDisplayMode(_ displayMode: UISplitViewController.DisplayMode) -> some View {
      self.setSplitNavigationOption { $0.preferredDisplayMode = displayMode }
    }

    /// Present the primary panel with a swipe gesture.
    ///
    /// - Parameter enabled: Enable the gesture.
    /// - Returns: The view.
    public func splitNavigationPresentsWithGesture(_ enabled: Bool) -> some View {
      self.setSplitNavigationOption { $0.presentsWithGesture = enabled }
    }

    // swift-format-ignore: ValidateDocumentationComments

    /// Set the preferred column width fraction of the primary panel
    ///
    /// - Parameter value: The column width fraction.
    /// - Returns: The view.
    public func splitNavigationPreferredPrimaryColumnWidthFraction(_ value: CGFloat) -> some View {
      self.setSplitNavigationOption { $0.preferredPrimaryColumnWidthFraction = value }
    }

    /// Set the edge location of the primary panel.
    ///
    /// - Parameter value: The edge to display the panel.
    /// - Returns: The view.
    public func splitNavigationPrimaryEdge(_ value: UISplitViewController.PrimaryEdge) -> some View {
      self.setSplitNavigationOption { $0.primaryEdge = value }
    }

    /// Set background style of the primary panel.
    /// 
    /// - Parameter value: The background style.
    /// - Returns: The view.
    public func splitNavigationPrimaryBackgroundStyle(_ value: UISplitViewController.BackgroundStyle) -> some View {
      self.setSplitNavigationOption { $0.primaryBackgroundStyle = value }
    }
  }

#endif