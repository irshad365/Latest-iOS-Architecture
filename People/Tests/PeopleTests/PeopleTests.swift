import Testing
import SwiftData
import Core
@testable import People

@MainActor
@Suite("Test people view's viewmodel")
class TestPeopleViewViewModel {
        
    @Test("Intialize viewmodel")
    func intializeViewModel() async throws {
        let container = try ModelContainer(for: Person.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let modelContext =  container.mainContext
        
        let viewModel = PeopleView.ViewModel(modelContext: modelContext, service: MockDataService())
        
        let people = try modelContext.fetch(FetchDescriptor<Person>())
        
        #expect(people.isEmpty)
        #expect(viewModel.loading == false)
        #expect(viewModel.error == nil)
    }
    
    @Test("Load people without any error")
    func loadPeopleWithData() async throws {
        let container = try ModelContainer(for: Person.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let modelContext =  container.mainContext
        
        let viewModel = PeopleView.ViewModel(modelContext: modelContext, service: MockDataService())
        await viewModel.loadPeople()
        
        let people = try modelContext.fetch(FetchDescriptor<Person>())
        
        #expect(!people.isEmpty)
        #expect(viewModel.loading == false)
        #expect(viewModel.error == nil)
    }
    
    @Test("Load people failed with error")
    func loadPeopleWithError() async throws {
        let container = try ModelContainer(for: Person.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let modelContext =  container.mainContext
        
        let viewModel = PeopleView.ViewModel(modelContext: modelContext, service: MockDataService(throwError: true))
        await viewModel.loadPeople()
        
        let people = try modelContext.fetch(FetchDescriptor<Person>())
        
        #expect(people.isEmpty)
        #expect(viewModel.loading == false)
        #expect(viewModel.error == CustomError.undefined.localizedDescription)
    }
}
