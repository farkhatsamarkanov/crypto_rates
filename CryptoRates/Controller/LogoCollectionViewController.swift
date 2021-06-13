//
//  LogoTableViewController.swift
//  CryptoRates
//
//  Created by Admin on 17/06/2020.
//

import UIKit

class LogoCollectionViewController: UICollectionViewController {

    private var quotes : [Cached]? = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var quoteProvider: Provider?
    private var cellID = "ConverterQuoteLogoCollectionViewCell"
    private var sourceButton: SourceButtonType?
    private let padding : CGFloat = 10
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredQuotes = [Cached]()
    private var isSearchBarEmpty:Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    enum SourceButtonType {
        case baseLogoButton
        case resultLogoButton
    }
    
    public func setSourceButton(sourceButton: SourceButtonType) {
        self.sourceButton = sourceButton
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteProvider = ProviderFactory.getProvider(type: .QuoteProvider)
              
        quotes = quoteProvider?.getDataFromDatabase()
               
        configureSearchController()
               
        configureCollectionView()
        configureCollectionViewLayout()

    }

    // MARK: - Table view data source

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredQuotes.count
        } else if let quotes = quotes{
            return quotes.count
        } else {
            return 0
        }
        
        
    }

  
    
    private func configureCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as!  ConverterQuoteLogoCollectionViewCell
        let itemNum: NSInteger = (indexPath as NSIndexPath).row
        
        var imageURL = ""
        var fullName = ""
        
        if isFiltering() {
            if let temporaryQuote = filteredQuotes[itemNum] as? QuoteCached {
                imageURL = temporaryQuote.imageURL
                fullName = temporaryQuote.fullName
            }
        } else {
            if let quotes = quotes {
                if let temporaryQuote = quotes[itemNum] as? QuoteCached {
                    imageURL = temporaryQuote.imageURL
                    fullName = temporaryQuote.fullName
                }
            }
        }
        cell.populateCell(imageURL: imageURL, fullName: fullName)
        return cell
    }
    
   
    
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var quoteDict: [String : QuoteCached] = [:]
        var quote = QuoteCached()
        
        if isFiltering() {
            if let temporaryQuote = filteredQuotes[indexPath.row] as? QuoteCached {
                quote = temporaryQuote
            }
        } else {
            if let quotes = quotes {
                if let temporaryQuote = quotes[indexPath.row] as? QuoteCached {
                    quote = temporaryQuote
                }
            }
        }
        if let source = sourceButton {
            if source == .baseLogoButton {
                quoteDict = ["baseLogoButton" : quote]
            } else {
                 quoteDict = ["resultLogoButton" : quote]
            }
        }
        NotificationCenter.default.post(name: NotificationConstants.chosenQuoteNotificationName, object: nil, userInfo: quoteDict)
        dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
       
        collectionView.register(ConverterQuoteLogoCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    private func configureSearchController() {
           searchController.searchResultsUpdater = self
        searchController.delegate = self
           searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search currency"
        
        
        
       
        
            
                

        navigationItem.searchController = searchController
        definesPresentationContext = true
       }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
}

extension LogoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat
        let cellHeight : CGFloat
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            cellWidth = view.safeAreaLayoutGuide.layoutFrame.width * 0.94
            cellHeight  = cellWidth * 0.15
        } else {
            cellWidth = view.safeAreaLayoutGuide.layoutFrame.width * 0.94
            cellHeight  = cellWidth * 0.1
        }
     
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension LogoCollectionViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String){
        if let quotes = quotes {
            filteredQuotes = quotes.filter({ (quote: Cached) -> Bool in
                let downcastedQuote = quote as! QuoteCached
                return downcastedQuote.fullName.lowercased().contains(searchText.lowercased())
            })
        }
        collectionView.reloadData()
    }
    
}
