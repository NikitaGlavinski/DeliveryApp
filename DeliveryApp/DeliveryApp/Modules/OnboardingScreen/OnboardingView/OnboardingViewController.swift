//
//  OnboardingViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var presenter: OnboardingPresenterProtocol!
    private var cellModels = [
        OnboardingCellViewModel(
            image: UIImage(named: "delivery")!,
            title: "All your favorites",
            description: "Order from the best local restaurants with easy, on-demand delivery."
        ),
        OnboardingCellViewModel(
            image: UIImage(named: "pizza")!,
            title: "Free delivery offers",
            description: "Free delivery for new customers via Apple Pay and others payment methods."
        ),
        OnboardingCellViewModel(
            image: UIImage(named: "burger")!,
            title: "Choose your food",
            description: "Easily find your type of food craving and you'll get delivery in wide range."
        )
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CustomPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.presenter.endOnboarding()
            }
        }
    }
}

extension OnboardingViewController: OnboardingViewInput {
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Onboarding", for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(viewModel: cellModels[indexPath.item])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.frame.width
        pageControl.configureView(selectedIndex: Int(index))
    }
}
