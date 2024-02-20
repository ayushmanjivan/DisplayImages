//
//  ViewController.swift
//  DisplayImages
//
//  Created by Developer on 16/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var imagesArray: [String] = ["img1", "img2", "img3"]
    var searchedData: [ImageData] = []
    var isSearched = false
    var products: [ImageData] = [
        ImageData(name: "Fitness Tracker", imageName: "fitnesstracker"),
        ImageData(name: "Wireless Charger", imageName: "wirelesscharger"),
        ImageData(name: "Smartphone", imageName: "smartphone"),
        ImageData(name: "Laptop", imageName: "laptop"),
        ImageData(name: "Headphones", imageName: "headphones"),
        ImageData(name: "Backpack", imageName: "backpack"),
        ImageData(name: "Wristwatch", imageName: "wristwatch"),
        ImageData(name: "Sneakers", imageName: "sneakers"),
        ImageData(name: "Book", imageName: "book"),
        ImageData(name: "Desk Lamp", imageName: "desklamp"),
        ImageData(name: "Gaming Console", imageName: "gamingconsole"),
        ImageData(name: "Camera", imageName: "camera"),
        ImageData(name: "Bluetooth Speaker", imageName: "bluetoothspeaker"),
        ImageData(name: "Sunglasses", imageName: "sunglasses"),
        ImageData(name: "T-shirt", imageName: "tshirt"),
        ImageData(name: "Jeans", imageName: "jeans"),
        ImageData(name: "Water Bottle", imageName: "waterbottle"),
        ImageData(name: "Coffee Mug", imageName: "coffeemug"),
        ImageData(name: "Notebook", imageName: "notebook"),
        ImageData(name: "Tablet", imageName: "tablet")
    ]

    var filteredProducts: [ImageData] {
        searchBar.text?.isEmpty ?? false ? products : products.filter { $0.name.lowercased().contains(searchBar.text?.lowercased() ?? "") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128.0
        collectionView?.registerCell(CollectionViewCell.self)
        tableView.registerCell(TableViewCell.self)
        pageControl.currentPage = 0
        pageControl.numberOfPages = imagesArray.count
        searchedData = filteredProducts
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearched = true
        searchedData = searchBar.text?.isEmpty ?? false ? products : products.filter { $0.name.lowercased().contains(searchBar.text?.lowercased() ?? "") }
        tableView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CollectionViewCell.self, for: indexPath)
        cell.imageView.image = UIImage(named: imagesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearched {
            return searchedData.count
        } else {
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TableViewCell.self)
        if isSearched {
            cell.imageView?.image = UIImage(named: searchedData[indexPath.row].imageName)
            cell.profileLabel.text = searchedData[indexPath.row].name
        } else {
            cell.imageView?.image = UIImage(named: products[indexPath.row].imageName)
            cell.profileLabel.text = products[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
}


extension UIImageView {
    func downloadImage(from url: URL) {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                print("error occured while accessing link")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
