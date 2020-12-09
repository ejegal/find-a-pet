//
//  SearchPageView.swift
//  FindAPet
//
//  Created by Eugene Jegal on 12/8/20.
//

import UIKit

class SearchPageView: UIView {

    
    // MARK: Views
    private var zipCodeField = UITextField()
    private var invalidZipCodeMsg = UILabel()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() { // A lot of lines. This is typical when making views programmatically
        backgroundColor = .white
        
        let headerLabel = UILabel()
        headerLabel.text = "Home is where the pet is..."
        headerLabel.font = headerLabel.font.withSize(28.0)
        
        // Setup search text field, button, and error label
        zipCodeField.attributedPlaceholder = NSAttributedString(string: "Enter zip code",
                                                                attributes: [.strokeColor : UIColor.lightGray])
        zipCodeField.keyboardType = .numberPad
        zipCodeField.textContentType = .postalCode
        zipCodeField.borderStyle = .roundedRect
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // image from SF Symbols. iirc built-in on iOS devices.
        searchButton.tintColor = .black
        searchButton.addTarget(nil, action: #selector(searchPressed), for: .touchUpInside)
        searchButton.setContentHuggingPriority(.required, for: .horizontal)
        
        let searchBar = UIStackView(arrangedSubviews: [zipCodeField, searchButton])
        searchBar.spacing = 5.0
        
        invalidZipCodeMsg.text = "Please enter a valid zip code."
        invalidZipCodeMsg.textColor = .red
        invalidZipCodeMsg.isHidden = true
        
        let searchSection = UIStackView(arrangedSubviews: [searchBar, invalidZipCodeMsg])
        searchSection.axis = .vertical
        searchSection.spacing = 5.0
        
        // Combine with image to make page view
        let img = UIImageView(image: UIImage(named: "catdog"))
        img.setContentHuggingPriority(.defaultLow, for: .vertical)
        img.contentMode = .scaleAspectFit
        
        let pageView = UIStackView(arrangedSubviews: [headerLabel, searchSection, img])
        pageView.axis = .vertical
        pageView.alignment = .center
        pageView.setCustomSpacing(20.0, after: headerLabel)
        
        addSubview(pageView)
        pageView.translatesAutoresizingMaskIntoConstraints = false  // This must be false on views you assign constraints to programmatically in order for them to work.
        NSLayoutConstraint.activate([pageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
                                     pageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                                     pageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
                                     pageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)])
    }
    
    required init?(coder: NSCoder) {    // Do not call
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    // Closure (aka anonymous function)
    // Function literal with an optional string parameter and returns a boolean (should return true if search is valid)
    private var searchAction: ((String?) -> Bool)?
    
    func setSearchAction(action: ((String?) -> Bool)?) {
        searchAction = action
    }
    
    @objc func searchPressed() {
        if let action = searchAction {
            let isValidSearch = action(zipCodeField.text)
            self.invalidZipCodeMsg.isHidden = isValidSearch
        }
    }
}
