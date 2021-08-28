
import UIKit

class HabitDetailsViewController: UIViewController {

    let habit: Habit
    
    let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "АКТИВНОСТЬ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let cell = "CellID"
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        addSubviewsAndConstraints()
        table.dataSource = self
        table.delegate = self
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        self.navigationItem.rightBarButtonItem = editButton

    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = habit.name
    }
    
    @objc func editHabit() {
        let habitVC = HabitViewController(habit: habit)
        habitVC.habitRemove = {self.navigationController?.popToRootViewController(animated: false)}
        let habitNavigationVC = UINavigationController(rootViewController: habitVC)
        habitNavigationVC.modalPresentationStyle = .fullScreen
        present(habitNavigationVC, animated: true, completion: nil)
    }
    
}

extension HabitDetailsViewController {
    func addSubviewsAndConstraints(){
        view.addSubview(table)
        table.addSubview(headerLabel)
        table.backgroundColor = UIColor(named: "Background")
        
        let constraints = [
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerLabel.leadingAnchor.constraint(equalTo: table.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: table.topAnchor, constant: 22)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        let date = HabitsStore.shared.dates[indexPath.row]
        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                    cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            cell.tintColor = UIColor(named: "Color")
                }
        return cell
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
}
