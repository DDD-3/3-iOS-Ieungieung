// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Host: StoryboardType {
    internal static let storyboardName = "Host"
  }

  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"
  }

  internal enum Map: StoryboardType {
    internal static let storyboardName = "Map"

    internal static let initialScene = InitialSceneType<MapViewController>(storyboard: Map.self)

    internal static let mapViewController = SceneType<MapViewController>(storyboard: Map.self, identifier: "MapViewController")

    internal static let participationViewController = SceneType<ParticipationViewController>(storyboard: Map.self, identifier: "ParticipationViewController")
  }

  internal enum Visitor: StoryboardType {
    internal static let storyboardName = "Visitor"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Visitor.self)

    internal static let visitorFinishViewController = SceneType<VisitorFinishViewController>(storyboard: Visitor.self, identifier: "VisitorFinishViewController")

    internal static let visitorMainViewController = SceneType<VisitorMainViewController>(storyboard: Visitor.self, identifier: "VisitorMainViewController")

    internal static let visitorNameViewController = SceneType<VisitorNameViewController>(storyboard: Visitor.self, identifier: "VisitorNameViewController")

    internal static let visitorStationViewController = SceneType<VisitorStationViewController>(storyboard: Visitor.self, identifier: "VisitorStationViewController")
  }
}

// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
