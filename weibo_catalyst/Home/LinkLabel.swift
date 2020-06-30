//
//  LinkLabel.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct LinkLabel: View {
    @State var fColor = Color.primary
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(fColor)
            .onHover { isHover in
                print(isHover)
                self.fColor = isHover ? Color.red : Color.primary
            }
    }
}

struct LinkLabel_Previews: PreviewProvider {
    static var previews: some View {
        LinkLabel(text: "Hello")
    }
}
