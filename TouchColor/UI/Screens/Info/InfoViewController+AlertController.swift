import UIKit

extension InfoViewController {

    func presentAlertController(withAuthor author: Author) {
        let title = "\(author.fullName) \(showProfile.localized)"
        let alert = alertControllerFactory.create(withTitle: title, message: nil, preferredStyle: .actionSheet)
        configureProfessionActionIfNeeded(author, alertController: alert)
        configureTwitterActionIfNeeded(author, alertController: alert)
        configureCancelActionIfNeeded(author, alertController: alert)
        presentAlertControllerIfNeeded(author, alertController: alert)
    }

    func openCompanyWebsite() {
        let companyUrl = URL(string: "https://www.elpassion.com")
        guard let url = companyUrl else { return }
        _ = urlOpener.open(url: url)
    }

    private func configureProfessionActionIfNeeded(_ author: Author, alertController: UIAlertController) {
        guard let professionUrl = author.professionUrl else { return }
        guard urlOpener.canOpen(url: professionUrl) else { return }
        let title = author.type == .developer ? github.localized : dribbble.localized
        let proffesionAction = openUrlAlertActionWithTitle(title, url: professionUrl)
        alertController.addAction(proffesionAction)
    }

    private func configureTwitterActionIfNeeded(_ author: Author, alertController: UIAlertController) {
        guard let twitterUrl = author.twitterUrl else { return }
        guard urlOpener.canOpen(url: twitterUrl) else { return }
        let twitterAction = openUrlAlertActionWithTitle(twitter.localized, url: twitterUrl)
        alertController.addAction(twitterAction)
    }

    private func configureCancelActionIfNeeded(_ author: Author, alertController: UIAlertController) {
        guard hasOneCorrectUrlAtLeast(author) else { return }
        let cancelAction = cancelAlertAction()
        alertController.addAction(cancelAction)
    }

    private func presentAlertControllerIfNeeded(_ author: Author, alertController: UIAlertController) {
        guard hasOneCorrectUrlAtLeast(author) else { return }
        viewControllerPresenter.present(viewController: alertController)
    }

    private func hasOneCorrectUrlAtLeast(_ author: Author) -> Bool {
        return urlOpener.canOpen(url: author.professionUrl) || urlOpener.canOpen(url: author.twitterUrl)
    }

    // MARK: Alert Actions

    private func openUrlAlertActionWithTitle(_ title: String, url: URL) -> UIAlertAction {
        return alertActionFactory.create(withTitle: title, style: .default) { [weak self] _ in
            _ = self?.urlOpener.open(url: url)
        }
    }

    private func cancelAlertAction() -> UIAlertAction {
        return alertActionFactory.create(withTitle: cancel.localized, style: .cancel, handler: nil)
    }

}
