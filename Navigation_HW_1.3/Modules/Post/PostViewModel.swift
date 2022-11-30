//
//  PostViewModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import Foundation
import CoreData

protocol PostModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((PostViewModel.State) -> Void)? { get set }
    func updateState(viewInput: PostViewModel.ViewInput)
}

final class PostViewModel: PostModelProtocol {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case postWillDelete(IndexPath)
    }
    weak var coordinator: PostCoordinator?
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .postWillDelete(let indexPath):
            CoreDataService.shared.deletePost(atIndexPath: indexPath)
        }
    }
}
