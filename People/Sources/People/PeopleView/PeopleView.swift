//
//  PeopleView.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import SwiftUI
import SwiftData

public struct PeopleView: View {
    @State private var searchtext: String = ""
    @State private var viewModel: ViewModel
    
    public init(modelContext: ModelContext, service: DataServiceProtocol) {
        let viewModel = ViewModel(modelContext: modelContext, service: service)
        _viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            content
                .navigationTitle("Demo")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchtext)
        }
        .refreshable {
            await viewModel.loadPeople()
        }
        .task {
            await viewModel.loadPeople()
        }
    }
    
    var content: some View {
        ListView(searchText: searchtext, error: viewModel.error) {
            Task {
                await viewModel.loadPeople()
            }
        }
        .overlay(
            Group {
                if viewModel.loading {
                    ProgressView()
                }
            }
        )
    }
}

#Preview {
    @Previewable @Environment(\.modelContext)  var modelContext
    
    PeopleView(modelContext: modelContext, service: MockDataService())
        .modelContainer(for: [Person.self])
}
