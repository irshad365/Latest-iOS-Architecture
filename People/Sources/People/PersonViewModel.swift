//
//  PersonViewModel.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

@MainActor
public class PersonViewModel: ObservableObject {
    @Published var loading: Bool
    @Published var people: [Person] = []
    @Published var error: String?
    @Published var filteredPeople: [Person] = []

    private let service: DataServiceProtocol
    public init(service: DataServiceProtocol) {
        self.service = service
        self.loading = false
        self.error = nil
    }
    

    func loadPeople() async {
        loading = true
        do {
            let data = try await service.getPersonList()
            self.people = data
            self.filteredPeople = self.people
            self.error = nil
        } catch {
            self.error = error.localizedDescription
        }
        loading = false
    }
    
    func filter(value: String) {
        guard !value.isEmpty else {
            self.filteredPeople = self.people
            return
        }
        self.filteredPeople = self.people.filter{ $0.name.contains(value)}
    }
}
