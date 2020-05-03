// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Screen {
    internal enum AddName {
      internal enum Label {
        /// The history name for this new name
        internal static let newHistoryName = L10n.tr("Localizable", "screen.add_name.label.new_history_name")
        /// The new name
        internal static let newName = L10n.tr("Localizable", "screen.add_name.label.new_name")
        internal enum Error {
          /// invalid history
          internal static let newHistoryName = L10n.tr("Localizable", "screen.add_name.label.error.new_history_name")
          /// invalid name
          internal static let newName = L10n.tr("Localizable", "screen.add_name.label.error.new_name")
        }
      }
      internal enum Navbar {
        /// Add New Name
        internal static let title = L10n.tr("Localizable", "screen.add_name.navbar.title")
      }
    }
    internal enum Name {
      internal enum Label {
        /// The fantastic name
        internal static let name = L10n.tr("Localizable", "screen.name.label.name")
        /// The history for this fantastic name
        internal static let nameHistory = L10n.tr("Localizable", "screen.name.label.name_history")
      }
    }
    internal enum Names {
      internal enum Navbar {
        /// Names
        internal static let title = L10n.tr("Localizable", "screen.names.navbar.title")
      }
      internal enum TableView {
        internal enum Action {
          /// Delete
          internal static let deleteName = L10n.tr("Localizable", "screen.names.table_view.action.delete_name")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
