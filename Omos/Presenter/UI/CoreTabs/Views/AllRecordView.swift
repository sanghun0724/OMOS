//
//  AllRecordView.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import RxSwift
import SnapKit
import UIKit

class AllRecordView: BaseView {
    let emptyView = EmptyView()
    let loadngView = LoadingView()

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(AllRecordTableCell.self, forCellReuseIdentifier: AllRecordTableCell.identifier)
        table.register(AllRecordHeaderView.self, forHeaderFooterViewReuseIdentifier: AllRecordHeaderView.identifier)
        table.backgroundColor = .mainBlack
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        // table.contentInsetAdjustmentBehavior = .never
        // table.insetsContentViewsToSafeArea = false
        return table
    }()

    // override 되었기 때문에 BaseView에서처럼 ViewdidLoad에 자동 실행
    override func configureUI() {
        self.addSubview(emptyView)
        self.addSubview(tableView)
        self.addSubview(loadngView)

        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyView.isHidden = true

        loadngView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadngView.isHidden = true

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class AllRecordHeaderView: UITableViewHeaderFooterView {
    static let identifier = "headerView"
    var disposeBag = DisposeBag()

    let label: UILabel = {
        let label = UILabel()
        label.tintColor = .mainGrey1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "인생의 OST"
        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "keyboard_arrow_left"), for: .normal)
        button.tintColor = .mainGrey1
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    func configureUI() {
        self.addSubview(label)
        self.addSubview(button)

        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().offset(-100)
        }

        button.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
