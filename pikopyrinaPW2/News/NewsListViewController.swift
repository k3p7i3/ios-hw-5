//
//  NewsListViewController.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 06.12.2022.
//

import UIKit

final class NewsListViewController: UIViewController {
    private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private var newsViewModels: [NewsViewModel] = []
    private var isLoading: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        fetchNews()
        configureTableView()
    }
    
    private func setupNavBar() {
        navigationItem.title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(refresh)
        )
      
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        
        tableView.pinLeft(to: view)
        tableView.pinRight(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinBottom(to: view)
    }
    
    private func setTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }
    
    @objc
    private func refresh() {
        fetchNews()
    }
    
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func fetchNews() {
        ApiService.shared.getTopStories() { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsViewModels = articles.compactMap{
                    NewsViewModel(
                        title: $0.title,
                        description: $0.description ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                }
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        
        }
    }
     
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoading {
            return newsViewModels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isLoading {
            let viewModel = newsViewModels[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(
                withIdentifier: NewsCell.reuseIdentifier,
                for: indexPath) as? NewsCell {
                
                newsCell.configure(with: viewModel)
                return newsCell
                
            }
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let newsVC = NewsViewController()
            let newsModel = newsViewModels[indexPath.row]
            newsVC.configure(with: newsModel)
            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}
