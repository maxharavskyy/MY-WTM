//
//  SearchController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 25.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase

class SearchController: UICollectionViewController, UISearchResultsUpdating, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "searchId"
    var events = [Event]()
    var filteredEvents = [Event]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK:- ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        searchBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.isHidden = false
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- action methods
    @objc func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- SearchBar and filtering
    
    fileprivate func searchBarSetup() {
        navigationController?.navigationBar.isHidden = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    func filterEvents(for searchText: String) {
        filteredEvents = events.filter { event in
            return event.title!.lowercased().contains(searchText.lowercased())
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterEvents(for: searchController.searchBar.text ?? "")
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }


 
    //MARK:- Cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventController = EventController()
        if searchController.isActive && searchController.searchBar.text != ""  {
            eventController.event = filteredEvents[indexPath.item]
            navigationController?.pushViewController(eventController, animated: true)
        } else {
            eventController.event = events[indexPath.item]
            navigationController?.pushViewController(eventController, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        if searchController.isActive && searchController.searchBar.text != ""  {
            cell.cellController.event = filteredEvents[indexPath.item]
        } else {
             cell.cellController.event = events[indexPath.item]
        }
       return cell
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEvents.count
        }
        return events.count
    }
    
    //MARK:- layout setup
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 20, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: 0, bottom: 20, right: 0)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
