//
//  RickMortyViewModel.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 25.05.2023.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var characters: [Result] { get set }
    var service: RickyMortyService { get }
    
    var rickMortyOutput: RickMortyOutput? { get }
    
    func setDelegate(output: RickMortyOutput)
}

final class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutput: RickMortyOutput?
    
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
    
    var characters: [Result] = []
    private var isLoading = false
    let service: RickyMortyService
    
    init() {
       service = RickMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        service.fetchAllData { [weak self] response in
            guard let self = self else { return }
            self.changeLoading()
            self.characters = response ?? []
            self.rickMortyOutput?.saveDatas(values: self.characters)
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
