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
        NavigationView {
            content
                .navigationTitle("Demo")
        }
        .task {
            await viewModel.loadPeople()
        }
        .refreshable {
            await viewModel.loadPeople()
        }
        .searchable(text: $searchtext)
        
    }
    
    var content: some View {
        VStack {
            if let error = viewModel.error {
                Text(error)
                Button("Reload") {
                    Task {
                        await viewModel.loadPeople()
                    }
                }
            }
            ListView(searchText: searchtext)
                .overlay(
                    Group {
                        if viewModel.loading {
                            ProgressView()
                        }
                    }
                )
        }
    }
}

#Preview {
    @Previewable @Environment(\.modelContext)  var modelContext
    
    PeopleView(modelContext: modelContext, service: MockDataService())
        .modelContainer(for: [Person.self])
}
