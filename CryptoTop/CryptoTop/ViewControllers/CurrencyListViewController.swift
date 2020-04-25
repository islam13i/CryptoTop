//
//  TableViewController.swift
//  CryptoTop
//
//  Created by Islam on 4/22/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit

class CurencyListViewController: UITableViewController {
    let apiController = ApiController.instance
    var cryptoListTable: [ItemCrypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController.getcryptoCurrencies(completion: setCryptoList(_:) )
        
    }
    
    func setCryptoList(_ cryptoList: [ItemCrypto]?) {
        guard let list = cryptoList  else {
            return
        }
        cryptoListTable = list
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoListTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListViewCell", for: indexPath) as! CurrencyListViewCell
        let item: ItemCrypto
        item = cryptoListTable[indexPath.row]
        
        cell.setDataToLabels(item: item)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailCryptoSegue"{
            if let DetailViewController = segue.destination as? DetailViewController{
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
                    DetailViewController.itemCrypto = cryptoListTable[indexPath.row]
                }
            }
        }
    }
}

