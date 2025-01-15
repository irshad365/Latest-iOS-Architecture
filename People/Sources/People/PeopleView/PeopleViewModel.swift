//
//  PeopleViewModel.swift
//  People
//
//  Created by Mohamed Irshad on 1/15/25.
//

import Core
import SwiftData

extension PeopleView {
    @Observable @MainActor
    class ViewModel {
        var loading: Bool = false
        var error: String?

        private let service: DataServiceProtocol
        private let modelContext: ModelContext

        init(modelContext: ModelContext, service: DataServiceProtocol) {
            self.modelContext = modelContext
            self.service = service
        }

        func loadPeople() async {
            loading = true
            error = nil
            do {
                let list = try await service.getPersonList()
                do {
                    try modelContext.transaction {
                        for item in list {
                            modelContext.insert(item)
                        }
                        do {
                            try modelContext.save()
                        } catch {
                            self.error = error.localizedDescription
                        }
                    }
                } catch {
                    self.error = error.localizedDescription
                }
            } catch {
                self.error = error.localizedDescription
            }
            loading = false
        }
    }
}
