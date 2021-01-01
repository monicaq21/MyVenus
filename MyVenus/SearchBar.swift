//
//  SearchBar.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-27.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String // text in the search bar
        
        init(text: Binding<String>) {
            _text = text // get the text in the search bar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
    
    func makeCoordinator() ->SearchBar.Coordinator {
        
        return Coordinator(text: $text)
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
        
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        
        uiView.text = text
        
    }
    
}
