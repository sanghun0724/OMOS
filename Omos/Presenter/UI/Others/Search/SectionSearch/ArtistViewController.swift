//
//  ArtistViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.

import RxSwift
import UIKit

class ArtistViewController: BaseViewController {
    let selfView = ArtistView()
    let viewModel: SearchViewModel
    let disposebag = DisposeBag()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        selfView.emptyView.isHidden = !(viewModel.currentArtist.isEmpty)
        selfView.emptyView.descriptionLabel.text = "검색 결과가 없습니다."
    }

    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)

        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    override func bind() {
        viewModel.artist
            .subscribe({ [weak self] _ in
                self?.selfView.emptyView.isHidden = !(self?.viewModel.currentArtist.isEmpty)!
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposebag)

        viewModel.isArtistEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner, empty in
                owner.selfView.emptyView.isHidden = !empty
            }).disposed(by: disposeBag)
    }
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentArtist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableCell.identifier, for: indexPath) as! ArtistTableCell
        let cellData = viewModel.currentArtist[indexPath.row]
        cell.configureModel(artist: cellData, keyword: viewModel.currentKeyword)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = viewModel.currentArtist[indexPath.row]
        let rp = SearchRepositoryImpl(searchAPI: SearchAPI())
        let uc = SearchUseCase(searchRepository: rp)
        let vm = SearchArtistDetailViewModel(usecase: uc)
        vm.currentKeyword = viewModel.currentKeyword
        vm.searchType = viewModel.searchType
        let vc = SearchArtistViewController(viewModel: vm, artistData: cellData)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.mainHeight * 0.094
    }
}
