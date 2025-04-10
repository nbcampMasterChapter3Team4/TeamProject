import Foundation

protocol DetailInfoViewDelegate: AnyObject {
    func detailInfoViewDidTapMinus(_ detailInfoView: DetailInfoView)
    func detailInfoViewDidTapPlus(_ detailInfoView: DetailInfoView)
}
