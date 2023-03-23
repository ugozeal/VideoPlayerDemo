//
//  QueryTag.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import SwiftUI

struct QueryTag: View {
    var query: Query
    var isSelected: Bool
    
    var body: some View {
        Text(query.name)
            .font(.caption)
            .bold()
            .foregroundColor(isSelected ? .black : .gray)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
    }
}

struct QueryTag_Previews: PreviewProvider {
    static var previews: some View {
        QueryTag(query: Query.animals, isSelected: true)
    }
}
