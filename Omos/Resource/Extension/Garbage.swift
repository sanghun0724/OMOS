//
//  Garbage.swift
//  Omos
//
//  Created by sangheon on 2022/03/17.
//

//import Foundation

//UIView.animate(withDuration: 0) { [weak self] in
//    
//    guard let valid = self?.expandedIndexSet2.contains(indexPath.row) else { return }
//    if valid {
//        for i in 0..<cell.selfView.allStackView.arrangedSubviews.count {
//            if i < 2 { continue }
//             cell.selfView.allStackView.arrangedSubviews[i].isHidden = false
//        }
//        cell.readMoreButton.isHidden = true
//    } else {
//        for i in 0..<cell.selfView.allStackView.arrangedSubviews.count {
//            if i < 2 { continue }
//             cell.selfView.allStackView.arrangedSubviews[i].isHidden = true
//        }
//        cell.readMoreButton.isHidden = false
//    }
//}



//func setStackViews() {
//    for i in 0..<lyricsArr.count {
//        let labelView:BasePaddingLabel = {
//            let label = BasePaddingLabel()
//            label.text = ""
//            label.backgroundColor = .LyricsBack
//            label.numberOfLines = 0
//            return label
//        }()
//        
//        selfView.allStackView.addArrangedSubview(labelView)
//        
//        labelView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            labelView.sizeToFit()
//        }
//        if i % 2 == 0 {
//            labelView.text = lyricsArr[i]
//
//        } else {
//            if i == 1 {
//                
//                labelView.backgroundColor = .mainBlack
//                labelView.addSubview(readMoreButton)
//                
//                readMoreButton.snp.makeConstraints { make in
//                    make.bottom.equalToSuperview()
//                    make.trailing.equalToSuperview()
//                    make.width.equalTo(46)
//                    make.height.equalTo(30)
//                }
//            }
//            
//            labelView.backgroundColor = .mainBlack
//            labelView.text = lyricsArr[i]
//        
//        }
//
//    }
//}


//var lyricsArr:[String] = []
//myRecord.recordContents.enumerateSubstrings(in: myRecord.recordContents.startIndex..., options: .byParagraphs) { substring, range, _, stop in
//    if  let substring = substring,
//        !substring.isEmpty {
//        lyricsArr.append(substring)
//    }
//}
//
//for i in 0..<lyricsArr.count {
//    let labelView:BasePaddingLabel = {
//        let label = BasePaddingLabel()
//        label.text = ""
//        label.backgroundColor = .LyricsBack
//        label.numberOfLines = 0
//        return label
//    }()
//
//    selfLyricsView.allStackView.addArrangedSubview(labelView)
//
//    labelView.snp.makeConstraints { make in
//        make.width.equalToSuperview()
//        labelView.sizeToFit()
//    }
//    if i % 2 == 0 {
//        labelView.text = lyricsArr[i]
//    } else {
//        labelView.backgroundColor = .mainBlack
//        labelView.text = lyricsArr[i]
//    }
//}
//selfLyricsView.reloadInputViews()
//
//// selfLyricsView.dummyView3.isHidden = true
