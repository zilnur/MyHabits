
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let newScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: newScene)
        window?.makeKeyAndVisible()
        
        let tabController = UITabBarController()
        tabController.tabBar.tintColor = UIColor(named: "Color")
        tabController.tabBar.backgroundColor = .white
        
        let habitsVC = HabitsViewController()
        let habitsNVC = UINavigationController(rootViewController: habitsVC)
        habitsNVC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "Shape"), tag: 0)
        habitsNVC.tabBarItem.imageInsets.top = 15
        habitsNVC.tabBarItem.imageInsets.bottom = 15
        habitsNVC.tabBarItem.imageInsets.left = 15
        habitsNVC.tabBarItem.imageInsets.right = 15
        
        let infoVC = InfoViewController()
        let infoNVC = UINavigationController(rootViewController: infoVC)
        infoNVC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle"), tag: 1)
        
        tabController.viewControllers = [habitsNVC,infoNVC]
        
        window?.rootViewController = tabController
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

