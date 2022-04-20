//
//  MyRecordDetail + Table .swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Foundation
import UIKit

extension MyRecordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( "cell count \(lyricsArr.count)")
        return lyricsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("index\(indexPath.row)")
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LyriscTableCell.identifier, for: indexPath) as! LyriscTableCell
            if indexPath.row == 0 {
                cell.label.text = lyricsArr[0]
            } else {
                cell.label.text = lyricsArr[safe:indexPath.row / 2] ?? " "
            }
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableCell.identifier, for: indexPath) as! TextTableCell
            cell.textView.text = lyricsArr[safe:indexPath.row] ?? " "
            cell.selectionStyle = .none
            cell.textView.isUserInteractionEnabled = false
            cell.textView.textColor = .white
            cell.layoutIfNeeded()
            print(lyricsArr[safe:indexPath.row] ?? " ")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}
