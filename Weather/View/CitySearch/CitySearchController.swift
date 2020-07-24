//
//  CitySearchController.swift
//  Weather
//
//  Created by Anton Tolstov on 23.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import Combine

class CitySearchController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: CitySearchControllerDelegate?
    
    private let citySearchManager: CitySearchManager? = {
        if let citiesURL = Bundle.main.url(forResource: "cities", withExtension: "csv") {
            let cityLoader = CityCSVLoader(with: citiesURL)
            return CitySearchManager(with: cityLoader)
        }
        return nil
    }()
    
    private lazy var cityTableView: UITableView = {
        let cityTableView = UITableView()
        
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        view.addSubview(cityTableView)
        return cityTableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        return searchBar
    }()
    
    override func loadView() {
        view = UIView()
        
        setupConstraints()
        setupKeyboardNotifications()
    }
    
    // For managing keyboard appearance/disappearance
    private var bottomConstraint: NSLayoutConstraint? = nil
    
    private func setupConstraints() {
        searchBar.pin.sides().top().activate
        
        bottomConstraint = cityTableView.pin.bottom().constraints.first
        
        cityTableView.pin
            .sides().below(searchBar)
            .add(bottomConstraint!).activate
    }
    
    @objc private func dismissSearchView() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Notifications

    private func setupKeyboardNotifications() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
    }
    

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.bottomConstraint?.constant = -keyboardSize.height
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint?.constant = 0
    }
}

// MARK: - UITableViewDataSource

extension CitySearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citySearchManager!.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let citySearchManager = citySearchManager {
            let city = citySearchManager.cities[indexPath.row]
            cell.textLabel?.text = city.name + ", " + city.country
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CitySearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = citySearchManager?.cities[indexPath.row] {
            delegate?.didSelect(city: city)
            dismissSearchView()
        }
    }
}

// MARK: - UISearchBarDelegate

extension CitySearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.citySearchManager?.filter = searchText
        self.cityTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissSearchView()
    }
}


