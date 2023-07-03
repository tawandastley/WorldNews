//
//  SecondViewController.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/02.
//

import UIKit
import SafariServices

class HomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let service = Service()
    var articles = [Articles]()
    var imageView: UIImage!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        setupRefreshControl()
        fetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell

        cell.articleImage.image = downloadImage(from: articles[indexPath.row].url ?? "https://ichef.bbci.co.uk/news/1024/branded_news/EC1E/production/_130264406_whatsappimage2022-10-29at12.02.24.jpg")
        cell.articleTitle.text = articles[indexPath.row].title
        cell.articleDescription.text = articles[indexPath.row].description
        cell.articleDate.text = articles[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showArticle(with: articles[indexPath.row].url ?? "https://ichef.bbci.co.uk/news/1024/branded_news/EC1E/production/_130264406_whatsappimage2022-10-29at12.02.24.jpg")
    }
    
    func fetchArticles() {
        service.fetchArticles { [weak self] article in
            self?.articles = article.articles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchArticles()
        refreshControl.endRefreshing()
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
}

extension HomePageViewController {
    
    func showArticle(with url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    func downloadImage(from url: String) -> UIImage? {
        
        guard let formattedURL = URL(string: url) else { return nil }
        service.getData(from: formattedURL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView = UIImage(data: data)
            }
        }
        return imageView
    }
}
