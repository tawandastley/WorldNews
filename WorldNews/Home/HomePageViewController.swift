//
//  SecondViewController.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/02.
//

import UIKit
import SafariServices

class HomePageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let service = Service()
    var articles = [Articles]()
    var imageView: UIImage!
    var refreshControl = UIRefreshControl()
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell")
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchArticles()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: tableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        cell.dateLabel.text = articles[indexPath.row].source?.name
        tableView.separatorStyle = .singleLine
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showArticle(with: articles[indexPath.row].url ?? "https://ichef.bbci.co.uk/news")
    }
}

//MARK: Extension TableView methods

extension HomePageViewController{

    //MARK: private methods
    
    @objc private func refresh(_ sender: AnyObject) {
        fetchArticles()
        refreshControl.endRefreshing()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        //tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    private func showArticle(with url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let viewController = SFSafariViewController(url: url, configuration: config)
            present(viewController, animated: true)
        }
    }
    
    private func fetchArticles() {
        service.fetchArticles { [weak self] article in
            self?.articles = article.articles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
}
