//
//  SearchViewController.swift
//  FindAPet
//
//  Created by Eugene Jegal on 12/6/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    
    // Not to be confused with init. See info on view controller lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Typecasting since I overloaded view to a custom class (could make an extension to make it look better)
        if let view = self.view as? SearchPageView {
            view.setSearchAction { entry in
                return false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        // Default boilerplate given. Required when you have your own defined init.
        // This constructor generally gets called when you init through a nib (storyboard/xib)
        // Normally I would make a unique init with parameters, but we don't have a need for one yet (no view model). So, we'll just use this.
        super.init(nibName: nil, bundle: nil)
    }
    
    // Using this to dismiss the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func loadView() {
        view = SearchPageView()
        self.edgesForExtendedLayout = []    // Stops view from going under the navigation bar.
    }
}
