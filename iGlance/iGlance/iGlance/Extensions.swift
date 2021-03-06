//  Copyright (C) 2020  D0miH <https://github.com/D0miH> & Contributors <https://github.com/iglance/iGlance/graphs/contributors>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import Foundation
import Cocoa
import CocoaLumberjack

extension Notification.Name {
    /** The notification name for os theme changes. */
    static let AppleInterfaceThemeChangedNotification = Notification.Name("AppleInterfaceThemeChangedNotification")

    /** Notification name to kill the launcher application */
    static let killLauncher = Notification.Name("killLauncher")
}

extension NSColor {
    /**
     * Returns the corresponding NSColor to the given hex color string.
     *
     * - Parameter hex: The given hex string
     * - Parameter alpha: The alpha value of the color. This value should be between 0.0 and 1.0
     *
     * - Returns: The color as a NSColor
     */
    static func colorFrom(hex: String, alpha: Float? = nil) -> NSColor {
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // remove the hastag if present
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }

        // if the character count is not correct return the default color gray
        if colorString.count != 6 {
            return NSColor.blue
        }

        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return NSColor(
            red: red,
            green: green,
            blue: blue,
            alpha: CGFloat(alpha ?? 1.0)
        )
    }

    /**
     * Converts the color to a hex string
     */
    func toHex() -> String {
        let redComponent = Int(self.redComponent * 0xFF)
        let greenComponent = Int(self.greenComponent * 0xFF)
        let blueComponent = Int(self.blueComponent * 0xFF)

        return String(format: "#%02X%02X%02X", redComponent, greenComponent, blueComponent)
    }
}

extension NSImage {
    /**
     * Tints the image with the given color.
     *
     * - Parameter color: The given color.
     */
    func tint(color: NSColor) -> NSImage {
        // copy the current instance of the image
        guard let image = self.copy() as? NSImage else {
            DDLogError("Could not copy the image")
            return self
        }

        // lock the copied image
        image.lockFocus()

        // set the fill color
        color.set()

        // fill the image with the color
        let imageRect = NSRect(origin: NSPoint.zero, size: image.size)
        imageRect.fill(using: .sourceAtop)

        // unlock the image instance
        image.unlockFocus()

        DDLogInfo("Tinted the image with the name '\(self.name() ?? "no name available")'")

        return image
    }
}
