//
//  TipKit+TSC.swift
//  TipKit Examples
//
//  Created by Derek Hammond on 8/9/24.
//

import AppKit
import SwiftUI
import TipKit

struct AnalyticsController {
   
   static func sendShowEvent(_ tipAnalyticsName: String) {
      print("[DEBUG] TIP SHOWN: \(tipAnalyticsName)")
   }
   
   static func sendActionEvent(_ tipAnalyticsName: String, _ tipActionName: String) {
      print("[DEBUG] TIP ACTION: \(tipActionName) for Tip: \(tipAnalyticsName)")
   }
}

// MARK: - Extend TipNSView

extension TipNSView {
   public static func makeTscTipNSView(_ tip: any Tip, analyticsName: String) -> TipNSView {
      AnalyticsController.sendShowEvent(analyticsName)
      return TipNSView(tip) { item in
         AnalyticsController.sendActionEvent(analyticsName, item.id)
      }
   }
}

// MARK: - Extend TipNSPopover

extension TipNSPopover {
   public static func makeTipNSPopover(
      _ tip: any Tip,
      analyticsName: String,
      actionHandler: @escaping (Tips.Action) -> Void = { _ in }
   ) -> TipNSPopover {
      let delegate = TscTipNSPopoverDelegate(analyticsName: analyticsName)
      return TipNSPopover(tip, delegate: delegate) { item in
         AnalyticsController.sendActionEvent(analyticsName, item.id)
      }
   }
   
   private class TscTipNSPopoverDelegate: NSObject, NSPopoverDelegate {
      let analyticsName: String
      
      init(analyticsName: String) {
         self.analyticsName = analyticsName
      }
      
      func popoverDidShow(_ notification: Notification) {
         AnalyticsController.sendShowEvent(analyticsName)
      }
   }
}

// MARK: - Extend popoverTip

extension View {
   
   /// Presents a popover tip on the modified view.
   public func tscPopoverTip<Content>(_ tip: Content, analyticsName: String, arrowEdge: Edge = .top, action: @escaping (Tips.Action) -> Void = { _ in }) -> some View where Content : Tip {
      AnalyticsController.sendShowEvent(analyticsName)
      return self.popoverTip(tip, arrowEdge: arrowEdge, action: { item in
         AnalyticsController.sendActionEvent(analyticsName, item.id)
         action(item)
      })
   }
   
}

// MARK: - Extend TipView

public struct TscTipView<Content: Tip>: View {
   let analyticsName: String
   let tip: Content
   
   init(_ tip: Content, analyticsName: String) {
      self.analyticsName = analyticsName
      self.tip = tip
   }
   
   public var body: some View {
      TipView(tip, action: { item in
         AnalyticsController.sendActionEvent(analyticsName, item.id)
      })
      .onAppear {
         AnalyticsController.sendShowEvent(analyticsName)
      }
   }
}
