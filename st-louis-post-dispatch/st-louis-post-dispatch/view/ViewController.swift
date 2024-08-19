//
//  ViewController.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 16/08/24.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var subscriptions = Set<AnyCancellable>()
    var viewModel: ViewModel?
    
    private lazy var contentView: View = {
        let stack = View(frame: self.view.frame)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.fillSuperView()
        contentView.setup()
        viewModel = (UIApplication.shared.delegate as? AppDelegate)?.appFactory?.makeMainModule()
        viewModel?.getViewElements()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel?.subscriptionBinding.sink(receiveValue: { [weak self] subscription in
            self?.contentView.updateSubscriptionSection(subscription: subscription)
        }).store(in: &subscriptions)
        
        viewModel?.headerImageBinding.sink(receiveValue: { [weak self] filename in
            print(filename)
            self?.contentView.updateHeaderView(withImageFile: filename)
        }).store(in: &subscriptions)
        
        viewModel?.coverImageBinding.sink(receiveValue: { [weak self] filename in
            print(filename)
            self?.contentView.updateCoverView(withImageFile: filename)
        }).store(in: &subscriptions)
        
        // TODO: Add remeining bindings
    }
}
