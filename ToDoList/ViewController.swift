//
//  ViewController.swift
//  ToDoList
//
//  Created by Steven YAMBOS on 19/03/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    // Bouton ' + '
    @objc private func didTapAdd() {
        // Message d'alerte
        let alert = UIAlertController(
            title: "Nouveau fichier",
            message: "Crée ta nouvelle tâche",
            preferredStyle: .alert)
        // Champs de texte
        alert.addTextField { field in
            field.placeholder = "Commencez à écrire ici."
        }
        // Annuler
        alert.addAction(UIAlertAction(
            title: "Annuler",
            style: .cancel, handler: nil))
        // Confirmer
        alert.addAction(UIAlertAction(
            title: "Confirmer",
            style: .default, handler: {(_) in}))
        present(alert, animated: true)
        // si le champs de texte vient d'être créée...
        if let field = alert.textFields?.first {
            // ...et si le texte est remplie
            if let text = field.text, !text.isEmpty {
                print(text)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                               target: self,
                                                               action: #selector (didTapAdd))
    }
    
    override func viewDidLayoutSubviews() {
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }


}

