//
//  ListJokeViewController.swift
//  Test
//
//  Created by David on 25/10/23.
//

import Foundation
import UIKit

class ListJokeViewController: BaseViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .black
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            // Fallback on earlier versions
            activityIndicator.style = .whiteLarge
        }
        return activityIndicator
    }()
    
    private let jokeView: UIView = {
        let mealsView = UIView()
        mealsView.translatesAutoresizingMaskIntoConstraints = false
        mealsView.backgroundColor = .white
        return mealsView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
    }()

    private lazy var presenter: ListJokesContract.Presenter = {
        let jokesUseCase = JokeInjector.provideJokeUseCase()

        return ListJokesPresenter(view: self,
                                  jokeUseCase: jokesUseCase)
    }()

    private var listJoke: [JokeViewModel]?

    override func loadView() {
        super.loadView()
        createSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getListJokes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        title = Localizable.navigationTitleListJokesView.localized
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

private extension ListJokeViewController {
    func createSubviews() {
        view.backgroundColor = .white
        addViewsToJokeView()
        addConstraintsInJokeView()
        addViews()
        addConstraintsForViews()
    }
    
    func addViewsToJokeView() {
        jokeView.addSubview(tableView)
    }
    
    func addConstraintsInJokeView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: jokeView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: jokeView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: jokeView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: jokeView.bottomAnchor)
        ])
    }
    
    func addViews() {
        view.addSubview(jokeView)
        view.addSubview(activityIndicator)
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            jokeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jokeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jokeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jokeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupViews() {
        setActivityIndicator(activityIndicator)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        JokesTableViewCell.registerCellForTable(tableView)
    }
    
    
    func updateViews(jokes: [JokeViewModel]) {
        listJoke = jokes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListJokeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listJokes = listJoke else { return 0 }
        return listJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JokesTableViewCell.reuseIdentifier, for: indexPath) as? JokesTableViewCell else {
            return UITableViewCell()
        }
        guard let joke = listJoke?[indexPath.row] else {
            return cell
        }
        cell.fill(joke: joke)
        return cell
    }
}

extension ListJokeViewController: ListJokesContract.View {
    func render(state: ListJokesViewState) {
        switch state {
        case .clear:
            break
        case .loading:
            showLoading()
        case .render(let jokes):
            hideLoading()
            updateViews(jokes: jokes)
        case .error(let error):
            hideLoading()
            showAlertView(error: error) { [weak self] (_) in
                self?.presenter.getListJokes()
            }
            
        }
    }
}
