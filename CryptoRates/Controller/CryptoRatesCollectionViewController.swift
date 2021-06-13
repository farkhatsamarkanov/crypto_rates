
import UIKit
import MaterialComponents.MaterialFlexibleHeader

private let reuseIdentifier = "Cell"

class CryptoRatesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var quotes: [Cached]?
    private var quoteProvider: Provider?
   
    fileprivate var headerView : CryptoRatesHeaderView?
    fileprivate let cellID : String
    fileprivate let headerID : String
    fileprivate let padding : CGFloat
    fileprivate let animationDuration : Double
  
    
    
    
    required init?(coder aDecoder: NSCoder) {
        quoteProvider = ProviderFactory.getProvider(type: .QuoteProvider) 
        padding = 10
        animationDuration = 0.5
        cellID = "CryptoRatesCollectionViewCell"
        headerID = "CryptoRatesHeaderView"
        quotes = quoteProvider?.getDataFromDatabase()
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedQuotes), name: NotificationConstants.notificationName, object: nil)
    }
    
    //observer
    @objc func receivedQuotes() {
        quotes = quoteProvider?.getDataFromDatabase()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        setupCollectionView()
        //quoteProvider?.getDataFromNetwork()
       
        
        
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.anchor(top: view.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.register(CryptoRatesCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(CryptoRatesHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let quotes = quotes {
            return quotes.count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? CryptoRatesHeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height * 0.35)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CryptoRatesCollectionViewCell
        let itemNum: NSInteger = (indexPath as NSIndexPath).row
        if let quotes = quotes {
            if let quote = quotes[itemNum] as? QuoteCached {
                let name = quote.name
                let imageURL = quote.imageURL
                let price = quote.priceUSD
                let changePct = quote.changepct24Hour
                let volume24 = quote.volume24Hour
                let volume24To = quote.volume24HourTo
                let marketCap = quote.marketCapUSD
                let lastUpdated =  Converter.convertUnixDateToStringDate(unixDate: quote.lastUpdate)
                cell.poopulateCell(name: name, imageURL: imageURL, price: price, marketCap: marketCap, volume24: volume24, volume24To: volume24To, lastUpdated: lastUpdated, changePct: changePct)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth : CGFloat
        let cellHeight : CGFloat
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            cellWidth = view.safeAreaLayoutGuide.layoutFrame.width * 0.94
            cellHeight  = cellWidth * 0.4
        } else {
            cellWidth = view.safeAreaLayoutGuide.layoutFrame.width * 0.94
            cellHeight  = cellWidth * 0.2
        }
       
        return CGSize(width: cellWidth, height: cellHeight)
    }
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemNum: NSInteger = (indexPath as NSIndexPath).row
        let detailVC = DetailViewController()
        if let quotes = quotes {
            if let quote = quotes[itemNum] as? QuoteCached {
                detailVC.populateView(imageURL: quote.imageURL, name: quote.name, fullName: quote.fullName, lastUpdate: Converter.convertUnixDateToStringDate(unixDate: quote.lastUpdate), fromSymbol: quote.fromSymbol, toSymbol: quote.toSymbol, priceUSD: quote.priceUSD, volume24Hour: quote.volume24Hour, volume24HourTo: quote.volume24HourTo, open24Hour: quote.open24Hour, high24Hour: quote.high24Hour, low24Hour: quote.low24Hour, changepct24Hour: quote.changepct24Hour, supply: quote.supply, marketCapUSD: quote.marketCapUSD, totalVolume24Hour: quote.totalVolume24Hour, totalVolume24HourTo: quote.totalVolume24HourTo)
            }
        }
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        if self.headerView?.logoImageView.alpha != 0 {
            self.headerView?.logoImageView.alpha = 0
            coordinator.animateAlongsideTransition(in: headerView, animation: nil) { (nil) in
                if let headerView = self.headerView {
                    headerView.refreshConstraints(size: size)
                }
                UIView.animate(withDuration: 0.5, animations: {
                    self.headerView?.logoImageView.alpha = 1
                })
            }
        } else {
            self.headerView?.logoTextImageView.alpha = 0
            coordinator.animateAlongsideTransition(in: headerView, animation: nil) { (nil) in
                if let headerView = self.headerView {
                    headerView.refreshConstraints(size: size)
                }
                UIView.animate(withDuration: 0.5, animations: {
                    self.headerView?.logoTextImageView.alpha = 1
                })
            }
        }
        
        flowLayout.invalidateLayout()
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = collectionView.contentOffset.y
        var opacity: CGFloat = 1.0
        var logoTextImageViewOpacity: CGFloat = 0
        if let headerView = headerView {
            let size = UIScreen.main.bounds.size
            if size.width < size.height {
                if contentOffset > headerView.frame.height * 0.6 {
                    opacity = 0
                    logoTextImageViewOpacity = 1
                }
            } else {
                if contentOffset > headerView.frame.height * 0.4 {
                    opacity = 0
                    logoTextImageViewOpacity = 1
                }
            }
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            if opacity > 0 {
                self.headerView?.logoImageView.alpha = opacity
            }
            self.headerView?.logoTextImageView.alpha = logoTextImageViewOpacity
        })
        
        if opacity == 0 {
            self.headerView?.logoImageView.alpha = opacity
        }
        
        if contentOffset > 0 {
            return
        }
       
        headerView!.animator.fractionComplete =  1 - (abs(contentOffset)/100)
       
    }
    
}
