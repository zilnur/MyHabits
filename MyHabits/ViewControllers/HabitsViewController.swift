import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var habitsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(named: "Background")
        
        collection.register(TodayProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TodayProgressCollectionViewCell.self))
        collection.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self))
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(habitsCollection)
        navigationConfig()
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toHabitVC))
        self.navigationItem.rightBarButtonItem = barButton
        
        habitsCollection.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        habitsCollection.reloadData()
    }
    
    @objc func toHabitVC() {
        let habitVC = HabitViewController(habit: nil)
        let habitNVC = UINavigationController(rootViewController: habitVC)
        habitNVC.modalPresentationStyle = .fullScreen
        habitNVC.modalTransitionStyle = .coverVertical
        self.present(habitNVC, animated: true, completion: nil)
    }

}

extension HabitsViewController {
    func navigationConfig() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = UIColor(named: "Color")
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return HabitsStore.shared.habits.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TodayProgressCollectionViewCell.self), for: indexPath) as! TodayProgressCollectionViewCell
            return cell
         default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            cell.habitInCollection = {self.habitsCollection.reloadSections(IndexSet(integer: 0))}
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            default:
                let habitDatesVC = HabitDetailsViewController(habit: HabitsStore.shared.habits[indexPath.item])
                habitDatesVC.title = HabitsStore.shared.habits[indexPath.item].name
                navigationController?.pushViewController(habitDatesVC, animated: true)
            }
        default:
            break
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat
        width = collectionView.frame.width - 16 * 2
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 60)
        case 1:
            return CGSize(width: width, height: 130)
        default:
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: 16, bottom: 12, right: 16)
        case 1:
            return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
        default:
            return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
    }
}
