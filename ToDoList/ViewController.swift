//
//  ViewController.swift
//  ToDoList
//
//  Created by Steven YAMBOS on 19/03/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    // Composant UI qui permet d'afficher des éléments en liste
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
            style: .default, handler: { [weak self] (_) in
                // si le champs de texte vient d'être créée...
                if let field = alert.textFields?.first {
                    // ...et si le texte est remplie
                    if let text = field.text, !text.isEmpty {
                        DispatchQueue.main.async {
                            var currentItem = UserDefaults.standard.stringArray(forKey: "items") ?? []
                            currentItem.append(text)
                            UserDefaults.standard.setValue(currentItem, forKey: "items")
                            self?.items.append(text)
                            self?.table.reloadData()
                        }
                    }
                }
                
            }))
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
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
    
    // Les TableView dans iOS affichent des rangées de contenu à défilement vertical dans une seule colonne.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // le nombre de lignes correspondra aux nombre d'éléments créés
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
        
    }


}

