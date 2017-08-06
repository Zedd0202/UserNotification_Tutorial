
import UIKit
import UserNotifications

@available(iOS 10.0, *)
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Seeking permission of the user to display app notifications
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in })
            UNUserNotificationCenter.current().delegate = self
        }
        
    }
    

    @IBAction func buttonPressed(_ sender: UIButton){
        if #available(iOS 10.0, *) {
            
            //Setting content of the notification
            let content = UNMutableNotificationContent()
            content.title = "This is title : Zedd"
            content.subtitle = "This is Subtitle : UserNotifications tutorial"
            content.body = "This is Body : 블로그 글 쓰기"
            content.badge = 1
            
            //Setting time for notification trigger
            //블로그 예제에서는 TimeIntervalNotificationTrigger을 사용했지만, UNCalendarNotificationTrigger사용법도 같이 올려놓을게요!
            
            
            //1. Use UNCalendarNotificationTrigger
            let date = Date(timeIntervalSinceNow: 2)
            var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let Calendartrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
            
            
            //2. Use TimeIntervalNotificationTrigger
            let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            
            
            
            //Adding Request
            let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: TimeIntervalTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
    }
    
}
extension ViewController : UNUserNotificationCenterDelegate{
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
}
