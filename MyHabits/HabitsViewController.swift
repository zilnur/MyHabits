import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var habitsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toHabitVC))
        self.navigationItem.rightBarButtonItem = barButton
        
        
    }
    
    @objc func toHabitVC() {
        let habitVC = HabitViewController()
        let habitNVC = UINavigationController(rootViewController: habitVC)
        habitNVC.modalPresentationStyle = .fullScreen
        habitNVC.modalTransitionStyle = .coverVertical
        self.present(habitNVC, animated: true, completion: nil)
    }
}

//extension HabitsViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
//
//extension HabitsViewController: UICollectionViewDelegateFlowLayout {
//
//}
