//
//  Search + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import UIKit

extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentMusic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
          let  item = viewModel.currentMusic[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.name
            return cell
        
    }
}
