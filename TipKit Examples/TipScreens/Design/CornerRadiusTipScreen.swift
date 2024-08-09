//
//  CornerRadiusTip.swift
//  TipKit Examples
//
//  Created by Jordi Bruin on 29/07/2023.
//

import SwiftUI
import TipKit

struct CornerRadiusTipScreen: View {
    
    var body: some View {
        VStack {
            TscTipView(CornerRadiusTip(), analyticsName: "CornerRadiusTip")
                .tipCornerRadius(4)
            
            TscTipView(CornerRadiusTip(), analyticsName: "CornerRadiusTip")
                .tipCornerRadius(20)
            
            TscTipView(CornerRadiusTip(), analyticsName: "CornerRadiusTip")
                .tipCornerRadius(40)
            
            Text("This tip shows how you can customise the corner radius for your TipViews.")
        }
        .padding(12)
        .navigationTitle("Corner Radius Tip")
    }
}

#Preview {
    CornerRadiusTipScreen()
}
