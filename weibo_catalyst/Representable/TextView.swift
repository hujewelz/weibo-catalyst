//
//  TextView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/7/1.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    var onEditingChanged: ((Bool) -> Void)?
    var onCommit: ((Bool) -> Void)?
    
    func makeUIView(context: Context) -> UITextView {
        let  textView = UITextView()
        textView.delegate = context.coordinator
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    func makeCoordinator() -> TextViewDelegate {
        return TextViewDelegate(text: $text)
    }
}

class TextViewDelegate: NSObject, UITextViewDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        text = textView.text
    }
}

