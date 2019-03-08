//
//  AppDelegate.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//


//
//  AppDelegate.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//


import UIKit
import CoreData
import Firebase
import UserNotifications
import FirebaseAuth
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    var glocation:String = ""
    var gfrom:String = ""
    var gto:String = ""
    var gsender:String = ""
    var grectoken:String = ""
    var gimurl:String = ""
    
    
    //   https://forums.developer.apple.com/message/289321#289321
    
    
    var restrict: UIInterfaceOrientationMask = .portrait
    
    
    
    
    
    /*------------------------------------------------ DID FINISH LAUNCHING ------------------------------------------------------*/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // never do it here
        //   UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        
        // let option = launchOptions?[.remoteNotification] // react in notification when running
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        //  UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: (_, ?) -> Void)
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (_, _) in
        }
        
        application.registerForRemoteNotifications()
        
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let con = Connection()
        let really = con.isConnected()
        print("Connection active \(really)")
        
        
        let loggedout = UserDefaults.standard.string(forKey: "isout") ?? "nil"
        let user = Auth.auth().currentUser
        
        if user != nil && (loggedout == "nil" || loggedout == "NO") {
            
            
            let ref = Database.database().reference(fromURL: "https://sportify-a6150.firebaseio.com")
            
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    let t = TabController()
                    self.window?.rootViewController = t
                    self.window?.makeKeyAndVisible()
                }
            }
            
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LogController())
            window?.makeKeyAndVisible()
        }
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, err) in
            if err != nil {
                print("Mistake \(String(describing: err))")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
        
        
        return true
    }
    
    
    
    // TRY https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623013-application
    
    /*---------2--------------------------------------- DID RECEIVE RESPONSE ------------------------------------------------------*/
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // CALLED ON TAP
        //  UserDefaults.standard.set("OP", forKey: "highlight")
        
        
        let data = response.notification.request.content.userInfo
        
        let uid:String = (Auth.auth().currentUser?.uid)!
        
        let to = data["gcm.notification.to"]!
        let rectoken = data["gcm.notification.rectoken"]!
        let from = data["gcm.notification.from"]!
        let location = data["gcm.notification.location"]!
        let imurl = data["gcm.notification.imageurl"]!
        let sender = data["gcm.notification.sname"]!
        let receiver = data["gcm.notification.rname"]!
        let sendertoken = data["gcm.notification.sendertoken"]!
        
        // GET MY NAME HERE AND USE IT IF I OPEN FROM NOTIF !!!!
        
        let vc = ChatController()
        vc.location = "\(location)"
        vc.from = "\(to)" // to and from are switched when from notifiation
        vc.toid = "\(from)"
        
        vc.Sname = "\(receiver)" // is Filip but should be "Filippo"
        vc.Rname = "\(sender)" // FIX THIS !!!
        vc.rectoken = "\(rectoken)"
        vc.sendertoken = "\(sendertoken)"
        
        print("APPDEL    SNAMEEEEE \(receiver)   RNAMEEEEE \(sender)")
        vc.imurl = "\(imurl)"
        vc.fromnotif = true
        vc.Mnotifurl = "\(imurl)"
        
        vc.backtext = "Matches"
        vc.allowd = true
        print("IMGU \(imurl)")
        
        window?.rootViewController = vc
        
        completionHandler()
        
    }
    
    
    //  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    // DEPRECATED
    
    
    
    
    
    /*---------3--------------------------------------- WILL PRESENT ------------------------------------------------------*/
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let ud = UserDefaults.standard.value(forKey: "isinchat") as! Bool
        
        
        UserDefaults.standard.set("OP", forKey: "highlight")
        
        print("174 RECE!")
        
        if ud == true {
            completionHandler([])
        } else {
            completionHandler([.alert, .sound])
        }
        
    }
    
    /*  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     
     UserDefaults.standard.set("OP", forKey: "highlight")
     print("I AM RECEIVED IN BACKGROUND")
     
     }*/
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("FINALLLYYYYYYYYYYYY")
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Sportify")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    /*---------4--------------------------------------- WILL ENTER FOREGROUND ------------------------------------------------------*/
    func applicationWillEnterForeground(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        
       // UIApplication.shared.applicationIconBadgeNumber = 0
        
        window?.rootViewController?.dismiss(animated: false, completion: nil) // clear VC Stack
        
        let con = Connection()
        let really = con.isConnected()
        print("Connection active \(really)")
        
        
        let loggedout = UserDefaults.standard.string(forKey: "isout") ?? "nil"
        
        let show = UserDefaults.standard.string(forKey: "leftat") ?? "nil"
        
        
        let user = Auth.auth().currentUser
        
        
        //  print("Logged out is \(loggedout) user is \(user)")
        if (loggedout == "nil" || loggedout == "YES") && really {
            window?.rootViewController = UINavigationController(rootViewController: LogController())
            window?.makeKeyAndVisible()
        } else {
            
            let tab = UITabBarController()
            let match = GroupController()
            match.tabBarItem = UITabBarItem(title: "Races", image: UIImage(named: "refresh.png"), tag: 0)
            
            let profile = EditController()
            profile.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "stpwa.png"), tag: 2)
            
            let all = AllController()
            all.tabBarItem = UITabBarItem(title: "Competitors", image: UIImage(named: "list-icon.png"), tag: 3)
            
            let messages = MessageController()
            messages.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "envelope.png"), tag: 4)
            
            
            
            /* let qa = QAController()
             qa.tabBarItem = UITabBarItem(title: "Q & A", image: UIImage(named: "rss-7.png"), tag: 3) */
            
            let list = [match, all, messages, profile]
            tab.viewControllers = list
            
            if show == "edit" {
                tab.selectedIndex = 2
                window?.rootViewController = tab
                window?.makeKeyAndVisible()
            } else if show == "all" {
                tab.selectedIndex = 1
                window?.rootViewController = tab
                window?.makeKeyAndVisible()
            } else if show == "group" {
                tab.selectedIndex = 0
                window?.rootViewController = tab
                window?.makeKeyAndVisible()
                
            } else if show == "match" {
                let fetcher = StateFetcher(ename: "ChatState", key: "chatstate")
                let res = fetcher.fetchR()
                let latest = res[res.count - 1]
                
                let mc = MatchControllersqs()
                mc.location = latest.location
                mc.viewWillAppear(true)
                mc.email = latest.psmail
                mc.psswim = latest.psswim
                mc.psrun = latest.psrrun
                
                window?.rootViewController = mc
                window?.makeKeyAndVisible()
            } else if show == "messages"{
                tab.selectedIndex = 3
                window?.rootViewController = tab
                window?.makeKeyAndVisible()
            }
            
            
            else if show == "chat" {
                
                /*
                 let f = CHStateFetcher(ename: "RChatState", key: "rChatState")
                 let res = f.fetchR()
                 let latest = res[res.count - 1]
                 
                 let vc = JhatController()
                 vc.name = latest.name
                 vc.location = latest.location
                 vc.from = latest.from
                 vc.toid = latest.toid
                 vc.imurl = latest.imurl
                 vc.allowd = latest.allowd
                 vc.Mnotifurl = latest.mnotifyurl
                 vc.Rname = latest.mnotifyname
                 vc.sender = latest.sender
                 vc.sendertoken = latest.sendertoken
                 vc.rectoken = latest.rectoken
                 vc.backtext = "Matches"
                 */
                /*window?.rootViewController = vc
                 window?.makeKeyAndVisible()*/
            }
            
            
            
            print("NOW SHOW CHAT")
        }
    }
    
    
}




func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    let token: [String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken! as AnyObject]
    
    let db = Database.database().reference()
    db.child("fcmAuth").child(Messaging.messaging().fcmToken!).setValue(token)
}












extension AppDelegate{
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        
        
        
    }
}



//
//  Result.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase





class MatchData: NSObject, NSCoding {
    // location, email, psswim, psrun
   
    struct Keys {
        static let location = "location"
        static let psmail = "email"
        static let psswim = "swim"
        static let psrun = "run"
    }
    
    
    
    private var _location: String = ""
    
    private var _psmail: String = ""
    
    private var _psswim: String = ""
    
    private var _psrun: String = ""
    
    
    
    override init() {}
    
    init(email: String, location: String, run: String, swim: String){
        self._psmail = email
        self._location = location
        self._psrun = run
        self._psswim = swim
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(_psmail, forKey: Keys.psmail)
      aCoder.encode(_location, forKey: Keys.location)
      aCoder.encode(_psrun, forKey: Keys.psrun)
      aCoder.encode(_psswim, forKey: Keys.psswim)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        if let mailobj = aDecoder.decodeObject(forKey: Keys.psmail) as? String {
            _psmail = mailobj
        }
        
        if let locobj = aDecoder.decodeObject(forKey: Keys.location) as? String {
            _location = locobj
        }
        
        if let psrobj = aDecoder.decodeObject(forKey: Keys.psrun) as? String {
            _psrun = psrobj
        }
        
        if let pssobj = aDecoder.decodeObject(forKey: Keys.psswim) as? String {
            _psswim = pssobj
        }
        
        
      
    }
    
    var psmail: String{
        get {
            return _psmail
        }
        
        set {
            _psmail = newValue
        }
    }
    
    
    var psrrun: String{
        get {
            return _psrun
        }
        
        set {
            _psrun = newValue
        }
    }
    
    var psswim: String{
        get {
            return _psswim
        }
        
        set {
            _psswim = newValue
        }
    }
    
    
    var location: String{
        get {
            return _location
        }
        
        set {
            _location = newValue
        }
    }

}







class ChatData: NSObject, NSCoding {
    // location, email, psswim, psrun
    
    struct Keys {
        static let name = "name"
        static let location = "location"
        static let from = "from"
        static let toid = "toid"
        static let imurl = "imurl"
        static let allowd = "allowd"
        static let mnotifyurl = "mnotifyurl"
        static let mnotifyname = "mnotifyname"
        static let sender = "sender"
        static let sendertoken = "sendertoken"
        static let rectoken = "rectoken"
        // do backtext manually !!
    }
    
    
      private var _name: String = ""
      private var _location: String = ""
      private var _from: String = ""
      private var _toid: String = ""
      private var _imurl: String = ""
      private var _allowd: Bool = false
      private var _mnotifyurl: String = ""
      private var _mnotifyname: String = ""
      private var _sender: String = ""
      private var _sendertoken: String = ""
      private var _rectoken: String = ""
    

    
    
    
    override init() {}
    
    init(name: String, location: String, from: String, toid: String, imurl: String, allowd: Bool, mnotifyurl: String, mnotifyname: String, sender: String, sendertoken: String, rectoken: String){
        self._name = name
        self._location = location
        self._from = from
        self._toid = toid
        self._imurl = imurl // ef
        self._allowd = allowd
        self._mnotifyurl = mnotifyurl
        self._mnotifyname = mnotifyname
        self._sender = sender
        self._sendertoken = sendertoken
        self._rectoken = rectoken
        
       
    }
    
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(_name, forKey: Keys.name)
        aCoder.encode(_location, forKey: Keys.location)
        aCoder.encode(_from, forKey: Keys.from)
        aCoder.encode(_toid, forKey: Keys.toid)
        aCoder.encode(_imurl, forKey: Keys.imurl)
        aCoder.encode(_allowd, forKey: Keys.allowd)
        aCoder.encode(_mnotifyurl, forKey: Keys.mnotifyurl)
        aCoder.encode(_mnotifyname, forKey: Keys.mnotifyname)
        aCoder.encode(_sender, forKey: Keys.sender)
        aCoder.encode(_sendertoken, forKey: Keys.sendertoken)
        aCoder.encode(_rectoken, forKey: Keys.rectoken)
    }
    
    
    
  
    
    
    required init?(coder aDecoder: NSCoder) {
        
        
        if let nameobj = aDecoder.decodeObject(forKey: Keys.name) as? String {
            _name = nameobj
        }
        
        if let locobj = aDecoder.decodeObject(forKey: Keys.location) as? String {
            _location = locobj
        }
        
        if let fromobj = aDecoder.decodeObject(forKey: Keys.from) as? String {
            _from = fromobj
        }
        
        if let toobj = aDecoder.decodeObject(forKey: Keys.toid) as? String {
            _toid = toobj
        }
        
        if let imurl = aDecoder.decodeObject(forKey: Keys.imurl) as? String {
            _imurl = imurl
        }
        /*
        if let allowdobj = aDecoder.decodeObject(forKey: Keys.allowd) as? String {
            _allowd = allowdobj
        }*/
        
        if let allowedobj = aDecoder.decodeBool(forKey: Keys.allowd) as? Bool {
            _allowd = allowedobj
        }
        
        if let mnurlobj = aDecoder.decodeObject(forKey: Keys.mnotifyurl) as? String {
            _mnotifyurl = mnurlobj
        }
        
        if let mnname = aDecoder.decodeObject(forKey: Keys.mnotifyname) as? String {
            _mnotifyname = mnname
        }
        
        if let senderobj = aDecoder.decodeObject(forKey: Keys.sender) as? String {
            _sender = senderobj
        }
        
        
        if let tokenobj = aDecoder.decodeObject(forKey: Keys.sendertoken) as? String {
            _sendertoken = tokenobj
        }
        
        if let recobj = aDecoder.decodeObject(forKey: Keys.rectoken) as? String {
            _rectoken = recobj
        }
        
        
        
        
        
        
        
        
        
        
        
      
        
        
        
        
        
    }
    
    
    
    var name: String{
        get {
            return _name
        }
        
        set {
            _name = newValue
        }
    }
    
    
    var location: String{
        get {
            return _location
        }
        
        set {
            _location = newValue
        }
    }
    
    var from: String{
        get {
            return _from
        }
        
        set {
            _from = newValue
        }
    }
    
    var toid: String{
        get {
            return _toid
        }
        
        set {
            _toid = newValue
        }
    }
    
    var imurl: String{
        get {
            return _imurl
        }
        
        set {
            _imurl = newValue
        }
    }
    
    
    var allowd: Bool{
        get {
            return _allowd
        }
        
        set {
            _allowd = newValue
        }
    }
    
    
    var mnotifyurl: String{
        get {
            return _mnotifyurl
        }
        
        set {
            _mnotifyurl = newValue
        }
    }
    
    
    var mnotifyname: String{
        get {
            return _mnotifyname
        }
        
        set {
            _mnotifyname = newValue
        }
    }
    
    var sender: String{
        get {
            return _sender
        }
        
        set {
            _sender = newValue
        }
    }
    
    
    var sendertoken: String{
        get {
            return _sendertoken
        }
        
        set {
            _sendertoken = newValue
        }
    }
    
    
    var rectoken: String{
        get {
            return _rectoken
        }
        
        set {
            _rectoken = newValue
        }
    }










    
   
    
    
    
}




























class Result {
    var name: String
    var location: String
    var time1: Int
    var time2: Int?
    
    init(name: String, location: String, time1:Int){
        self.name = name
        self.location = location
        self.time1 = time1
    }
}


enum Sport:String {
case running
case cycling
case swimming
}


class User {
    var name:String
    var location:String
  //  var distance: Int
    var run: String
    var swim: String
    var uid: String
    var experience: String
    // get sort sortby
    var sortby: Double
    var gender: String
    var image: UIImage
    var imurl: String
    var rectoken: String
    var country: String
    var showNick: String
    
    init(name: String, location:String,/* distance: Int,*/ run:String, swim: String, uid:String, experience: String, gender: String, sortby: Double, image: UIImage, imurl:String, rectoken: String, country: String, showNick:String){
        self.name = name
        self.location = location
     //   self.distance = distance
        self.run = run
        self.swim = swim
        self.uid = uid
        self.experience = experience
        self.gender = gender
        self.sortby = sortby
        self.image = image
        self.imurl = imurl
        self.rectoken = rectoken
        self.country = country
        self.showNick = showNick
    }
}




/*
class User: NSObject, NSCoding {
    
    struct Keys {
        static let nickname = "nickname"
        static let location = "location"
        static let distance = "distance"
        static let run = "run"
        static let swim = "swim"
        static let uid = "uid"
      //  static let experience = "experience"
    }
    
   private var _nickname = ""
   private var _location = ""
   private var _distance = 0
   private var _run = ""
   private var _swim = "" // enums cant be encoded
   private var _uid = ""
    
    override init() {}
    
    
    init(nickname: String, location:String, distance: Int, run:String, swim: String, uid:String){
        self._nickname = nickname
        self._location = location
        self._distance = distance
        self._run = run
        self._swim = swim
        self._uid = uid
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        if let no = aDecoder.decodeObject(forKey: Keys.nickname) as? String {
            _nickname = no
        }
        
        if let loc = aDecoder.decodeObject(forKey: Keys.location) as? String {
            _location = loc
        }
        
        if let ds = aDecoder.decodeInteger(forKey: Keys.distance) as? Int {
            _distance = ds
        }
        
        if let run = aDecoder.decodeInteger(forKey: Keys.run) as? String {
            _run = run
        }
        
        if let sp = aDecoder.decodeObject(forKey: Keys.swim) as? String {
            _swim = sp
        }
        
        
        if let uid = aDecoder.decodeObject(forKey: Keys.uid) as? String {
            _uid = uid
        }
        
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_nickname, forKey: Keys.nickname)
        aCoder.encode(_location, forKey: Keys.location)
        aCoder.encode(_distance, forKey: Keys.distance)
        aCoder.encode(_run, forKey: Keys.run)
        aCoder.encode(_swim, forKey: Keys.swim)
        aCoder.encode(_uid, forKey: Keys.uid)
    }
    
    var nickname:String {
        get {
         return _nickname
        }
        
        set {
            _nickname = newValue
        }
    }
    
    
    var location:String {
        get {
            return _location
        }
        
        set {
            _location = newValue
        }
    }
    
    var distance:Int {
        get {
            return _distance
        }
        
        set {
            _distance = newValue
        }
    }
    
    
    var swim:String {
        get {
            return _swim
        }
        
        set {
            _swim = newValue
        }
    }
    
    
    
    var run:String {
        get {
            return _run
        }
        
        set {
            _run = newValue
        }
    }
    
    
    var uid:String {
        get {
            return _uid
        }
        
        set {
            _uid = newValue
        }
    }
    
    
    
   
}
*/

struct MS{
    var from:String
    var to:String
    var m:String
    var color:String
}

struct Race {
    var title: String
    var location: String
    var url:String
    var year: String
    
    init(title:String, location:String, url:String, year: String){
        self.title = title
        self.location = location
        self.url = url
        self.year = year
    }
}

class Identifier: NSObject, NSCoding {
    
    struct Keys {
        static let name = "name"
        static let uid = "uid"
    }
    
    private var _name: String = ""
    
    private var _uid: String = ""
    
    
    override init() {}
    
    init(name: String, uid: String){
        self._name = name
        self._uid = uid
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: Keys.name)
        aCoder.encode(_uid, forKey: Keys.uid)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        if let nameobj = aDecoder.decodeObject(forKey: Keys.name) as? String {
            _name = nameobj
        }
        
        if let uidobj = aDecoder.decodeObject(forKey: Keys.uid) as? String {
            _uid = uidobj
        }
        
        
    }
    
    var name: String{
        get {
            return _name
        }
        
        set {
            _name = newValue
        }
    }
    
    var uid: String{
        get {
            return _uid
        }
        
        set {
            _uid = newValue
        }
    }
    
}


//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class Blocker {
   
    func block(blocked: String) { // single user email string expected
      //  let us = Auth.auth().currentUser
        let ref = Database.database().reference()
        
        let uid:String = (Auth.auth().currentUser?.uid)!
        
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                    var email = v?["email"] as? String ?? "not found"
                    
                    var stimea = v?["stime"] as? String ?? "not found"
                    var rtimea = v?["rtime"] as? String ?? "not found"
                    var ct = v?["count"] as? String ?? "not found"
                    var  nick = v?["nickname"] as? String ?? "not found"
                    let pswd = v?["password"] as? String ?? "not found"
                    
                    var str = v?["race"] as? String ?? "not found"
                    
                  //  var fstr = v?["filter"] as? String ?? "not found"
                    
                    
                    
                    
                    let path = v?["url"] as? String ?? "not found"
                    
                    var blocko = v?["blocked"] as? String ?? ""
                    
                  
                    blocko.append("\(blocked)-")
                    
                    
                        
                      
                        
          
               
                
                    
                    
                    
                    let data : [String:Any] = ["nickname": nick,
                                               "email": email,
                                               "password": pswd,
                                               "rtime":rtimea,
                                               "stime":stimea,
                                               "race": str,
                                               "count": ct,
                                               "ids": str,
                                              // "filter":fstr,
                                               "url": path,
                                               "blocked": blocko
                        /*,
                         "gender": gender*/]
                    
                    ref.child("Users").child(uid).setValue(data)
                }
            }
        }
    }
}



//
//  JSONFetcher.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import SystemConfiguration







class Logger {
    var email:String
    var password: String
    var pres:UIViewController
    var on:UIViewController
    
    init(email:String, password: String, pres: UIViewController, on:UIViewController){
        self.email = email
        self.password = password
        self.pres = pres
        self.on = on
    }
    
    
    func logina() {
        // Must be a non-empty string and not contain '.' '#' '$' '[' or ']''
        
        let ref = Database.database().reference()
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (user, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    print("CHECK YOUR EMAIL AND PASSWORD YOU FUCKERS WHO DO YOU THINK YOU ARE ?!")
                } else {
                    self.on.present(self.pres, animated: true, completion: nil) // autologin
                }
            }
            // CHECK IF USER EXISTS
            
            
            
            let tocore = CDUser(email: self.email, password: self.password)
            let s = Saver(ename: "Users", key: "users", obj: tocore)
            s.save()
        }
    }
    
    
    
}


class Question {
    var value: String
    init(value: String){
        self.value = value
    }
    
    func send(ms:String) {
        let ref = Database.database().reference()
        let dict = ["q": ms]
        ref.child("Questions").childByAutoId().updateChildValues(dict)
    }
}



class Finder { // remove race after finding an item
    var slocation: String // self.location
    init(slocation: String){
        self.slocation = slocation
    }
    
    
    func removeMatched() {
        // count and filter disappears after update, why ?????
        
        let uid = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference()
        ref.child("Users").observe(.value) { (snap) in
            
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                    let str = v?["race"] as? String ?? "not found"
                    let arr = str.split(separator: "-")
                    
                    
                    let ra = arr.filter {$0 != self.slocation}
                    let email = v?["email"] as? String ?? "not found"
                    let pswd = v?["password"] as? String ?? "not found"
                    let rtime = v?["rtime"] as? String ?? "not found"
                    let stime = v?["stime"] as? String ?? "not found"
                   // let filter = v?["filter"] as? String ?? "not found"
                    let count = v?["count"] as? String ?? "not found"
                    let nick = v?["nickname"] as? String ?? "not found"
                    
                    
                    var rs = ""
                    for val in ra{
                        rs.append("\(val)-") // or just val
                    }
                    
                    let data = [
                        "nickname": nick,
                        "email": email,
                        "password": pswd,
                        "rtime":rtime,
                        "stime":stime,
                        "race": rs,
                        "count": count,
                        "ids": str,
                       // "filter": filter
                    ]
                    
                    ref.child("Users").child(uid!).setValue(data)
                }
            }
            
        }
    }
    
}





class NewFinder { // remove race after finding an item
    var sarr:[String] // self.location
    init(sarr: [String]){
        self.sarr = sarr
    }
    
    
    func saveCurrent() {
        // count and filter disappears after update, why ?????
        
        let uid = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference()
        ref.child("Users").observe(.value) { (snap) in
            
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                    let str = v?["race"] as? String ?? "not found"
                    // let arr = str.split(separator: "-")
                    
                    
                    // let ra = arr.filter {$0 != self.slocation}
                    // let ra = self.sarr.split(separator: "-")
                    let email = v?["email"] as? String ?? "not found"
                    let pswd = v?["password"] as? String ?? "not found"
                    let rtime = v?["rtime"] as? String ?? "not found"
                    let stime = v?["stime"] as? String ?? "not found"
                   // let filter = v?["filter"] as? String ?? "not found"
                    let count = v?["count"] as? String ?? "not found"
                    let nick = v?["nickname"] as? String ?? "not found"
                    
                    let country = v?["country"] as? String ?? "not found"
                    let gender = v?["gender"] as? String ?? "not found"
                    
                    var rs = ""
                    for val in self.sarr {
                        rs.append("\(val)-") // or just val
                    }
                    
                    let data = [
                        "nickname": nick,
                        "email": email,
                        "password": pswd,
                        "rtime":rtime,
                        "stime":stime,
                        "race": rs,
                        "count": count,
                        "ids": str,
                        "country": country,
                        "gender": gender
                      //  "filter": filter
                    ]
                    
                    ref.child("Users").child(uid!).setValue(data)
                }
            }
            
        }
    }
    
}



class Resizer{
    var image: UIImage
    var to:CGSize
    init(image: UIImage, to: CGSize){
        self.image = image
        self.to = to
    }
    /*
     func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
     let size = image.size
     
     let widthRatio  = targetSize.width  / size.width
     let heightRatio = targetSize.height / size.height
     
     // Figure out what our orientation is, and use that to form the rectangle
     var newSize: CGSize
     if(widthRatio > heightRatio) {
     newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
     } else {
     newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
     }
     
     // This is the rect that we've calculated out and this is what is actually used below
     let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
     
     // Actually do the resizing to the rect using the ImageContext stuff
     UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
     image.draw(in: rect)
     let newImage = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     
     return newImage!
     }
     */
    func resize() -> UIImage {
        let size = image.size
        
        let wratio = to.width / size.width
        let hratio = to.height / size.height
        
        var new: CGSize
        if (wratio > hratio){
            new = CGSize(width: size.width * hratio, height: size.height * hratio)
        } else {
            new = CGSize(width: size.width * wratio, height: size.height * wratio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: new.width, height: new.height)
        
        UIGraphicsBeginImageContextWithOptions(new, false, 1.0)
        image.draw(in: rect)
        let res = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return res!
    }
}


class Updater {
    var value:String
    
    init(value:String){
        self.value = value
    }
    
    func update(nickname: String, stime: String, rtime: String, new: [String], filter: [String], count: String, selected: UIImage?){
        let usrl = "gs://sportify-a6150.appspot.com"
        
        
        // print("CRAZYUPDATE")
        let us = Auth.auth().currentUser
        let ref = Database.database().reference()
        
        let uid:String = (Auth.auth().currentUser?.uid)!
        // ref.child("Users").observe(.value) { (snap) in
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            
            
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                    
                 /*   var emaila = ""
                    if email.count > 0 {
                        emaila = email
                        
                        us?.updateEmail(to: emaila, completion: { (error) in
                            if error != nil {
                                print(error!.localizedDescription)
                            } else {
                                print("Changed to \(email)")
                            }
                        })
                        
                    } else {
                        emaila = v?["email"] as? String ?? "not found"
                    }*/
                    
                   var emaila = v?["email"] as? String ?? "not found"
                    
                    var stimea = ""
                    if stime.count > 1 {
                        stimea = stime
                    } else {
                        stimea = v?["stime"] as? String ?? "not found"
                    }
                    
                    var rtimea = ""
                    if rtime.count > 1 {
                        rtimea = rtime
                    } else {
                        rtimea = v?["rtime"] as? String ?? "not found"
                    }
                    
                    
                    var ct = ""
                    // let r = Int(count)!
                    
                    if count != "" {
                        ct = count
                    } else {
                        ct = v?["count"] as? String ?? "not found"
                    }
                    
                    
                    var nick = ""
                    if nickname != ""{
                        nick = nickname
                    } else {
                        nick = v?["nickname"] as? String ?? "not found"
                    }
                    
                    let pswd = v?["password"] as? String ?? "not found"
                    //  let r = v?["race"] as? String ?? "not found"
                    
                    
                    
                    var str = ""
                    
                    if new.count > 0 {
                        for val in new {
                            str.append("\(val)-")
                        }
                    } else {
                        // value from database
                        str = v?["race"] as? String ?? "not found"
                    }
                    
                    // the same
                    /*
                    var fstr = ""
                    if filter.count > 0 {
                        for val in filter {
                            fstr.append("\(val)-")
                        }
                    } else {
                        fstr = v?["filter"] as? String ?? "not found"
                    }*/
                    
                    
                    
                    let token = v?["token"] as? String ?? "not found" // this is why notification continue to receive :D
                    
                    
                    let storage = Storage.storage().reference(forURL: usrl).child("pimage").child(uid)
                    
                    
                    
                    var datas:Data?
                    if selected == nil {
                        // datas = UIImage(named: "ocean.jpg")?.pngData() // NOT THE DEFAULT IMAGE, BUT CURRENT
                    } else {
                        
                       
                        
                        let r = Resizer(image: selected!, to: CGSize(width: 300, height: 300))
                        var e = r.resize()
                        
                        
                        
                        // datas = selected!.pngData()
                        datas = e.pngData()
                    }
                    
                    print("datas  \(selected)")
                    
                    
                    
                    if datas != nil {
                        
                        
                        
                        storage.putData(datas!, metadata: nil, completion: { (meta, err) in
                            
                           
                            if err != nil {
                               
                            } else {
                                storage.downloadURL(completion: { (url, err) in
                                    if err != nil {
                                       
                                    } else {
                                        let path = url!.absoluteString
                                        // print("I HAVE A PATH \(path)")
                                        print("What is happening ???? \(rtimea)")
                                        
                                        
                                        let country = v?["country"] as? String ?? "not found"
                                        let gender = v?["gender"] as? String ?? "not found"
                                        
                                        let data : [String:Any] = ["nickname": nick,
                                                                   "email": emaila,
                                                                   "password": pswd,
                                                                   "rtime":rtimea,
                                                                   "stime":stimea,
                                                                   "race": str,
                                                                   "count": ct,
                                                                   "ids": str,
                                                                   "country": country,
                                                                   "gender": gender,
                                                                 //  "filter":fstr,
                                                                   "url": path,
                                                                   "token": token]
                                        // ADD GENDER
                                        
                                        ref.child("Users").child(uid).setValue(data)
                                        
                                        // UserDefaults.standard.set("NO", forKey: "isout")
                                        // self.present(TabController(), animated: true, completion: nil)
                                        
                                    }
                                })
                            }
                        })
                        
                        
                    } else {
                        
                        let path = v?["url"] as? String ?? "not found"
                        let country = v?["country"] as? String ?? "not found"
                        let gender = v?["gender"] as? String ?? "not found"
                        
                        
                        let data : [String:Any] = ["nickname": nick,
                                                   "email": emaila,
                                                   "password": pswd,
                                                   "rtime":rtimea,
                                                   "stime":stimea,
                                                   "race": str,
                                                   "count": ct,
                                                   "ids": str,
                                                  // "filter":fstr,
                                                   "country": country,
                                                   "gender": gender,
                                                   "url": path,
                                                   "token": token/*,
                             "gender": gender*/]
                        
                        ref.child("Users").child(uid).setValue(data)
                    }
                    
                    
                    
                    
                    
                  
                    let cu = CDUser(email: emaila, password: pswd)
                    let s = Saver(ename: "Users", key: "users", obj: cu)
                    s.save()
                }
                
            }
        }
        
    }
}



class Poster {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    func post(to: String, rname: String, sname:String, message: String, location: String, imageurl: String, rectoken:String, sendertoken: String){
        
        let ref = Database.database().reference()
        
        let a = Auth.auth().currentUser?.uid
        // let time:NSNumber = NSNumber(integerLiteral: Int(NSDate().timeIntervalSince1970))
     
        
        let data: [String: Any] = [
            "body": message,
            "from": String(a!),
            "to": String(to),
            "location": String(location),
            "imageurl": String(imageurl),
            "sname": String(sname),
            "rname": String(rname),
            "rectoken": String(rectoken),
            "sendertoken": String(sendertoken)
        ]
        
        
        
        /*  print("BODY \(message)")
         print("FROM \(a!)")
         print("TO \(to)")
         
         print("LOCATION \(location)")
         print("IMGURL \(imageurl)") // is empty and causes a bug !!!
         print("SENDER \(sender)")
         print("RECTOKEN \(rectoken)")
         */
        
        // NON EMPTY STRING!!!!
        
        if message != "" && a! != "" && to != "" && location != "" && imageurl != "" && sname != "" && rectoken != "" && rname != "" {
            ref.child(self.name).childByAutoId().updateChildValues(data)
        } else {
            
            
            
            
            
            
        }
        
        
        
        // Group message by user
        // https://www.youtube.com/watch?time_continue=1154&v=fyqksNlC8ks
    }
}



class FetchAll {
    var name: String
    var nofetch: String
    var blocked: String
    
    init(name: String, nofetch: String, blocked: String){
        self.name = name
        self.nofetch = nofetch
        self.blocked = blocked
    }
    
    func observe(completion: @escaping([String]) -> Void) {
        let ref = Database.database().reference()
        var temp = [String]()
        
        //  ref.child(name).queryOrderedByKey().observe(.value) { (snap) in
        ref.child(name).queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            
            
            var test = 100
            for s in snap.children {
                var ew = [String]()
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                let name = v?["email"] as? String ?? "not found"
                let swimtime = v?["stime"] as? String ?? "not found"
                let runtime = v?["rtime"] as? String ?? "not found"
                let locationa = v?["race"] as? String ?? "not found" // PROBLEM HERE :D Delete users (new)
                let count = v?["count"] as? String ?? "N/A"
                
                let arr = locationa.split(separator: "-")
                var allow = false
                
                test -= 1
                
                
                
                // let blocked = v?["blocked"] as? String ?? "not found blocked"
                
                var isBlocked = false
                
                //  let blocked = v?["blocked"] as? String ?? "not set"
                let marr = self.blocked.split(separator: "-")
                
                //   print("BLOCKED \(blocked) marr \(marr) name.dropFirst(0) \(name.dropFirst(0))")
                
                if marr.contains(name.dropFirst(0)){
                    print("FetchAll observe: I got him !!!! \(name.dropFirst(0))")
                    isBlocked = true
                }
                
                
                if name != self.nofetch && (isBlocked == false) {
                    for var e in arr {
                        temp.append(String(e))
                    }
                }
                
                
                
                
                
                // let obj = K
                //  UserDefaults.standard.set(dict, forKey: "names")
                
                
                
                
                //   }
                
                
            }
            completion(temp)
            
        }
        
    }
}

// name, , locations
class Observer {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    // 1 - pass self run and self swim here
    // 2 - convert it to seconds
    // 3 - get efficiency property
    // 4 - sort by efficiency using custom class in mach controller
    func observe(blocked: String, selfloc: String, selfmail: String, selfrun: Int, selfswim: Int, download: Bool, completion: @escaping([User]) -> Void) {
        let ref = Database.database().reference()
        var temp = [User]()
        //  ref.child(name).queryOrderedByKey().observe(.value) { (snap) in
        ref.child(name).queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            
            
            var test = 100
            for s in snap.children {
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                let name = v?["email"] as? String ?? "not found"
                let shownick = v?["nickname"] as? String ?? "not found"
                let swimtime = v?["stime"] as? String ?? "not found"
                let runtime = v?["rtime"] as? String ?? "not found"
                let locationa = v?["race"] as? String ?? "not found" // PROBLEM HERE :D Delete users (new)
                let count = v?["count"] as? String ?? "N/A"
                
                let url = v?["url"] as? String ?? "x"
                let rectoken = v?["token"] as? String ?? "x"
                
                // print("URL was \(url)")
                //  var blocko = v?["blocked"] as? String ?? ""
                
                print("Passed blocked is \(blocked)")
                
                
                var isBlocked = false
                
                //  let blocked = v?["blocked"] as? String ?? "not set"
                let marr = blocked.split(separator: "-")
                
                //   print("BLOCKED \(blocked) marr \(marr) name.dropFirst(0) \(name.dropFirst(0))")
                
                if marr.contains(name.dropFirst(0)){
                    print("I got him !!!! \(name.dropFirst(0))")
                    isBlocked = true
                }
                
                
                /*
                 
                 */
                
                
                let gender = v?["gender"] as? String ?? "nog"
                let country = v?["country"] as? String ?? "noc"
                
                let arr = locationa.split(separator: "-")
                var allow = false
                let lm = selfloc.dropFirst(0)
                
                if arr.contains(lm) && isBlocked == false { // --- && blocked == false !!!!!!!!
                    allow = true
                }
                
                
               
                
                
                //   print("NAME \(name) isBlocked \(isBlocked)")
                // && (isBlocked == false)
                if (name != selfmail) && selfmail.count > 0 && (allow == true) && (isBlocked == false)  {
                    
                    // get proximity and create user
                    test -= 1
                    
                    
                    var ig: UIImage?
                    
                    // ---------------------------------------------- User has the profile image URL in v?["utl"]
                    if url.count > 3 && url != "not found" && download == true { // URL ---------------------------
                        let storage = Storage.storage().reference(forURL: url)
                        storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                            
                            if data != nil {
                                let image = UIImage(data: data!)
                                // print("IMAGE DIMENSIONS \(image!.size)")
                                ig = image!
                                //  print("IMAGESCOUNT \(self.images.count)")
                                let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                                let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: ig!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                                
                                temp.append(u)
                                print("TEMPOOOOO")
                                print("EMO \(name)  PROXX \(prox)")
                                temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                                completion(temp)
                            }
                        })
                    }
                        
                        
                        
                        // ---------------------------------------------- User doesn't have the profile image URL set, use default image
                    else {
                        
                        let image = UIImage(named: "ocean.jpg")
                        
                        let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                        let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: image!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                        
                        temp.append(u)
                        
                        temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                        completion(temp)
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            // temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
            
            
            // let obj = K
            //  UserDefaults.standard.set(dict, forKey: "names")
            
            
            //  completion(temp)
            
            for r in temp {
                print("PROXYTEST \(r.name)  \(r.sortby)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func observeIfSent(letin: [String], blocked: String, selfmail: String, selfrun: Int, selfswim: Int, download: Bool, completion: @escaping([User]) -> Void) {
        
        let ref = Database.database().reference()
        var temp = [User]()
        //  ref.child(name).queryOrderedByKey().observe(.value) { (snap) in
        ref.child(name).queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            
            
            var test = 100
            for s in snap.children {
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                
                let name = v?["email"] as? String ?? "not found"
                let shownick = v?["nickname"] as? String ?? "not found"
                let swimtime = v?["stime"] as? String ?? "not found"
                let runtime = v?["rtime"] as? String ?? "not found"
                let locationa = v?["race"] as? String ?? "not found" // PROBLEM HERE :D Delete users (new)
                let count = v?["count"] as? String ?? "N/A"
                
                let url = v?["url"] as? String ?? "x"
                let rectoken = v?["token"] as? String ?? "x"
                
                // print("URL was \(url)")
                //  var blocko = v?["blocked"] as? String ?? ""
                
                print("Passed blocked is \(blocked)")
                
                
                var isBlocked = false
                
                //  let blocked = v?["blocked"] as? String ?? "not set"
                let marr = blocked.split(separator: "-")
                
                //   print("BLOCKED \(blocked) marr \(marr) name.dropFirst(0) \(name.dropFirst(0))")
                
                if marr.contains(name.dropFirst(0)){
                    print("I got him !!!! \(name.dropFirst(0))")
                    isBlocked = true
                }
                
                
                
                
                if letin.contains(w.key){ // user has sent me a message already
                    print("LETINOO \(shownick)")
                    isBlocked = false
                } else {
                    print("BLOCK \(shownick)")
                    isBlocked = true
                }
                
                /*
                 
                 */
                
                
                let gender = v?["gender"] as? String ?? "nog"
                let country = v?["country"] as? String ?? "noc"
                
                let arr = locationa.split(separator: "-")
                var allow = false
                // let lm = selfloc.dropFirst(0)
                
                /* if arr.contains(lm){ // && blocked == false !!!!!!!!
                 allow = true
                 }*/
                allow = true // GET ALL RACES
                
                
                //   print("NAME \(name) isBlocked \(isBlocked)")
                // && (isBlocked == false)
                if (name != selfmail) && selfmail.count > 0 && (allow == true) && (isBlocked == false)  {
                    
                    // get proximity and create user
                    test -= 1
                    
                    
                    var ig: UIImage?
                    
                    // ---------------------------------------------- User has the profile image URL in v?["utl"]
                    if url.count > 3 && url != "not found" && download == true { // URL ---------------------------
                        let storage = Storage.storage().reference(forURL: url)
                        storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                            
                            if data != nil {
                                let image = UIImage(data: data!)
                                
                                if image != nil {
                                    ig = image! // image is NIL !!!!
                                } else {
                                    ig = UIImage(named: "ocean.jpg")
                                }
                                
                                
                                
                                
                                //  print("IMAGESCOUNT \(self.images.count)")
                                let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                                
                                print("EMAIL \(name)")
                                print("HISSWIM \(swimtime)")
                                print("HISRUN \(runtime)")
                                print("PROXIMITY \(prox)")
                                
                                print("--------------------")
                                print("MYSWIM \(selfswim)") // value is 0 !!!
                                print("MYRUN \(selfrun)") // value is 0 !!!
                                print("--------------------")
                                
                                let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: ig!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                                
                               
                                
                                
                                temp.append(u)
                                
                                let unsorted = temp.map {$0.sortby}
                                
                                
                                temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                                
                                let sorted = temp.map {$0.sortby}
                               
                                print("TEMP.COUNT IS \(temp.count)")
                                
                                completion(temp)
                            }
                        })
                    }
                        
                        
                        
                        // ---------------------------------------------- User doesn't have the profile image URL set, use default image
                    else {
                        
                        let image = UIImage(named: "ocean.jpg")
                        
                        let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                        let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: image!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                        
                        temp.append(u)
                        
                        temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                        print("TEMP.COUNT \(temp.count)")
                        
                        completion(temp)
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            // temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
            
            
            // let obj = K
            //  UserDefaults.standard.set(dict, forKey: "names")
            
            
            //  completion(temp)
            
            for r in temp {
                print("PROXYTEST \(r.name)  \(r.sortby)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func observeA(blocked: String, selfmail: String, selfrun: Int, selfswim: Int, download: Bool, completion: @escaping([User]) -> Void) {
        let ref = Database.database().reference()
        var temp = [User]()
        //  ref.child(name).queryOrderedByKey().observe(.value) { (snap) in
        ref.child(name).queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            
            
            var test = 100
            for s in snap.children {
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                let name = v?["email"] as? String ?? "not found"
                let shownick = v?["nickname"] as? String ?? "not found"
                let swimtime = v?["stime"] as? String ?? "not found"
                let runtime = v?["rtime"] as? String ?? "not found"
                let locationa = v?["race"] as? String ?? "not found" // PROBLEM HERE :D Delete users (new)
                let count = v?["count"] as? String ?? "N/A"
                
                let url = v?["url"] as? String ?? "x"
                let rectoken = v?["token"] as? String ?? "x"
                
                // print("URL was \(url)")
                //  var blocko = v?["blocked"] as? String ?? ""
                
                print("Passed blocked is \(blocked)")
                
                
                var isBlocked = false
                
                //  let blocked = v?["blocked"] as? String ?? "not set"
                let marr = blocked.split(separator: "-")
                
                //   print("BLOCKED \(blocked) marr \(marr) name.dropFirst(0) \(name.dropFirst(0))")
                
                if marr.contains(name.dropFirst(0)){
                    print("I got him !!!! \(name.dropFirst(0))")
                    isBlocked = true
                }
                
                
                /*
                 
                 */
                
                
                let gender = v?["gender"] as? String ?? "nog"
                let country = v?["country"] as? String ?? "noc"
                
                let arr = locationa.split(separator: "-")
                var allow = false
               // let lm = selfloc.dropFirst(0)
                
               /* if arr.contains(lm){ // && blocked == false !!!!!!!!
                    allow = true
                }*/
                 allow = true // GET ALL RACES
                
                
                //   print("NAME \(name) isBlocked \(isBlocked)")
                // && (isBlocked == false)
                if (name != selfmail) && selfmail.count > 0 && (allow == true) && (isBlocked == false)  {
                    
                    // get proximity and create user
                    test -= 1
                    
                    
                    var ig: UIImage?
                    
                    // ---------------------------------------------- User has the profile image URL in v?["utl"]
                    if url.count > 3 && url != "not found" && download == true { // URL ---------------------------
                        let storage = Storage.storage().reference(forURL: url)
                        storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                            
                            if data != nil {
                                let image = UIImage(data: data!)
                               
                                if image != nil {
                                    ig = image! // image is NIL !!!!
                                } else {
                                    ig = UIImage(named: "ocean.jpg")
                                }
                              
                                
                                
                                
                                //  print("IMAGESCOUNT \(self.images.count)")
                                let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                              
                                print("EMAIL \(name)")
                                print("HISSWIM \(swimtime)")
                                print("HISRUN \(runtime)")
                                print("PROXIMITY \(prox)")
                               
                                print("--------------------")
                                print("MYSWIM \(selfswim)") // value is 0 !!!
                                print("MYRUN \(selfrun)") // value is 0 !!!
                                 print("--------------------")
                                
                                let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: ig!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                              
                                print("OBSERVEA BLOCK:  NAME \(name) PROX \(prox)  SWIMTIME (hisswim )\(swimtime)")
                                
                                
                                temp.append(u)
            
                                let unsorted = temp.map {$0.sortby}
                                print("UNSORTED")
                                print(unsorted)
                                
                                temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                                
                                let sorted = temp.map {$0.sortby}
                                print("SORTED")
                                print(sorted)
                                
                                
                                completion(temp)
                            }
                        })
                    }
                        
                        
                        
                        // ---------------------------------------------- User doesn't have the profile image URL set, use default image
                    else {
                        
                        let image = UIImage(named: "ocean.jpg")
                        
                        let prox = self.proximity(email: name, myswim: selfswim, myrun: selfrun, hisswim: swimtime, hisrun: runtime)
                        let u = User(name: name, location: locationa, run: runtime, swim: swimtime, uid: w.key, experience: count, gender: gender, sortby: prox, image: image!, imurl: url, rectoken: rectoken, country: country, showNick: shownick)
                        
                        temp.append(u)
                        
                        temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
                        completion(temp)
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            // temp = temp.sorted(by: {$0.sortby < $1.sortby}) // sort user
            
            
            // let obj = K
            //  UserDefaults.standard.set(dict, forKey: "names")
            
            
            //  completion(temp)
            
            for r in temp {
                print("PROXYTEST \(r.name)  \(r.sortby)")
            }
        }
    }
    
    
    func proximity(email: String, myswim: Int, myrun: Int, hisswim: String, hisrun:String) -> Double {
        
        let hisswim = hisswim.toSec()
        let hisrun = hisrun.toSec()
        
        let sp = Double(myswim) / Double(hisswim) // Double ????
        let spof = abs(sp - 1) * 100.0
        
        let rp = Double(myrun) / Double(hisrun)
        let rdof = abs(rp - 1) * 100.0
        
        let diff = spof + rdof
        
        let ret = 0
        
        if diff.isInfinite || diff.isNaN {
            return 0
        }
        
        return Double(diff)
    }
    
    /*
     import UIKit
     
     
     class User {
     var name: String
     var stime: Int
     var rtime: Int
     var order: Int
     
     init(name: String, stime: Int, rtime: Int, order: Int) {
     self.name = name
     self.stime = stime
     self.rtime = rtime
     self.order = order
     }
     }
     
     
     func proximity(myswim: Int, myrun: Int, hisswim: Int, hisrun:Int) -> Int {
     
     let sp = Double(myswim) / Double(hisswim) // Double ????
     let spof = abs(sp - 1) * 100
     
     let rp = Double(myrun) / Double(hisrun)
     let rdof = abs(rp - 1) * 100
     
     let diff = (spof + rdof) // round
     // print("RP \(rp)  SP \(sp)")
     print("Diff")
     return Int(diff)
     }
     
     
     
     var users = [User]()
     
     func fetch(st:Int, rt:Int){
     var email = "petr@a.com" // comes from Firebase
     var hst = 800 // 13:20
     var hrt = 2100 // 35:00
     
     var porder = proximity(myswim: st, myrun: rt, hisswim: hst, hisrun: hrt)
     let petr = User(name: email, stime: st, rtime: rt, order: porder)
     users.append(petr)
     print("Petr \(porder)")
     
     
     
     var vemail = "vera@a.com" // comes from Firebase
     var vhst = 1400 // 23:00
     var vhrt = 3300 // 55:00
     
     var fordera = proximity(myswim: st, myrun: rt, hisswim: vhst, hisrun: vhrt)
     let vera = User(name: vemail, stime: st, rtime: rt, order: fordera)
     users.append(vera)
     
     
     var smail = "sara@a.com"
     var sst = 1200 // 20:00
     var srt = 2600 // 43:00 (2600) (change to 1740 (29:00) and the order will change)
     var sortera = proximity(myswim: st, myrun: rt, hisswim: sst, hisrun: srt)
     let sara = User(name: smail, stime: st, rtime: rt, order: sortera)
     users.append(sara)
     
     
     users = users.sorted(by: {$0.order < $1.order})
     print("Vera \(fordera)")
     
     }
     
     
     fetch(st: 1020, rt: 1977) // my time, I will pass it to the fetch function
     
     for user in users {
     print("\(user.name): prox. \(user.order)")
     }
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     */
    
}









class Val {
    var value: String
    init(value: String){
        self.value = value
    }
}


class IncrGet { // getting previous value, to be able to increase "Yes" / "No" values
    var name: String
    
    init(name: String){
        self.name = name
    }
    /*
     
     func get(completion: @escaping([Val]) -> Void) {
     
     var p = [Val]()
     let ref = Database.database().reference()
     ref.child(name).observe(.value) { (snap) in
     for val in snap.children {
     let r = val as! DataSnapshot
     //  let v = r.value as? NSDictionary
     let passval = r.value as! Int
     print(" R \(passval)")
     
     //  let c = v?["count"] as? String ?? "not found"
     p.append(Val(value: String(passval)))
     completion(p)
     
     }
     
     
     }
     } */
    
    func get(completion: @escaping([Val]) -> Void) {
        
        var p = [Val]()
        let ref = Database.database().reference()
        //  ref.child(name).observe(.value) { (snap) in
        ref.child(name).observeSingleEvent(of: .value) { (snap) in
            
            
            for val in snap.children {
                let r = val as! DataSnapshot
                //  let v = r.value as? NSDictionary
                let passval = r.value as! Int
                //   print(" R \(passval)")
                
                //  let c = v?["count"] as? String ?? "not found"
                p.append(Val(value: String(passval)))
                completion(p)
                
            }
            
            
        }
    }
}




class Increaser {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    
    // ompletion: @escaping([User]) -> Void
    func add(val: Int) {
        //  var i = 0
        
        let ref = Database.database().reference()
        ref.child(name).updateChildValues(["count": val])
       
        
        
        
    }
    
    
}





class ChatObserver {
    var child:String
    var on: ChatController
    var edit: [MS]
    init(child:String, on: ChatController, edit: [MS]) {
        self.child = child
        self.on = on
        self.edit = edit
    }
    
    func observe(to:String, completion: @escaping([MS]) -> Void) { // to = self.toid
        
        let ref = Database.database().reference()
        ref.child("Chat").queryOrderedByKey().observe(.childAdded) { (snap) in
            let val = (snap.value as? NSDictionary)?["body"] as? String ?? ""
            let from = (snap.value as? NSDictionary)?["from"] as? String ?? ""
            let to = (snap.value as? NSDictionary)?["to"] as? String ?? ""
            
            let curr = Auth.auth().currentUser?.uid
            
            if to == curr! && from == to { // and from == self.toif
                let r = MS(from: from, to: to, m: val, color: "#1abc9c")
                // posts.append(r)
                self.edit.append(r)
                //  self.on.postview.reloadData()
                //  self.on.scrollIfNeeded()
                // completion(self.edit) // EDIT HERE ????
            }
            
            
            if from == curr! && to == to  {
                let r = MS(from: from, to: to, m: val, color: "#d3d3d3")
                // posts.append(r)
                self.edit.append(r)
                //  self.on.postview.reloadData()
                //    self.on.scrollIfNeeded()
                //  completion(self.edit)
            }
            
            completion(self.edit)
            
            // self.count += 1
        }
        
    }
}


class JSONFetcher{
    var edit: [Race]
    
    init(edit: [Race]){
        self.edit = edit
    }
    //  func observe(to:String, completion: @escaping([MS]) -> Void) { // to = self.toid
    
    func fetch(link: String, locations: [String], completion: @escaping([Race]) -> Void) {
        
        
        /*
         
         {
         "Zlin":"Horska Vyzva",
         "Otrokovice":"Triatlon",
         "Prague":"Oravaman"
         }
         */
        
        for location in locations {
            
            var ret = ""
            
            let urlc = URL(string: link)
            
            let task = URLSession.shared.dataTask(with: urlc!) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                if let content = data {
                    do {
                        
                        let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
                        ret = res[location] as! String
                        
                        let resa = Race(title: "DW", location: ret, url: "dwd", year:"2018")
                        self.edit.append(resa)
                        completion(self.edit)
                    }
                        
                    catch {
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    
}



class TextFetcher {
    var edit: [String]
    
    init(edit: [String]){
        self.edit = edit
    }
    
    func fetch(url: String, completion: @escaping([String]) -> Void){
        let c = URL(string: "https://github.com/filipvabrousek/Swift-apps/blob/master/database.txt")
        
        do {
            let contents = try String(contentsOf: c!)
            print(contents)
            let strings = contents.components(separatedBy: .newlines)
            
            for str in strings{
                edit.append(str)
            }
            
            completion(self.edit)
            
        }
            
        catch {
            
        }
    }
    
    
    func mefetcha(url:String, completion: @escaping([String]) -> Void){
        
        let c = URL(string: url)
        let task = URLSession.shared.dataTask(with: c!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if data != nil {
                print("Data are \(data)")
                do {
                    let ctx = try String(contentsOf: c!)
                    print("CTX is \(ctx)")
                    
                    let arr = ctx.components(separatedBy: .newlines)
                    print(arr[2].uppercased())
                    
                    
                    completion(arr)
                    /*  let richText = try NSAttributedString(url: c!, options: [:], documentAttributes: nil)
                     let plainText = richText.string
                     print("Content")
                     print(ctx)*/
                }  catch {
                    
                }
            }
        }
        
        task.resume()
        
        
    }
}


/*
 class JSONFetcherb {
 var location: String
 var supported: [String]
 
 
 init(location:String, supported: [String]){
 self.location = location
 self.supported = supported
 
 }
 
 func fetch() -> String {
 var ret = ""
 var locked = true
 let urlc = URL(string: "https://cdn.rawgit.com/filipvabrousek/Swift-apps/bf4f2194/races.json")
 
 
 let task = URLSession.shared.dataTask(with: urlc!) { (data, response, error) in
 if error != nil {
 print(error)
 }
 
 if let content = data {
 do {
 
 
 let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
 
 
 if self.supported.contains(self.location){
 print("inide res \(self.location)")
 ret = res[self.location] as! String
 locked = false
 
 print(" I HAVE A RACE FOR YOU IN \(ret)")
 } else {
 ret = "N/A"
 }
 }
 
 catch {
 
 }
 }
 }
 
 while(locked == true){
 wait()
 }
 
 task.resume()
 return ret
 }
 
 
 }
 
 func wait(){
 RunLoop.current.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 1))
 }
 
 */

/*
 class JSONFetcher {
 var location: String
 var supported: [String]
 
 
 init(location:String, supported: [String]){
 self.location = location
 self.supported = supported
 
 }
 
 func fetch() -> String {
 var ret = ""
 
 let urlc = URL(string: "https://cdn.rawgit.com/filipvabrousek/Swift-apps/bf4f2194/races.json")
 
 
 let task = URLSession.shared.dataTask(with: urlc!) { (data, response, error) in
 if error != nil {
 print(error)
 }
 
 if let content = data {
 do {
 
 
 let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
 
 
 if self.supported.contains(self.location){
 print("inide res \(self.location)")
 ret = res[self.location] as! String
 
 
 print(" I HAVE A RACE FOR YOU IN \(ret)")
 } else {
 ret = "N/A"
 }
 }
 
 catch {
 
 }
 }
 }
 
 task.resume()
 return ret
 }
 
 
 }
 */



/*
 // we have cities in our JSON file
 if self.supported.contains(self.name){
 //self.fillinweather = res[location] as! String
 str = res[self.name] as! String
 print("in func \(str)")
 } else {
 //self.fillinweather = "No data available"
 str = "N/A"
 }
 */


class Connection {
    func isConnected() -> Bool {
        var zero = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        
        zero.sin_len = UInt8(MemoryLayout.size(ofValue: zero))
        zero.sin_family = sa_family_t(AF_INET)
        
        let def = withUnsafePointer(to: &zero) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroa in SCNetworkReachabilityCreateWithAddress(nil, zeroa)
            }
        }
        
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(def!, &flags) == false {
            return false
        }
        
        let isReach = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needs = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret  = (isReach && !needs)
        
        return ret
    }
}











class RaceSwitcher {
    
    
    func remove(race: String){
   
        let us = Auth.auth().currentUser
        let ref = Database.database().reference()
        
        let uid:String = (Auth.auth().currentUser?.uid)!
       
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            
            
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                    
                    let emaila = v?["email"] as? String ?? "not found"
                    let stimea = v?["stime"] as? String ?? "not found"
                    let rtimea = v?["rtime"] as? String ?? "not found"
                    let ct = v?["count"] as? String ?? "not found"
                    let nick = v?["nickname"] as? String ?? "not found"
                
                    
                    let pswd = v?["password"] as? String ?? "not found"
                    //  let r = v?["race"] as? String ?? "not found"
                    
                    
                   let races =  v?["race"] as? String ?? "not found"
                    
                    
                    let token = v?["token"] as? String ?? "not found" // this is why notification continue to receive :D
                    
                    let arr = races.split(separator: "-").filter {$0 != race}
                   
                    
                    var str = ""
                    for val in arr {
                        str.append("\(val)-")
                    }
                    
                  
                    
                    
                    let path = v?["url"] as? String ?? "not found"
                    let country = v?["country"] as? String ?? "not found"
                    let gender = v?["gender"] as? String ?? "not found"
                    
                    let data : [String:Any] = ["nickname": nick,
                                               "email": emaila,
                                               "password": pswd,
                                               "rtime":rtimea,
                                               "stime":stimea,
                                               "race": str,
                                               "count": ct,
                                               "ids": str,
                                               "country": country,
                                               "gender": gender,
                                               "url": path,
                                               "token": token]
                    // ADD GENDER
                    
                    ref.child("Users").child(uid).setValue(data)
                    
                    
              
    }
}
}
}
    
    
    
    func update(races: [String], ticked: Bool){ // call it
        let us = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference()
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            
        
            
            for s in snap.children {
                let w = s as! DataSnapshot
                if w.key == us {
             
                    let v = w.value as? NSDictionary
                    
                
                    
                
                let emaila = v?["email"] as? String ?? "not found"
                let stimea = v?["stime"] as? String ?? "not found"
                let rtimea = v?["rtime"] as? String ?? "not found"
                let ct = v?["count"] as? String ?? "not found"
                let nick = v?["nickname"] as? String ?? "not found"
                
                
                let pswd = v?["password"] as? String ?? "not found"
                //  let r = v?["race"] as? String ?? "not found"
                
                
                //  let races =  v?["race"] as? String ?? "not found"
                
                let country = v?["country"] as? String ?? "not found"
                let gender = v?["gender"] as? String ?? "not found"
                    
                    
                let token = v?["token"] as? String ?? "not found" // this is why notification continue to receive :D
                
                // OH FUCK THIS LINE !!!
               // let arr = races.split(separator: "-") //.filter {$0 != race}
                let arr = races
                
                var str = ""
                for val in arr {
                    str.append("\(val)-")
                }
                
                
           
                    
                
                let path = v?["url"] as? String ?? "not found"
               
                    var prt = ""
                    if ticked == true {
                        prt = "TICKED"
                    } else {
                        prt = "UNTICKED"
                    }
                print("")
                print("")
                print("ABOUT TO SAVE---------\(prt)-----------")
                    
                print("NICKNAME \(nick)")
                print("EMAIL \(emaila)")
                    
                print("PASSWORD \(pswd)")
                print("RTIME \(rtimea)")
                print("STIME \(stimea)")
                print("RACE \(str)")
                print("COUNT \(ct)")
                print("IDS \(str)")
                print("URL \(path)")
                print("TOKEN \(token)")
                    
                    
                
                let data : [String:Any] = ["nickname": nick,
                                           "email": emaila,
                                           "password": pswd,
                                           "rtime":rtimea,
                                           "stime":stimea,
                                           "race": str,
                                           "country": country,
                                           "gender": gender,
                                           "count": ct,
                                           "ids": str,
                                           "url": path,
                                           "token": token]
                // ADD GENDER
                
                ref.child("Users").child(us).setValue(data)
            }
            }
        }
    }
    
    
}






//
//  User.swift
//  Sportify
//
//  Created by Filip Vabroušek on 18/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreData


class CDUser:NSObject, NSCoding {
  
   
    struct Keys {
        static let email = "email"
        static let password = "password"
      
    }
    
    private var _email = ""
    private var _password = ""
   
    
    override init() {}
    
    
    init(email:String, password: String){
        self._email = email
        self._password = password
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        if let emailobj = aDecoder.decodeObject(forKey: Keys.email) as? String {
            _email = emailobj
        }
        
        if let passwordobj = aDecoder.decodeObject(forKey: Keys.password) as? String {
            _password = passwordobj
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_email, forKey: Keys.email)
        aCoder.encode(_password, forKey: Keys.password)
    }
    
    
    var email: String{
        get {
            return _email
        }
        
        set {
         _email = newValue
        }
    }
    
    
    var password: String {
        get {
           return _password
        }
        
        set {
            _password = newValue
        }
    }
    //      let data = ["email": email, "password": pswd, "rtime":rtime, "stime":stime, "race": rs, "ids": str]
}



class Saver {
    
    var ename: String
    var key: String
    var obj: CDUser
    init(ename: String, key: String, obj: CDUser){
        self.ename = ename
        self.key = key 
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
            print("Successfully saved")
        }
        catch{
            // sth went wrong
        }
    }
}


/*------------------------------------------------ RFETCHER -----------------------------------------------*/
class UFetcher {
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetchR() -> [CDUser] {
        
        var runs = [CDUser]()
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let run = res.value(forKey: key) as? CDUser {
                        runs.append(run)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return runs
}
}





/*------------------------------------------------ State saver -----------------------------------------------*/
class StateSaver {
    
    var ename: String
    var key: String
    var obj: MatchData
    
    init(ename: String, key: String, obj: MatchData){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
            print("Successfully saved")
        }
        catch{
            // sth went wrong
        }
    }
}



class CHStateSaver {
    
    var ename: String
    var key: String
    var obj: ChatData
    
    init(ename: String, key: String, obj: ChatData){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
            print("Successfully saved")
        }
        catch{
            // sth went wrong
        }
    }
}


class StateFetcher{
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetchR() -> [MatchData] {
        
        var runs = [MatchData]()
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let run = res.value(forKey: key) as? MatchData {
                        runs.append(run)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return runs
    }
}







class CHStateFetcher{
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetchR() -> [ChatData] {
        
        var runs = [ChatData]()
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let run = res.value(forKey: key) as? ChatData {
                        runs.append(run)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return runs
    }
}



//
//  Extensions.swift
//  Sportify
//
//  Created by Filip Vabroušek on 13/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

/*
extension String {
    func extract() -> String {
        var ret = ""
        if (self.contains("@") && self.count > 2){
            let a = self.split(separator: "@")
            var f = "\(a.first!)" // filip
            let n = String(f.first!)
            let up = n.uppercased()
            f.removeFirst()
            ret = "\(up)\(f)"
        }
        return ret
    }
}*/


public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}


extension UIDevice {
    var isIpad: Bool {
        let devices = ["iPad Pro (12.9-inch) (3rd generation)", "iPad Pro (11-inch)", "iPad Pro (10.5-inch)", "iPad Pro (12.9-inch) (2nd generation)", "iPad Pro (12.9-inch)", "iPad Pro (9.7-inch)", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad Air 2", "iPad Air", "Simulator iPad Pro (12.9-inch) (3rd generation)"]
        let device = UIDevice.modelName
        
        if devices.contains(device){
            return true
        } else {
            return false
        }
    }
}


class Checker {
    var p: String = ""
   

    func isIpad() -> Bool {
        let devices = [
            // iPad
                         "iPad 5", "Simulator iPad 5",
                         "iPad 6", "Simulator iPad 6",
                         "iPad Air", "Simulator iPad Air",
                         "iPad Air 2", "Simulator iPad Air 2",
                         "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", // have no simulators, same as the iPad 9.7
            
            //-- iPad Pro
                       "iPad Pro (11-inch)", "Simulator iPad Pro (11-inch)",
                       "iPad Pro (10.5-inch)", "Simulator iPad Pro (10.5-inch)",
                       "iPad Pro (12.9-inch)", "Simulator iPad Pro (12.9-inch)",
                       "iPad Pro (12.9-inch) (3rd generation)", "Simulator iPad Pro (12.9-inch) (3rd generation)",
                       "iPad Pro (12.9-inch) (2nd generation)", "Simulator iPad Pro (12.9-inch) (2nd generation)",
                       "iPad Pro (9.7-inch)", "Simulator iPad Pro (9.7-inch)"
        ]
        
        
        //
         let device = UIDevice.modelName
        
        if (devices.contains(device)){
            return true
        } else {
            return false
        }
        
    }
    
    
    func isBiggestIpad() -> Bool {
      let devs = [ "iPad Pro (12.9-inch)", "Simulator iPad Pro (12.9-inch)",
                "iPad Pro (12.9-inch) (2nd generation)", "Simulator iPad Pro (12.9-inch) (2nd generation)", // not working ????
                "iPad Pro (12.9-inch) (3rd generation)", "Simulator iPad Pro (12.9-inch) (3rd generation)"]
        
        // 12.9 2nd gen problem !!! 
        let device = UIDevice.modelName
        print("Device in is BiggestIPad \(device)")
        
        if (devs.contains(device)){
            return true
        } else {
            return false
        }
        
    }
    
    
    
    func isSmallIpad() -> Bool {
        let devs = [ "iPad 5", "Simulator iPad 5",
                     "iPad 6", "Simulator iPad 6",
                     "iPad Air", "Simulator iPad Air",
                     "iPad Air 2", "Simulator iPad Air 2",
                     "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", // have no simulators, same as the iPad 9.7
            
            //-- iPad Pro
            "iPad Pro (11-inch)", "Simulator iPad Pro (11-inch)",
            "iPad Pro (10.5-inch)", "Simulator iPad Pro (10.5-inch)"]
        
        let device = UIDevice.modelName
        
        
        if (devs.contains(device)){
            print("SMALL \(device)")
            return true
        } else {
            return false
        }
        
    }
    
 
    
    

       
}

extension String {
    func toSec() -> Int {
        var res = 0
        if self.contains(":") && self.count == 5 { // 34:14
            let w = self.split(separator: ":")
            res = Int(w[0])! * 60 + Int(w[1])! // sometimes index out of range
        }
        return res
    }
}

extension String {
    func shorten() -> String {
       
           var tl = ""
        if self.contains(" "){
            
        
        var text = self.split(separator: " ") // Possible crash !!!!!
        text.remove(at: 0)
        text.remove(at: 0)
        
        print("Text \(text)")
     
        
        for (i, val) in text.enumerated(){
            tl += "\(text[i]) "
        }
        } else {
            tl = "Just a moment ..."
        }
        return tl
        
    }
}



extension UITextField {
    func setBorder(){
       /* self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shado*/
    }
}

extension UICollectionView {
    func scrollLast() {
        guard numberOfSections > 0 else {
            return
        }
        
        let last = numberOfSections - 1
        
        guard numberOfItems(inSection: last) > 0 else  {
            return
        }
        
        let lasti = IndexPath(item: numberOfItems(inSection: last) - 1, section: last)
        
      
        
        let n = numberOfItems(inSection: last) - 1
        print("Number of sections \(numberOfSections)")
        print("scrolling to \(n)")
        scrollToItem(at: lasti, at: .bottom, animated: false)
        
    }
    
    
    
    func scroll(){
        let section = 0
        let lite = self.numberOfItems(inSection: section) - 1
        let ip = IndexPath(item: lite, section: section)
        self.scrollToItem(at: ip, at: .bottom, animated: true)
    }

    /*
     let section = 0
     let lastItemIndex = self.dateCollectionView.numberOfItemsInSection(section) - 1
     let indexPath:NSIndexPath = NSIndexPath.init(forItem: lastItemIndex, inSection: section)
     self.dateCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Right, animated: false)
     
     */
}




extension UITableView {
    func scroll(){
        let section = 0
        let lastItemIndex = self.numberOfRows(inSection: section) - 1
        
        if lastItemIndex > 0 {
        let indexPath = IndexPath.init(item: lastItemIndex, section: section)
        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}


extension Sequence where Element:Hashable {
    var unique: [Element]{
        return self.reduce(into: []){
            unique, el in
            
            if !unique.contains(el){
                unique.append(el)
            }
        }
    }
}



extension UINavigationBar {
    /*
     extension UINavigationBar {
     func transparentNavigationBar() {
     self.setBackgroundImage(UIImage(), for: .default)
     self.shadowImage = UIImage()
     self.isTranslucent = true
     }
     }
     */
    
    func makeTransparent(){
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}


extension GroupController {
    func addConnectionError(){
        view.addSubview(disview)
        view.addSubview(dislabel)
        view.addSubview(trybutton)
        disview.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        dislabel.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        trybutton.pin(a: .top, b: .center, ac: 150, bc: 0, w: 80, h: 40, to: nil)
        // present(r, animated: false, completion: nil)
    }
}


extension MatchControllersqs {
    func addConnectionError(){
        view.addSubview(disview)
        view.addSubview(dislabel)
        view.addSubview(trybutton)
        disview.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        dislabel.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        trybutton.pin(a: .top, b: .center, ac: 150, bc: 0, w: 80, h: 40, to: nil)
        // present(r, animated: false, completion: nil)
    }
}


extension EditController {
    func addConnectionError(){
        view.addSubview(disview)
        view.addSubview(dislabel)
        view.addSubview(trybutton)
      //  disview.ignoreP(a: .top, b: .left, ac: 0, bc: 0, w: view.frame.width, h: view.frame.height, to: nil)
        disview.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        dislabel.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        trybutton.pin(a: .top, b: .center, ac: 150, bc: 0, w: 80, h: 40, to: nil)
        // present(r, animated: false, completion: nil)
    }
}


extension ChatController {
    func addConnectionError(){
        view.addSubview(disview)
        view.addSubview(dislabel)
        view.addSubview(trybutton)
       disview.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        dislabel.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        trybutton.pin(a: .top, b: .center, ac: 150, bc: 0, w: 80, h: 40, to: nil)
        // present(r, animated: false, completion: nil)
    }
}


extension AllController {
    func addConnectionError(){
        view.addSubview(disview)
        view.addSubview(dislabel)
        view.addSubview(trybutton)
        disview.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        dislabel.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        trybutton.pin(a: .top, b: .center, ac: 150, bc: 0, w: 80, h: 40, to: nil)
        // present(r, animated: false, completion: nil)
    }

}



func checkTime(time:String, type:String) -> Bool {
    let arr = time.split(separator: ":")
    var allow = true;
    
    if (type == "swim") {
        
        if (Int(arr[0])! < 10 || Int(arr[0])! > 59) {
            allow = false;
        }
        
        if (Int(arr[1])! > 59) {
            allow = false;
        }
    }
    
    
    
    if (type == "run") {
        if (Int(arr[0])! < 28 || Int(arr[0])! > 99) {
            allow = false;
        }
        
        if (Int(arr[1])! > 59) {
            allow = false;
        }
    }
    
    
    if (time.count != 5) {
        allow = false;
    }
    
    if (time.contains(":") == false) {
        allow = false;
    }
    
    return allow;
}
//
//  Buttons.swift
//  Sportify
//
//  Created by Filip Vabroušek on 21/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit


class Rounded: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.contentMode = .scaleAspectFill
        
        
        // let size = self.image!.size
        // self.sizeThatFits(size)
        
        self.clipsToBounds = true
    }
}


class LoginB: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.layer.cornerRadius = 3
        self.setTitleColor(.black, for: [])
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        // self.contentEdgeInsets = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 20)
    }
    
   
}


class SignB: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        // self.backgroundColor = hex("#3498db")
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    }
}


class Matchb: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.backgroundColor = hex("#e74c3c")
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
      
    }
    
    
}



class AddB:UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.backgroundColor = hex("#3498db") //hex("#bdc3c7")
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        
        self.setTitle("+ Race", for: [])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}


class CloseB: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
      self.backgroundColor = hex("#bdc3c7")
      self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 0.5
    }
    
    
}

/*
 extension ChatController {
 override func viewDidLayoutSubviews() {
 matchb.layer.cornerRadius = 0.5 * matchb.bounds.size.width
 matchb.clipsToBounds = true
 }
 } */



class Sfield: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    func setup(){
        self.backgroundColor = hex("#ecf0f1")
        // self.placeholder?.font = UIFont.boldSystemFont(ofSize: 20)
        /* let paddingv = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height + 30))
         self.leftView = paddingv
         self.leftViewMode = .always */
        
    }
}


class BMaker {
    var title: String
    var color: String
    var size: CGFloat
    var action: Selector
    
    init(title: String, color: String, size: CGFloat, action: Selector){
        self.title = title
        self.color = color
        self.size = size
        self.action = action
    }
    
    func gen() -> UIButton {
        let b = UIButton()
        b.setTitle(self.title, for: [])
        b.setTitleColor(hex(color), for: [])
        b.addTarget(self, action: action, for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.size)
        return b
    }
}









//
//  Extensions.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreData

// my Pin.swift library :)

class Numeric: UITextField {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addTarget(self, action: #selector(fix), for: .editingChanged)
    }
    
    @objc private func fix() {text = text?.limit(to: 2)}
}

extension String {
    func limit(to len: Int) -> String {
        if self.count <= len {
            return self
        }
        return String(Array(self).prefix(upTo: len))
    }
}



extension UIView {
    enum P {
        case top
        case bottom
    }
    
    enum O {
        case left
        case right
        case center
        case middle
    }
    
    
    enum S {
        case top
        case bottom
    }
    
    func ignorePin(a: S, dist: CGFloat, w: CGFloat, h:CGFloat){ // ignoring safeAreLayout
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        
        let sup = self.superview!
        
        if a == .bottom {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -dist).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: dist).isActive = true
        }
    }
    
    func bottomPin(top: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width).isActive = true
      /*  self.leftAnchor.constraint(equalTo: sup.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor).isActive = true */
        
        self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    
    func topBot(top: CGFloat, bottom: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width).isActive = true
        /*  self.leftAnchor.constraint(equalTo: sup.leftAnchor).isActive = true
         self.rightAnchor.constraint(equalTo: sup.rightAnchor).isActive = true */
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: -bottom).isActive = true
        
    }
    
    
    
    func bottomPinBeta(top: CGFloat, bottom:CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width).isActive = true
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
                 self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        }
   
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func centerPin(margin: CGFloat, top: CGFloat, bottom:CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width - margin).isActive = true
        self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // +
        
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        }
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func centerAPin(margin: CGFloat, top: CGFloat, height:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width - margin).isActive = true
        self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // +
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
       
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func stretchPin(top: UIView?, left:UIView?, right:UIView?, bottom: UIView?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalTo: sup.widthAnchor).isActive = true
        //self.centerXAnchor = sup.centerXAnchor
        if top != nil {
            self.topAnchor.constraint(equalTo: top!.bottomAnchor, constant: 0).isActive = true
        }
     
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: bottom!.topAnchor, constant: 0).isActive = true
        }
    }
    
    
    func fillsuperview(top: CGFloat?, left: CGFloat?, right: CGFloat?, bottom: CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        
        if top != nil {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: top!).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: 0).isActive = true
        }
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: 0).isActive = true
        }
        
        
        if left != nil {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: left!).isActive = true
        } else {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: 0).isActive = true
        }
        
        
        if right != nil {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: right!).isActive = true
        } else {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: 0).isActive = true
        }
    }
    

    
    func deactivate(){
        for const in self.constraints{
            const.isActive = false
        }
        
        for const in self.constraints{
           print("Cons \(const)")
        }
        
    }
    
    func pin(a: P, b: O, ac: CGFloat, bc:CGFloat, w: CGFloat, h:CGFloat, to:UIView?){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        
        
        print("S \(self)")
         let sup = self.superview!
        
        if a == .bottom {
            self.bottomAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: -ac).isActive = true // safeAR
        }
        //   navBar.pin(a: .top, b: .center, ac: 0, bc: 0, w: view.bounds.width, h: 20, to: nil)
        if a == .top && b != .center {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if a == .top && b == .center {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if a == .bottom && b == .center { // new addition ???
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // newl
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: ac).isActive = true
        }
        
        
        
        if a == .top && b == .middle {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if b == .right {
            self.rightAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.rightAnchor, constant: -bc).isActive = true
        }
        
        if b == .left {
            self.leftAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.leftAnchor, constant: bc).isActive = true
        }
        
        if a == .top && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: ac).isActive = true
        }
        
        if a == .bottom && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: -ac).isActive = true
        }
        
        
    }
    
    
    
    
    func stretch(within: UIView, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -insets[2]).isActive = true
        self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -insets[3]).isActive = true
        
    }
    
    
    func centerIn(_ view: UIView?, width: CGFloat, height: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var v = UIView()
        
        
        if view != nil {
            v = view!
        } else {
            v = self.superview!
        }
      
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height),
            self.centerXAnchor.constraint(equalTo: v.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: v.centerYAnchor)
            ])
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func stretchooo(within: UIView, contentWidth: CGFloat, height: CGFloat, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        
        print("11111")
        let final = (contentWidth / self.frame.width) * self.frame.width // This is nan
                print("11111 \(final)")
        // top, left, width in %
        self.widthAnchor.constraint(equalToConstant: final).isActive = true
        
        

        
              print("22222")
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        
              print("3333333")
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
              print("4444444")
         self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func stretchH(within: UIView, height: CGFloat, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -insets[2]).isActive = true
      //  self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -insets[3]).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    func stretch(top: UIView?, left: UIView?, right: UIView?, bottom: UIView?, padding: [CGFloat]){
    
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        if top != nil {
            self.topAnchor.constraint(equalTo: top!.bottomAnchor, constant: padding[0]).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: padding[0]).isActive = true
        }
        
      
        
        
        if left != nil {
            self.leftAnchor.constraint(equalTo: left!.leftAnchor, constant: padding[1]).isActive = true
        } else {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: padding[1]).isActive = true
        }
        
        
        if right != nil {
            self.rightAnchor.constraint(equalTo: right!.rightAnchor, constant: -padding[2]).isActive = true
        } else {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -padding[2]).isActive = true
        }
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: bottom!.topAnchor, constant: -padding[3]).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -padding[3]).isActive = true
        }
        
        
    }
    
    enum Q {
        case top
        case bottom
        case left
        case right
    }
    
    
    func pinTo(_ view: UIView?, position: Q, h: CGFloat, w: CGFloat, margin: CGFloat, sides: CGFloat /*margin: [CGFloat]*/){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        
       self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
        
        
        if position == .top {
            
            
            if view != nil {
                self.bottomAnchor.constraint(equalTo: view!.topAnchor, constant: -margin).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        /*
         if position == .left {
         self.leftAnchor.constraint(equalTo: view!.leftAnchor, constant: margin).isActive = true
         } else {
         self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: margin).isActive = true
         } */
        
        
        
        if position == .left {
            if view != nil {
                self.leftAnchor.constraint(equalTo: view!.leftAnchor, constant: margin).isActive = true
            } else {
                self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: margin).isActive = true
            }
        }
        
        
        
        
        if position == .right {
            if view != nil {
                self.rightAnchor.constraint(equalTo: view!.rightAnchor, constant: -margin).isActive = true
            } else {
                self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        if position == .bottom {
            if view != nil {
                self.topAnchor.constraint(equalTo: view!.bottomAnchor, constant: margin).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: sup.topAnchor, constant: margin).isActive = true
            }
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    func stretch(height: CGFloat, padding: [CGFloat]){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: padding[0]).isActive = true
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: padding[1]).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -padding[2]).isActive = true
        
        
   
          //  self.bottomAnchor.constraint(equalTo: bottom.topAnchor, constant: -padding[3]).isActive = true
       
        
    }
}


class Time {
    var seconds = 0
    init(seconds: Int) {
        self.seconds = seconds
    }
}


extension Time {
   
    var shortTime: String{
        let time =  (/*seconds / 3600,*/ (seconds % 3600) / 60, seconds % 60)
        let (/*h,*/ m, s) = time
        
       // var strHr = String(h)
        var strMin = String(m)
        var strSec = String(s)
        
        
     /*   if h < 10 {
            strHr = "0\(h)"
        } */
        
        if m < 10{
            strMin = "0\(m)"
        }
        
        if s < 10{
            strSec = "0\(s)"
        }
        
        return "\(strMin):\(strSec)"
    }
}


func hex(_ hex:String) -> UIColor {
    var cs = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cs.hasPrefix("#"){
        cs.remove(at: cs.startIndex)
    }
    
    if cs.count != 6 {
        return UIColor.black
    }
    
    var rgbv: UInt32 = 0
    Scanner(string: cs).scanHexInt32(&rgbv)
    
    return UIColor(red: CGFloat((rgbv & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((rgbv & 0x00FF00) >> 8) / 255.0,
                   blue: CGFloat((rgbv & 0x0000FF)) / 255.0,
                   alpha: CGFloat(1.0))
}


class USaver{
    
    var ename: String
    var key: String
    var obj: User
    init(ename: String, key: String, obj: User){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
        }
        catch{
            
        }
    }
    
}


class Fetcher{
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    

    func fetchU() -> [User] {
        
        var users = [User]()
        users.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let user = res.value(forKey: key) as? User {
                        users.append(user)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return users
}

}



class Eraser{
    var ename: String
    init(ename: String){
        self.ename = ename
    }
    
    
    func erase() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Deleted")
        }
            
        catch {
            print("Deletion failed")
        }
    }
}



func smart(str: String) -> [Int] {
    var ints = [Int]()
    let arr = str.components(separatedBy: CharacterSet.decimalDigits.inverted)
    for item in arr {
        if let n = Int(item){
            ints.append(n)
        }
    }
    return ints
}






/*
extension LogController {
    func fixNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.resign), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // https://stackoverflow.com/questions/19801645/why-is-my-nsnotification-its-observer-called-multiple-times
    @objc func resign(){
        NotificationCenter.default.removeObserver(self)
    }
}


extension GroupController {
    func fixNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.resign), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // https://stackoverflow.com/questions/19801645/why-is-my-nsnotification-its-observer-called-multiple-times
    @objc func resign(){
        NotificationCenter.default.removeObserver(self)
    }
}



extension MatchControllersqs {
    func fixNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.resign), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // https://stackoverflow.com/questions/19801645/why-is-my-nsnotification-its-observer-called-multiple-times
    @objc func resign(){
        NotificationCenter.default.removeObserver(self)
    }
}



extension ChatController {
    func fixNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.resign), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // https://stackoverflow.com/questions/19801645/why-is-my-nsnotification-its-observer-called-multiple-times
    @objc func resign(){
        NotificationCenter.default.removeObserver(self)
    }
}



extension EditController {
    func fixNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.resign), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    // https://stackoverflow.com/questions/19801645/why-is-my-nsnotification-its-observer-called-multiple-times
    @objc func resign(){
        NotificationCenter.default.removeObserver(self)
    }
}
*/


extension UISearchBar {
    func transluescent() {
        self.barTintColor = .clear
        self.backgroundColor = .clear
        self.isTranslucent = true
        
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        /*
         searchBar.barTintColor = UIColor.clear
         searchBar.backgroundColor = UIColor.clear
         searchBar.isTranslucent = true
         searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
         
         
         */
    }
}



//
//  Alert.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

struct Alert {
    func show(on: UIViewController, title:String, messsage:String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        DispatchQueue.main.async {on.present(alert, animated: true, completion: nil)}
    }
}


struct Sheet {
    func show(on: UIViewController, title:String?, messsage:String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {on.present(alert, animated: true, completion: nil)}
    }
}



//
//  Constrains.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit


extension MatchControllersqs {
    func constrainUI(){
        
     /*   let c = Checker()
        if c.isIpad() {
              self.loadingLabel.pin(a: .top, b: .center, ac: 350, bc: 0, w: self.view.frame.width, h: 60, to: nil)
            //  tableView.bottomPin(top: 150) // bottom pin will stretch the area from bottom to the top (100 gap)
            //  label.pin(a: .top, b: .left, ac: 50, bc: 0, w: view.frame.width, h: 55, to: nil)
            back.pin(a: .top, b: .left, ac: 25, bc: 0, w: 85, h: 30, to: nil)
        } else {
              self.loadingLabel.pin(a: .top, b: .center, ac: 250, bc: 0, w: self.view.frame.width, h: 60, to: nil)
            //  tableView.bottomPin(top: 105) // bottom pin will stretch the area from bottom to the top (100 gap)
            // label.pin(a: .top, b: .left, ac: 43, bc: 0, w: view.frame.width, h: 40, to: nil)
            back.pin(a: .top, b: .left, ac: 12, bc: 2, w: 80, h: 30, to: nil) // + 5 everywhere
        } */
        
        
    }
}

extension RaceController {
    func constrainUI(){
        navBar.pin(a: .top, b: .middle, ac: 0, bc: 0, w: view.bounds.width, h: 20, to: nil)
        label.pin(a: .top, b: .left, ac: 10, bc: 30, w: view.frame.width, h: 30, to: nil)
        tableView.pin(a: .bottom, b: .middle, ac: 0, bc: 0, w: view.frame.width, h: 490, to: nil)
    }
}


extension EditController {
    func constrainUI() {
        print("IN EDIT CONSTRAIN UI DEVICE \(UIDevice.modelName)")
        
        let c = Checker()
        
        if c.isIpad() || c.isBiggestIpad() {
            experiencefield.font = UIFont.boldSystemFont(ofSize: 30) // fix
        }
        
        sheetbtn.pin(a: .top, b: .right, ac: 44, bc: 20, w: 30, h: 30, to: nil)
        // lbl.pin(a: .top, b: .left, ac: 28, bc: 16, w: view.frame.width, h: 70, to: nil)
        
        if c.isIpad() == true {
            lbl.pin(a: .top, b: .left, ac: 20, bc: 16, w: view.frame.width, h: 62, to: nil)
        } else {
            lbl.pin(a: .top, b: .left, ac: 35, bc: 16, w: view.frame.width, h: 45, to: nil)
        }
        
       
        background.ignorePin(a: .top, dist: 0, w: view.frame.width, h: 375)
        
        
  
        
        let device = UIDevice.modelName
        print("DEVICE IS FOR SURE \(device)")
        
        if c.isIpad() {
            
            
            print("CONTAGION OUTER !!!!")
            
            if c.isBiggestIpad() { // We are on the biggest iPads
                print("CONTAGION !!!!")
                
                main.subviews.forEach { // increase from 23
                    if $0 is UITextField {
                        
                        
                        
                        let field = $0 as! UITextField
                        
                        if field.tag != 1 {
                            field.font = UIFont.boldSystemFont(ofSize: 32)
                        }
                    }
                    
                    if $0 is UILabel {
                        let label = $0 as! UILabel
                        label.font = UIFont.boldSystemFont(ofSize: 32)
                    }
                    
                    if $0 is UIStackView {
                        let st = $0 as! UIStackView
                        st.subviews.forEach {
                            if $0 is UILabel {
                                let lbl = $0 as! UILabel
                                lbl.font = UIFont.boldSystemFont(ofSize: 32)
                            }
                            
                        }
                    }
                }
                
                
                
                
                
                main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [180, 275, 275, 160])
                imgview.pin(a: .top, b: .center, ac: 300, bc: 0, w: 210, h: 210, to: nil)
                
            } else { // We are on different iPad, than on the biggest ones
                
                
                
                
                if c.isSmallIpad() {
                    main.subviews.forEach { // increase from 23 (maybe remove)
                        if $0 is UITextField {
                           
                            
                            let field = $0 as! UITextField
                           
                            if $0.tag != 1 {
                                 field.font = UIFont.boldSystemFont(ofSize: 29)
                            }
                           
                        }
                        
                        if $0 is UILabel {
                            let label = $0 as! UILabel
                            label.font = UIFont.boldSystemFont(ofSize: 29) // 26
                        }
                        
                        
                        let ssize:CGFloat = 29 // 26
                        
                        if $0 is UIStackView {
                            let st = $0 as! UIStackView
                            st.subviews.forEach {
                                if $0 is UILabel {
                                    let lbl = $0 as! UILabel
                                    lbl.font = UIFont.boldSystemFont(ofSize: ssize)
                                }
                                
                                if $0 is Numeric {
                                    let f = $0 as! Numeric
                                    f.font = UIFont.boldSystemFont(ofSize: ssize)
                                }
                                
                                
                                if $0 is UIStackView {
                                    let st = $0 as! UIStackView
                                    st.subviews.forEach {
                                        if $0 is UILabel {
                                            let lbl = $0 as! UILabel
                                            lbl.font = UIFont.boldSystemFont(ofSize: ssize)
                                        }
                                        
                                        if $0 is Numeric {
                                            let f = $0 as! Numeric
                                            f.font = UIFont.boldSystemFont(ofSize: ssize)
                                        }
                                        
                                        if $0 is UITextField {
                                            let lbl = $0 as! UITextField
                                            lbl.font = UIFont.boldSystemFont(ofSize: ssize)
                                        }
                                        
                                        if $0 is Numeric {
                                            let f = $0 as! Numeric
                                            f.font = UIFont.boldSystemFont(ofSize: ssize)
                                        }
                                        
                                    }
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    // 3 - 5 min.
                    
                    
                    // EXCLUSIVE METHODS FOR CONSTRAINTS !!!!
                    
                    main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [170, 190, 190, 90])
                    imgview.pin(a: .top, b: .center, ac: 230, bc: 0, w: 190, h: 190, to: nil)
                    
                    print("IOGO")
                    
                    for c in savebtn.constraints {
                       c.isActive = false
                    }
                    
                    savebtn.translatesAutoresizingMaskIntoConstraints = false
                    savebtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
                    savebtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    
                    
                } else {
                    main.subviews.forEach { // increase from 23 (maybe remove)
                        if $0 is UITextField {
                            let field = $0 as! UITextField
                            field.font = UIFont.boldSystemFont(ofSize: 32)
                        }
                        
                        if $0 is UILabel {
                            let label = $0 as! UILabel
                            label.font = UIFont.boldSystemFont(ofSize: 32)
                        }
                        
                        if $0 is UIStackView {
                            let st = $0 as! UIStackView
                            st.subviews.forEach {
                                if $0 is UILabel {
                                    let lbl = $0 as! UILabel
                                    lbl.font = UIFont.boldSystemFont(ofSize: 32)
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [90, 180, 180, 80])
                    imgview.pin(a: .top, b: .center, ac: 230, bc: 0, w: 190, h: 190, to: nil)
                }
                
            }
        }
            
            
            
            
        else { // --------------------------- We are on an iPhone
            
            
            
            if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
                // main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [34, 30, 30, 6])
                main.pinTo(imgview, position: .bottom, h: 220, w: view.frame.width - 40, margin: 40, sides: 30)
                imgview.pin(a: .top, b: .center, ac: 155, bc: 0, w: 130, h: 130, to: nil)
            } else if device == "iPhone XR" || device == "Simulator iPhone XR" || device == "iPhone XS Max" || device == "Simulator iPhone XS Max" {
                print("Option called")
                main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [110, 65, 65, 300])
                // REVERT from backup
                
                // FIXYYY
                imgview.pin(a: .top, b: .center, ac: 200, bc: 0, w: 130, h: 130, to: nil) // ????
            } else if device == "iPhone 6" || device == "iPhone 6s" || device == "iPhone 7" || device == "iPhone 8" || device == "Simulator iPhone 7" {
                imgview.pin(a: .top, b: .center, ac: 195, bc: 0, w: 130, h: 130, to: nil)
                main.pinTo(imgview, position: .bottom, h: 290, w: view.frame.width - 100, margin: 40, sides: 30)
            } else { // IPHONE 6S, XS...
                //  main.stretch(top: imgview, left: nil, right: nil, bottom: nil, padding: [40, 65, 65, 80]) // top 80 ???
                imgview.pin(a: .top, b: .center, ac: 195, bc: 0, w: 130, h: 130, to: nil)
                main.pinTo(imgview, position: .bottom, h: 350, w: view.frame.width - 100, margin: 40, sides: 30)
                // or top 140 ?? if bad ?
            }
            
            
            
            // togglebtn.pin(a: .bottom, b: .center, ac: 30, bc: 0, w: view.frame.width, h: 30, to: nil)
        }
        
    }
}


extension SignController { // signing up
    func constrainUI(){ // CALL
        
        imgview.pin(a: .top, b: .right, ac: 70, bc: 20, w: 90, h: 90, to: nil)
        //  lbl.pin(a: .top, b: .left, ac: 50, bc: 0, w: view.frame.width, h: 50, to: nil)
        
        let c = Checker()
        
        if c.isIpad() {
        sbtn.pin(a: .bottom, b: .center, ac: 60, bc: 0, w: view.frame.width / 2, h: 40, to: nil)
        tableView.bottomPin(top: 50)
        } else {
        sbtn.pin(a: .bottom, b: .center, ac: 24, bc: 0, w: view.frame.width / 1.7, h: 40, to: nil) // what baout SE
        tableView.bottomPin(top: 50)
        }
        
        
        let device = UIDevice.modelName
        
        if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
            fillFields.pin(a: .top, b: .right, ac: 5, bc: 3, w: 80, h: 30, to: nil) // or 10
        }
        
        
        let co = Checker()
        if co.isIpad() || co.isBiggestIpad() {
            fillFields.pin(a: .top, b: .right, ac: 30, bc: 40, w: 80, h: 30, to: nil) // LOG IN btn
        } else {
            fillFields.pin(a: .top, b: .right, ac: 20, bc: 3, w: 80, h: 30, to: nil) // put to else after device
        }
        
        
        hidebtn.pin(a: .top, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 50, to: nil)
        //  backimg.ignorePin(a: .top, dist: 0, w: view.frame.width, h: view.frame.height)
        
        
        
        
    }
}


extension LogController {
    func constrainUI(){
        
        loglbl.pin(a: .top, b: .center, ac: 60, bc: 0, w: view.frame.width, h: 50, to: nil)
        
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
            tosign.pin(a: .top, b: .center, ac: 320, bc: 0, w: 200, h: 30, to: nil)
            logfields.centerAPin(margin: 380, top: 110, height: 110) // make fields more shrunk
            logsbtn.pin(a: .top, b: .center, ac: 263, bc: 0, w: 155, h: 45, to: nil)
        } else { // we are on an iPhone
            tosign.pin(a: .top, b: .center, ac: 290, bc: 0, w: 200, h: 30, to: nil)
            logfields.centerAPin(margin: 60, top: 90, height: 100) // 80
            logsbtn.pin(a: .top, b: .center, ac: 230, bc: 0, w: 155, h: 45, to: nil)
        }
        
    }
}


extension DetailController{
    func constrainUI(){
        rtitle.pin(a: .top, b: .left, ac: 40, bc: 10, w: view.frame.width, h: 30, to: nil)
        back.pin(a: .top, b: .left, ac: 10, bc: 10, w: 60, h: 30, to: nil)
    }
}


extension MatchCell {
    func constrain(){
        lstack.pin(a: .top, b: .left, ac: 0, bc: 0, w: frame.width, h: 30, to: self)
        
        let v = UIView()
        v.backgroundColor = .orange
        v.alpha = 0.4
        addSubview(v)
        v.pin(a: .top, b: .left, ac: 0, bc: 0, w: frame.width, h: 30, to: self)
    }
    
}


extension ChatController {
    func constrainUI(){
        // askfield.pin(a: .top, b: .center, ac: 380, bc: 0, w: view.frame.width - 30, h: 30, to: nil)
        // send.pin(a: .top, b: .left, ac: 390, bc: 20, w: 150, h: 30, to: nil)
        //  nameLabel.pin(a: .top, b: .left, ac: 14, bc: 40, w: 210, h: 90, to: nil)
        // u.pin(a: .top, b: .left, ac: 19, bc: 25, w: view.frame.width, h: 80, to: nil)
        //   emailLabel.pin(a: .top, b: .left, ac: 60, bc: 15, w: 170, h: 45, to: nil)
        
        // back.pin(a: .top, b: .left, ac: 7, bc: 4, w: 90, h: 30, to: nil) // lower
        
    }
}

func autoHeight(text:String, font: UIFont, width: CGFloat) -> CGFloat {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
}

/*
 extension QAController {
 func constrainUI(){
 askfield.pin(a: .top, b: .left, ac: 330, bc: 10, w: 200, h: 30, to: nil)
 send.pin(a: .top, b: .left, ac: 350, bc: 20, w: 150, h: 30, to: nil)
 lbl.pin(a: .top, b: .left, ac: 4, bc: 20, w: view.frame.width, h: 70, to: nil)
 tableView.pin(a: .top, b: .left, ac: 60, bc: 0, w: view.frame.width, h: 220, to: nil)
 postview.pin(a: .bottom, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 220, to: nil)
 background.ignorePin(a: .top, dist: 0, w: view.frame.width, h: 200)
 }
 }
 */

extension GroupController {
    func constrainUI(){
        tableView.bottomPin(top: 100)
        
        let c = Checker()
        
        if c.isIpad() == true { // show whole name height
            titlel.pin(a: .top, b: .left, ac: 20, bc: 16, w: view.frame.width, h: 52, to: nil)
        } else {
            titlel.pin(a: .top, b: .left, ac: 35, bc: 16, w: view.frame.width, h: 45, to: nil)
        }
        
        
    }
}



extension AllController {
    func constrainUI(){
        tableView.bottomPin(top: 160)
        
        let c = Checker()
        
        if c.isIpad() == true { // show whole name height
            titlel.pin(a: .top, b: .left, ac: 20, bc: 16, w: view.frame.width, h: 52, to: nil)
        } else {
            titlel.pin(a: .top, b: .left, ac: 35, bc: 16, w: view.frame.width, h: 45, to: nil)
        }
    }
}




//
//  MatchCell.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit



class RaceCell: UITableViewCell {
    
  //  let nameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
       
        
        let c = Checker()
        
        if c.isIpad() {
           self.textLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        } else {
            self.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        }
        
       // nameLabel.font = UIFont.boldSystemFont(ofSize: <#T##CGFloat#>)
    }
    
    func updateUI(text: String, allRaces: [String], result: String){
        self.textLabel?.text = text
        
        if allRaces.contains(result) {
            self.textLabel?.textColor = hex("#3498db")
        } else {
            self.textLabel?.textColor = UIColor.black
        }
    }
}




class MatchCell: UITableViewCell {
    
    let lstack = UIStackView()
    let nameLabel = UILabel()
    let locationLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        [nameLabel, locationLabel, timeLabel].forEach {$0.textAlignment = .center}
        lstack.addArrangedSubview(nameLabel)
        lstack.addArrangedSubview(locationLabel)
        lstack.addArrangedSubview(timeLabel)
        addSubview(lstack)
        constrain()
    }
    
    
    func updateUI(name: String, location: String, time1: Int, time2: Int?) {
        nameLabel.text = name
        locationLabel.text = location
        let t = Time(seconds: time1)
        timeLabel.text = t.shortTime
    }
}





class UCell: UITableViewCell {
    
    var emailLabel = UILabel()
    var slabel = UILabel()
    var rlabel = UILabel()
    var lstack = UIStackView()
    var cstack = UIStackView()
    var exlabel = UILabel()
    
    var imgview = Rounded()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        
        let c = Checker()
        
        
        
        
        
        // emailLabel.textColor = .white
        // addSubview(slabel)
       // addSubview(emailLabel) UNCOM ???
        // addSubview(rlabel)
        
        
        if c.isIpad() || c.isBiggestIpad() {
            [slabel, rlabel, exlabel].forEach {$0.font = UIFont.boldSystemFont(ofSize: 25)}
            emailLabel.font = UIFont.boldSystemFont(ofSize: 34)
        } else {
            [slabel, rlabel, exlabel].forEach {$0.font = UIFont.boldSystemFont(ofSize: 18)}
            emailLabel.font = UIFont.boldSystemFont(ofSize: 29)
        }
        
        
        
        //imgview.image = UIImage(named: "ocean.jpg")
        addSubview(imgview)
        
        let swimtitle = UILabel()
        swimtitle.text = "Swim"
        
        let runtitle = UILabel()
        runtitle.text = "Run"
        
        let experiencetitle = UILabel()
        experiencetitle.text = "Races"
        
       // [swimtitle, runtitle, experiencetitle].forEach {lstack.addArrangedSubview($0)}
     
        
      /*  lstack.distribution = .fillEqually
        lstack.spacing = 43.0
        lstack.alignment = .center*/
        
        // swimstack, runstack, racesstack
        
        let swimstack = UIStackView()
        swimstack.axis = .vertical
        swimstack.addArrangedSubview(swimtitle)
        swimstack.addArrangedSubview(slabel)
        
        let runstack = UIStackView()
        runstack.axis = .vertical
        runstack.addArrangedSubview(runtitle)
        runstack.addArrangedSubview(rlabel)
        
        let expstack = UIStackView()
        expstack.axis = .vertical
        expstack.addArrangedSubview(experiencetitle)
        expstack.addArrangedSubview(exlabel)
        
        
        
       // [slabel, rlabel, exlabel].forEach{cstack.addArrangedSubview($0)}
        [swimtitle, runtitle, experiencetitle].forEach {$0.textAlignment = .center; $0.textColor = .black}
        [slabel, rlabel, exlabel].forEach {$0.textAlignment = .center; $0.textColor = .black}
        /*cstack.distribution = .fillEqually
        cstack.spacing = 43.0 // ???
        cstack.alignment = .center*/
        
        
        let final = UIStackView(arrangedSubviews: [swimstack, runstack, expstack])
        final.axis = .horizontal
        final.alignment = .center // leading
       
      
        final.distribution = .equalCentering
       // addSubview(final)
        
        let mega = UIStackView()
        mega.axis = .vertical
        mega.addArrangedSubview(emailLabel)
        mega.addArrangedSubview(final)
        addSubview(mega)
        
        if c.isIpad() || c.isBiggestIpad() {
            [swimtitle, runtitle, experiencetitle].forEach {$0.font = UIFont.boldSystemFont(ofSize: 20)}
            emailLabel.textAlignment = .center
         
             mega.pin(a: .top, b: .center, ac: 70, bc: 0, w: 380, h: 120, to: self)
             imgview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                imgview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imgview.widthAnchor.constraint(equalToConstant: 90),
                imgview.heightAnchor.constraint(equalToConstant: 90),
                imgview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
                ])
          
        } else {
            let dev = UIDevice.modelName
            
            if dev == "iPhone SE" || dev == "iPhone 5s" || dev == "Simulator iPhone SE" || dev == "Simulator iPhone 5s" {
                mega.pin(a: .top, b: .left, ac: 6, bc: 95, w: 200, h: 90, to: self)
                imgview.pin(a: .top, b: .left, ac: 20, bc: 15, w: 60, h: 60, to: self)
            } else {
                mega.pin(a: .top, b: .left, ac: 6, bc: 100, w: 220, h: 90, to: self)
                imgview.pin(a: .top, b: .left, ac: 20, bc: 18, w: 60, h: 60, to: self)
            }
        }
        
       // final.pin(a: .top, b: .left, ac: 55, bc: 90, w: frame.width - 40, h: 70, to: self)
    }
    
    
    func updateUI(email: String, swim: String, run:String, color: String, experince: String, image: UIImage, nowrite: String){
        
        imgview.image = image
        
        if email != nowrite {
            emailLabel.text = email
            self.backgroundColor = .white
            
            slabel.text = swim
            rlabel.text = run
            exlabel.text = experince
            
            
            if let exp = Int(experince){
             // experince was nil
            
            if exp < 10 { // 99
                 exlabel.text = "\(experince) "
            }
            }
            
            
            
        } else {
            self.selectionStyle = .none
        }
    }
    
    
}





class CCell: UITableViewCell {
    
    var emailLabel = UILabel()
    var slabel = UILabel()
    var rlabel = UILabel()
    var lstack = UIStackView()
    var cstack = UIStackView()
    var exlabel = UILabel()
    
    var imgview = Rounded()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        
        let c = Checker()
        
        
        
        
        
        // emailLabel.textColor = .white
        // addSubview(slabel)
        // addSubview(emailLabel) UNCOM ???
        // addSubview(rlabel)
        
        
        if c.isIpad() || c.isBiggestIpad() {
            [slabel, rlabel, exlabel].forEach {$0.font = UIFont.boldSystemFont(ofSize: 25)}
            emailLabel.font = UIFont.boldSystemFont(ofSize: 34)
        } else {
            [slabel, rlabel, exlabel].forEach {$0.font = UIFont.boldSystemFont(ofSize: 18)}
            emailLabel.font = UIFont.boldSystemFont(ofSize: 29)
        }
        
        
        
        //imgview.image = UIImage(named: "ocean.jpg")
        addSubview(imgview)
        
        let swimtitle = UILabel()
        swimtitle.text = "Swim"
        
        let runtitle = UILabel()
        runtitle.text = "Run"
        
        let experiencetitle = UILabel()
        experiencetitle.text = "Races"
        
        // [swimtitle, runtitle, experiencetitle].forEach {lstack.addArrangedSubview($0)}
        
        
        /*  lstack.distribution = .fillEqually
         lstack.spacing = 43.0
         lstack.alignment = .center*/
        
        // swimstack, runstack, racesstack
        
        let swimstack = UIStackView()
        swimstack.axis = .vertical
        swimstack.addArrangedSubview(swimtitle)
        swimstack.addArrangedSubview(slabel)
        
        let runstack = UIStackView()
        runstack.axis = .vertical
        runstack.addArrangedSubview(runtitle)
        runstack.addArrangedSubview(rlabel)
        
        let expstack = UIStackView()
        expstack.axis = .vertical
        expstack.addArrangedSubview(experiencetitle)
        expstack.addArrangedSubview(exlabel)
        
        
        
        // [slabel, rlabel, exlabel].forEach{cstack.addArrangedSubview($0)}
        [swimtitle, runtitle, experiencetitle].forEach {$0.textAlignment = .center; $0.textColor = .black}
        [slabel, rlabel, exlabel].forEach {$0.textAlignment = .center; $0.textColor = .black}
        /*cstack.distribution = .fillEqually
         cstack.spacing = 43.0 // ???
         cstack.alignment = .center*/
        
        
        let final = UIStackView(arrangedSubviews: [swimstack, runstack, expstack])
        final.axis = .horizontal
        final.alignment = .center // leading
        
        
        final.distribution = .equalCentering
        // addSubview(final)
        
        let mega = UIStackView()
        mega.axis = .vertical
        mega.addArrangedSubview(emailLabel)
        mega.addArrangedSubview(final)
        addSubview(mega)
        
        if c.isIpad() || c.isBiggestIpad() {
            [swimtitle, runtitle, experiencetitle].forEach {$0.font = UIFont.boldSystemFont(ofSize: 20)}
            emailLabel.textAlignment = .center
            //   emailLabel.pin(a: .top, b: .center, ac: 31, bc: 0, w: 200, h:35, to: self)
            
            // let v = UIView()
            // v.alpha = 0.4
            //v.backgroundColor = UIColor.orange
            // addSubview(v)
            
            
            
            //   v.pin(a: .top, b: .center, ac: 83, bc: 0, w: 450, h: 120, to: self)
            mega.pin(a: .top, b: .center, ac: 70, bc: 0, w: 380, h: 120, to: self)
            
            // imgview.pin(a: .top, b: .left, ac: (self.frame.height - 41.5)  , bc: 40, w: 83, h: 83, to: self)
            
            imgview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                imgview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imgview.widthAnchor.constraint(equalToConstant: 90),
                imgview.heightAnchor.constraint(equalToConstant: 90),
                imgview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
                
                ])
            
        } else {
            //  emailLabel.pin(a: .top, b: .left, ac: 6, bc: 110, w: 200, h:35, to: self)
            // final.pin(a: .top, b: .left, ac: 6, bc: 100, w: 220, h: 90, to: self)
            
            let dev = UIDevice.modelName
            
            if dev == "iPhone SE" || dev == "iPhone 5s" || dev == "Simulator iPhone SE"{
                mega.pin(a: .top, b: .left, ac: 6, bc: 95, w: 200, h: 90, to: self)
                imgview.pin(a: .top, b: .left, ac: 20, bc: 15, w: 60, h: 60, to: self)
            } else {
                mega.pin(a: .top, b: .left, ac: 6, bc: 100, w: 235, h: 90, to: self)
                imgview.pin(a: .top, b: .left, ac: 20, bc: 18, w: 60, h: 60, to: self)
            }
            
            
        }
        
        // final.pin(a: .top, b: .left, ac: 55, bc: 90, w: frame.width - 40, h: 70, to: self)
    }
    
    
    func updateUI(email: String, swim: String, run:String, color: String, experince: String, image: UIImage, nowrite: String){
        
        imgview.image = image
        
        if email != nowrite {
            emailLabel.text = email
            self.backgroundColor = .white
            
            slabel.text = swim
            rlabel.text = run
            exlabel.text = experince
            
            if Int(experince)! < 10 {
                exlabel.text = "\(experince) "
            }
            
            
            
        } else {
            self.selectionStyle = .none
        }
    }
    
    
}




//
//  MessageCell.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 18/02/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit


class MessageCell: UITableViewCell {
  
    
    
    
    
    
    let stack: UIStackView = {
      
        let titlel: UILabel = {
            let l = UILabel()
            l.font = UIFont.boldSystemFont(ofSize: 23)
            return l
        }()
        
        let artistl: UILabel = {
            let l = UILabel()
            l.textColor = .gray
            l.font = UIFont.boldSystemFont(ofSize: 17)
            return l
        }()
        
        let st = UIStackView()
        st.axis = .vertical
        st.addArrangedSubview(titlel)
        st.addArrangedSubview(artistl)
        return st
    }()
    
    
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.addSubview(stack)
        stack.pin(a: .top, b: .left, ac: 10, bc: 18, w: self.frame.width, h: self.frame.height, to: self)
        
// constrain
    }
    
    func updateUI(name: String, message: String){
        let art = stack.arrangedSubviews[0] as! UILabel
        art.text = name
        
        let author = stack.arrangedSubviews[1] as! UILabel
        author.text = message
    }
}
/*
 
 
 class RaceCell: UITableViewCell {
 
 //  let nameLabel = UILabel()
 
 
 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
 super.init(style: style, reuseIdentifier: reuseIdentifier)
 setup()
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 func setup(){
 
 
 let c = Checker()
 
 if c.isIpad() {
 self.textLabel?.font = UIFont.boldSystemFont(ofSize: 27)
 } else {
 self.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
 }
 
 // nameLabel.font = UIFont.boldSystemFont(ofSize: <#T##CGFloat#>)
 }
 
 func updateUI(text: String, allRaces: [String], result: String){
 
 */



//
//  MSCell.swift
//  Sportify
//
//  Created by Filip Vabroušek on 01/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class MSCell:UICollectionViewCell {
    var tv = UITextView()
    
    
    
    func updateUI(m: String){
        tv.text = m
        tv.font = .systemFont(ofSize: 16)
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.isSelectable = false
        tv.isEditable = false
        addSubview(tv)
        
        //  var lines = CGFloat(m.count / 37) // one line, etc 32 chcaracters.....
        tv.frame = CGRect(x: 3, y: 2, width: self.frame.width, height: 1000)
    }
}



class CHTCell:UITableViewCell {
    var tv = UITextView()
    
    func getWidth(text:String, tsize: CGFloat) -> (CGFloat, CGFloat) {
        
        let awidth = 300 // 300
        let size = CGSize(width: awidth, height: 1000)
        let attr = [kCTFontAttributeName: UIFont.systemFont(ofSize: tsize)]
        let estframe = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr as [NSAttributedString.Key : Any], context: nil)
        
        // ADD SUBVIEW "messageLabel" and set constraint to it, solve in "CHTcell" subclass
        print("Width: \(estframe.width) text: \(text)")
        let ret = CGSize(width: estframe.width, height: estframe.height)
        
        return (ret.width, ret.height)
        
    }
    
    
    func SESize(text:String, tsize: CGFloat, width: CGFloat) -> (CGFloat, CGFloat){
        let awidth = width // 300
        let size = CGSize(width: awidth, height: 1000)
        let attr = [kCTFontAttributeName: UIFont.systemFont(ofSize: tsize)]
        let estframe = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr as [NSAttributedString.Key : Any], context: nil)
        
        // ADD SUBVIEW "messageLabel" and set constraint to it, solve in "CHTcell" subclass
        print("Width: \(estframe.width) text: \(text)")
        let ret = CGSize(width: estframe.width, height: estframe.height)
        
        return (ret.width, ret.height)
    }
    
    
    
    
    
    
    
    
    
    func updateUI(m: String, isIncoming: Bool){
        tv.text = m
        tv.font = .systemFont(ofSize: 17)
        tv.isUserInteractionEnabled = false
      /*  tv.textContainerInset = .zero
        tv.textContainer.lineFragmentPadding = 0 */
        
        let td = getWidth(text: m, tsize: 17)
        
        
        let device = UIDevice.modelName
        print("Model: \(device)")
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: INCOMING
        if isIncoming == true {
            tv.backgroundColor = hex("#3498db") // left side
            tv.textColor = .white
            tv.isScrollEnabled = false
            tv.isSelectable = false
            tv.isEditable = false
           
            if m.count <= 3 {
            tv.layer.cornerRadius = 10.0
            } else {
            tv.layer.cornerRadius = 15.0
            }
         
            tv.textContainerInset = .zero // Yesss !!!
            tv.textContainerInset = UIEdgeInsets(top: 3.8, left: 1.5, bottom: 0.0, right: 0.0)
          
            
            addSubview(tv)
   
            
          
            
            let c = Checker()
            if c.isIpad(){
                if m.count < 40 {
                    tv.frame = CGRect(x: 120.0, y: 12.0, width: td.0 + 15, height: td.1 + 9)
                } else {
                    tv.frame = CGRect(x: 120.0, y: 12.0, width: td.0 + 15, height: td.1 + 25)
                }
            } else {
                if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
                    
                    if m.count < 6 {
                        tv.frame = CGRect(x: 0.0, y: 2.0, width: self.frame.width / 4, height: self.frame.height - 2.0)
                    } else if m.count < 10{
                        tv.frame = CGRect(x: 0.0, y: 2.0, width: self.frame.width / 3.1, height: self.frame.height - 2.0)
                    }
                        
                    else {
                        tv.frame = CGRect(x: 0.0, y: 2.0, width: self.frame.width - self.frame.width / 3, height: self.frame.height - 2.0)
                    }
                    
                    
                } else { // ----------------- iPhone 8, XS (do not touch) OUTCOMING
                    
                    if m.count < 40 {
                        tv.frame = CGRect(x: 0.0, y: 12.0, width: td.0 + 15, height: td.1 + 9)
                    } else {
                        tv.frame = CGRect(x: 0.0, y: 12.0, width: td.0 + 15, height: td.1 + 25)
                    }
                }
            }
            
              // -------------iPhone SE
            
        
            
            
            
            
            
            
            
            
            
            
            
            
            // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: OUTCOMING
        } else {
            tv.backgroundColor = hex("#ecf0f1")
            tv.textColor = .black
            tv.isScrollEnabled = false
            tv.isSelectable = false
            tv.isEditable = false
          
            addSubview(tv)
            
            if m.count <= 4 {
                tv.layer.cornerRadius = 10.0
            } else {
                tv.layer.cornerRadius = 15.0
            }
            
            let c = Checker()
            
            if c.isIpad(){
                if m.count < 40 {
                 tv.frame = CGRect(x: self.frame.width - (td.0 + 15) - 120, y: 2, width: td.0 + 15, height: td.1 + 9)
                } else {
                     tv.frame = CGRect(x: self.frame.width - (td.0 + 15) - 120, y: 2, width: td.0 + 15, height: td.1 + 25)
                    //   tv.frame = CGRect(x: self.frame.width - (td.0 + 15), y: 2, width: td.0 + 15, height: td.1 + 25) // or 25
                }
            } else {
                // -------------iPhone SE
                if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
                    
                    if m.count < 6 {
                        tv.frame = CGRect(x: self.frame.width / 2 + (self.frame.width / 4), y: 2.0, width: self.frame.width / 2 - self.frame.width / 4, height: self.frame.height - 2.0)
                    } else if m.count < 10 {
                        tv.frame = CGRect(x: self.frame.width / 2 + (self.frame.width / 3.1), y: 2.0, width: self.frame.width / 2 - self.frame.width / 3.1, height: self.frame.height - 2.0)
                    } else {
                        tv.frame = CGRect(x: self.frame.width / 3, y: 2.0, width: self.frame.width - self.frame.width / 3, height: self.frame.height - 2.0) // x: ..w/2
                    }
                    
                } else {  // ----------------- iPhone 8, XS, iPad
                   //
                    if m.count < 40 {
                      tv.frame = CGRect(x: self.frame.width - (td.0 + 15), y: 2, width: td.0 + 15, height: td.1 + 9) // or 25
                    } else {
                       tv.frame = CGRect(x: self.frame.width - (td.0 + 15), y: 2, width: td.0 + 15, height: td.1 + 25) // or 25
                    }
                
                }
                
            }
            
         
        }
    }
    
    
    
    
}




//
//  ResponseCell.swift
//  Sportify
//
//  Created by Filip Vabroušek on 07/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class ResponseCell: UITableViewCell {
    var label = UILabel()
    var rlabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(label)
        addSubview(rlabel)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        rlabel.font = UIFont.boldSystemFont(ofSize: 14)
        label.pin(a: .top, b: .left, ac: 20, bc: 20, w: 210, h: 30, to: self)
        rlabel.pin(a: .top, b: .left, ac: 40, bc: 20, w: 210, h: 30, to: self)
    }
    
    
    func updateUI(q:String, a:String){
        label.text = q
        rlabel.text = a
    }
}




//
//  TabController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let match = GroupController()
        match.tabBarItem = UITabBarItem(title: "Races", image: UIImage(named: "refresh.png"), tag: 0)
        
        let edit = EditController()
        edit.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "stpwa.png"), tag: 1)
        
        let all = AllController()
        all.tabBarItem = UITabBarItem(title: "Competitors", image: UIImage(named: "list-icon.png"), tag: 2)
        /* let qa = QAController()
         qa.tabBarItem = UITabBarItem(title: "Q & A", image: UIImage(named: "rss-7.png"), tag: 3) */
        
        let messages = MessageController()
        messages.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "envelope.png"), tag: 3)
        
        let list = [match, all, messages, edit]
        viewControllers = list
        selectedViewController = match
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
}




//
//  SignUpController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 28/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging


class RO:NSObject {
    var value: String = "empty"
    var isSelected: Bool = false
    
    init(value: String, isSelected: Bool){
        self.value = value
        self.isSelected = isSelected
    }
}

class SignController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let supported = ["Zlin", "Otrokovice", "Prague"]
    var new = [String]()
    var results = [RO]()
    
    let rso = ["ABW","AFG","AGO","AIA","ALB","AND","ANT","ARE","ARG","ARM","ASM","ATA","ATF","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BVT","BWA","CAF","CAN","CCK","CHE","CHL","CHN","CIV","CMR","COD","COG","COK","COL","COM","CPV","CRI","CUB","CXR","CYM","CYP","CZE","DJI","DMA","DNK","DOM","DZA","ECU","EGY","ERI","ESH","ESP","EST","ETH","EUE","FIN","FJI","FLK","FRA","FRO","FSM","GAB","GBR","GEO","GER","GHA","GIB","GIN","GLP","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUF","GUM","GUY","HKG","HMD","HND","HRV","HTI","HUN","IDN","IND","IOT","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KNA","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MCO","MDA","MDG","MDV","MEX","MHL","MKD","MLI","MLT","MMR","MNE","MNG","MNP","MOZ","MRT","MSR","MTQ","MUS","MWI","MYS","MYT","NAM","NCL","NER","NFK","NGA","NIC","NIU","NLD","NOR","NPL","NRU","NZL","OMN","PAK","PAN","PCN","PER","PHL","PLW","PNG","POL","PRI","PRK","PRT","PRY","PSE","PYF","QAT","REU","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SGS","SHN","SJM","SLB","SLE","SLV","SMR","SOM","SPM","SRB","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCA","TCD","TGO","THA","TJK","TKL","TKM","TLS","TON","TTO","TUN","TUR","TUV","TWN","TZA","UGA","UKR","UMI","URY","USA","UZB","VAT","VCT","VEN","VGB","VIR","VNM","VUT","WLF","WSM","YEM","ZAF","ZMB","ZWE"]
    
    
    var raceids = [String]() // because conceating
    var idx = -1
    var already = [Int]()
    var selected: UIImage?
    var passgen = ""
    
    // var filter = [String]()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "RACell")
        // t.isHidden = true
        t.alpha = 0
        return t
    }()
    
    
    lazy var terms: UIButton = {
        let b = UIButton()
        b.setTitle("By signing up, you agree with terms >", for: [])
        b.setTitleColor(UIColor.white, for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.addTarget(self, action: #selector(self.terms(sender:)), for: .touchUpInside)
        return b
    }()
    
    /*
     let termsl: UILabel = {
     let l = UILabel()
     l.text = "By signing up, you agree with terms."
     l.font = UIFont.boldSystemFont(ofSize: 14)
     l.textColor = .white
     l.textAlignment = .center
     return l
     }()*/
    
    
    /*
     var backimg: UIImageView = {
     let b = UIImageView()
     b.image = UIImage(named: "srun.png")
     b.contentMode = .scaleAspectFill
     return b
     }()*/
    
    
    var tintc:UIColor = .black
    
    lazy var fillFields: UIButton = {
        let b = UIButton()
        b.setTitle("Log in", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.addTarget(self, action: #selector(self.temp(sender:)), for: .touchUpInside)
        b.setTitleColor(UIColor.white, for: [])
        return b
    }()
    
    /*
     let lbl: UILabel = {
     let l = UILabel()
     l.textColor = .white
     l.font = UIFont.boldSystemFont(ofSize: 36)
     l.text = "Create account"
     l.textAlignment = .center
     return l
     }()*/
    
    
    
    let nfield: UITextField = {
        let f = UITextField()
        f.textAlignment = .center
        f.autocapitalizationType = .none
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "email"
        f.backgroundColor = .black
        f.layer.cornerRadius = 4.0
        f.attributedPlaceholder = NSAttributedString(string: "e-mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return f
    }()
    
    let pfield: UITextField = {
        let f = UITextField()
        f.textAlignment = .center
        f.autocapitalizationType = .none
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "password"
        f.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        // f.isSecureTextEntry = true
        f.backgroundColor = .black
        f.layer.cornerRadius = 4.0
        return f
    }()
    
    
    
    let nicknamefield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.textAlignment = .center
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "name"
        // f.backgroundColor = .black
        
        f.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        
        /*  let border = CALayer()
         let width = CGFloat(2.0)
         border.borderColor = UIColor.darkGray.cgColor
         border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
         
         border.borderWidth = width
         textField.layer.addSublayer(border)
         textField.layer.masksToBounds = true
         */
        
        
        return f
    }()
    
    /*
     let swimfield: UITextField = {
     let f = UITextField()
     f.font = UIFont.boldSystemFont(ofSize: 21)
     f.placeholder = "Enter your current 1k swimming best time"
     return f
     }()*/
    
    let minSwim: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "••"
        f.attributedPlaceholder = NSAttributedString(string: "••", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        f.keyboardType = .numberPad
        f.textAlignment = .center
        f.textColor = .black
        f.layer.cornerRadius = 4.0
        return f
    }()
    
    let secSwim: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "••"
        f.attributedPlaceholder = NSAttributedString(string: "••", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        f.keyboardType = .numberPad
        f.textAlignment = .center
        f.textColor = .black
        f.layer.cornerRadius = 4.0
        return f
    }()
    
    
    let minRun: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "••"
        f.attributedPlaceholder = NSAttributedString(string: "••", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        f.keyboardType = .numberPad
        f.textAlignment = .center
        f.textColor = .black
        f.layer.cornerRadius = 4.0
        return f
    }()
    
    let secRun: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        //   f.placeholder = "••"
        f.attributedPlaceholder = NSAttributedString(string: "••", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        f.keyboardType = .numberPad
        f.textAlignment = .center
        f.textColor = .black
        f.layer.cornerRadius = 4.0
        return f
    }()
    
    
    let dot: UILabel = {
        let l = UILabel()
        l.text = ":"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    let dota: UILabel = {
        let l = UILabel()
        l.text = ":"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    
    let infoswim: UILabel = {
        let l = UILabel()
        l.text = "1k swim:"
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textColor = .white
        return l
    }()
    
    let inforun: UILabel = {
        let l = UILabel()
        l.text = "10k run: " // -one " "
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textColor = .white
        return l
    }()
    
    
    let runfield: UITextField = {
        let f = UITextField()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        f.placeholder = "Enter your current 10k running best time"
        return f
    }()
    
    let countfield: UITextField = {
        let f = UITextField()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        // f.placeholder = "finished swimruns"
        
        f.textAlignment = .center
        f.keyboardType = .numberPad
        f.backgroundColor = .black
        f.layer.cornerRadius = 4.0
        f.attributedPlaceholder = NSAttributedString(string: "swimruns finished", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return f
    }()
    
    
    
    lazy var sbtn: UIButton = {
        let b = UIButton()
        b.setTitle("            Sign up           ", for: [])
        // b.setTitle("Creating an account.", for: [])
        
        
        b.addTarget(self, action: #selector(signup(sender:)), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.setTitleColor(hex("#3498db"), for: [])
        // b.frame = CGRect(x: 30, y: 30, width: 120, height: 30)
        b.backgroundColor = UIColor.white
        b.layer.cornerRadius = 20.0
        return b
    }()
    
    let imgview: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    
    
    
    lazy var hidebtn: UIButton = {
        let b = UIButton()
        b.setTitle("Go back", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.addTarget(self, action: #selector(toggletv(sender:)), for: .touchUpInside)
        //  b.isHidden = true
        b.alpha = 0
        b.backgroundColor = hex("#e74c3c")
        return b
    }()
    
    
    
    lazy var genderSegment: UISegmentedControl = {
        let data = ["♂", "♀"]
        let s = UISegmentedControl(items: data)
        s.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .selected) // .selected
        s.tintColor = .black
        s.addTarget(self, action: #selector(self.segmentaction(sender:)), for: .valueChanged)
        return s
    }()
    
    
    
    
    
    
    var stack: UIStackView = {
        
        let b = UIButton()
        // 📷
        b.backgroundColor = UIColor.white
        b.setTitle("Image", for: []) // 📷
        b.addTarget(self, action: #selector(upload(sender:)), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        b.setTitleColor(hex("#3498db"), for: [])
        b.layer.cornerRadius = 4.0
        
        let c = UIButton()
        c.backgroundColor = UIColor.white
        c.setTitle("Country", for: [])
        c.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        c.addTarget(self, action: #selector(toggletv(sender:)), for: .touchUpInside)
        c.setTitleColor(hex("#3498db"), for: [])
        c.layer.cornerRadius = 4.0
        
        
        
        
        let g = UIButton()
        // 📷
        g.backgroundColor = UIColor.white
        g.setTitle("Gender", for: []) // 📷
        g.addTarget(self, action: #selector(selectGender(sender:)), for: .touchUpInside)
        g.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        g.setTitleColor(hex("#3498db"), for: [])
        g.layer.cornerRadius = 4.0
        
        let s = UIStackView()
        s.axis = .horizontal // horizotal
        s.distribution = .fillEqually
        s.spacing = 10.0
        s.addArrangedSubview(b)
        s.addArrangedSubview(c)
        s.addArrangedSubview(g)
        return s
    }()
    
    
    
    
    
    var country = ""
    var gender = ""
    
    @objc func selectGender(sender: UIButton!){
        let a = UIAlertController(title: "Gender", message: "Select a gender", preferredStyle: .actionSheet)
        
        let man = UIAlertAction(title: "Man", style: .default) { (action) in
            self.gender = "man"
            sender.setTitle("Man", for: [])
        }
        
        let woman = UIAlertAction(title: "Woman", style: .default) { (action) in
            self.gender = "woman"
            sender.setTitle("Woman", for: [])
        }
        
        a.addAction(man)
        a.addAction(woman)
        
        
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
            a.popoverPresentationController?.sourceView = self.view
            a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            self.present(a, animated: true, completion: nil)
        } else {
            self.present(a, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    /*
     lazy var tologin: UIButton = {
     let b = UIButton()
     b.setTitle("LOG IN", for: [])
     b.addTarget(self, action: #selector(skip(sender:)), for: .touchUpInside)
     b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
     b.frame = CGRect(x: 30, y: 30, width: 120, height: 30)
     return b
     }()*/
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = hex("#3498db")
        self.navigationController?.navigationBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        tableView.reloadData() // xx
        
        [sbtn, runfield, fillFields,/*  imagebtn,*/ imgview, hidebtn, tableView].forEach {view.addSubview($0)}
        newStack()
        constrainUI()
    }
    
    
    
    @objc func toggletv(sender: UIButton!){
        
        if new.count > 0 {
            let btn = stack.arrangedSubviews[1] as! UIButton
            btn.setTitle(new[0], for: [])
            //  btn.titleLabel?.textColor = UIColor.green
        }
        
        
        
        if tableView.alpha == 1 {
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 0// hide table view
                self.hidebtn.alpha = 0 // show hider
                self.main.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1// hide table view
                self.hidebtn.alpha = 1 // show hider
                self.main.alpha = 0
            }
        }
    }
    
    
    
    @objc func segmentaction(sender: UISegmentedControl){
        let gender = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        passgen = gender
        print("Gender is \(gender)")
    }
    
    
    @objc func upload(sender: UIButton){
        
        /*  nicknamefield.text = "Noone"
         nfield.text = "noone@a.com"
         pfield.text = "123456"
         secRun.text = "33"
         minRun.text = "20"
         
         secSwim.text = "19"
         minSwim.text = "20"
         
         countfield.text = "3"
         
         */
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let edited = info[.editedImage] as? UIImage {
            selected = edited
            
        } else if let data = info[.originalImage] as? UIImage {
            selected = data
            
        }
        
        let btn = stack.arrangedSubviews[0] as! UIButton
        btn.setTitle("✔", for: [])
        btn.titleLabel?.textColor = UIColor.green
        
        
        print("SIZE: \(selected!.size)")
        // imgview.image = selected!
        // imagebtn.setTitle("change profile image", for: [])
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    @objc func terms(sender: UIButton!){
        /* let url = URL(string: "https://filipvabrousek.weebly.com/privacy.html")
         UIApplication.shared.open(url!, options: [:], completionHandler: nil)*/
        let pr = PrivacyController()
        self.present(pr, animated: true, completion: nil)
    }
    
    @objc func temp(sender: UIButton!){
        let vc = LogController()
        present(vc, animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let fields =  [nicknamefield, nfield, pfield, countfield]
        
        fields.forEach {
            $0.textColor = .black
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 2.0
            $0.backgroundColor = UIColor.white // clear
            $0.autocorrectionType = .no
        }
        
        
        
    }
    
    
    let main = UIStackView()
    
    
    func newStack(){
        let st = UIStackView()
        st.distribution = .fillProportionally
        
        let tst = UIStackView()
        tst.distribution = .equalSpacing
        tst.addArrangedSubview(minSwim)
        tst.addArrangedSubview(dot)
        tst.addArrangedSubview(secSwim)
        
        st.addArrangedSubview(infoswim)
        st.addArrangedSubview(tst)
        
        let rt = UIStackView()
        rt.distribution = .fillProportionally
        rt.spacing = 0.5
        
        let trt = UIStackView()
        trt.distribution = .equalSpacing
        trt.addArrangedSubview(minRun)
        trt.addArrangedSubview(dota)
        trt.addArrangedSubview(secRun)
        
        rt.addArrangedSubview(inforun)
        rt.addArrangedSubview(trt)
        
        
        
        
        
        [minRun, minSwim, secRun, secSwim].forEach {
            let c  = Checker()
            if c.isIpad() || c.isBiggestIpad(){
                $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
            } else {
                $0.widthAnchor.constraint(equalToConstant: 60).isActive = true
            }
            
            $0.backgroundColor =  .white
        }
        
        
        
        
        main.axis = .vertical
        main.distribution = .fillEqually //.equalSpacing
        main.spacing = 20 // or 23 or 10
        main.addArrangedSubview(nicknamefield)
        main.addArrangedSubview(nfield)
        main.addArrangedSubview(pfield)
        main.addArrangedSubview(countfield)
        main.addArrangedSubview(st)
        main.addArrangedSubview(rt)
        
        // main.addArrangedSubview(imagebtn)
        //  main.addArrangedSubview(togglebtn)
        
        main.addArrangedSubview(stack)
        
        // main.addArrangedSubview(termsl)
        main.addArrangedSubview(terms)
        view.addSubview(main)
        // rt.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        [minRun, minSwim, secRun, secSwim, main].forEach { el in
            if el is UILabel {
                el.tintColor = UIColor.white
            }
        }
        
        
        
        
        let c = Checker()
        
        let device = UIDevice.modelName
        if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s"{
            main.pin(a: .top, b: .center, ac: 238, bc: 0, w: 270, h: 400, to: nil)
            main.spacing = 16
        }
        else if c.isIpad() || c.isBiggestIpad() {
            main.centerIn(nil, width: 410, height: 600)
        }
        else {
            main.pin(a: .top, b: .center, ac: 305, bc: 0, w: 270, h: 470, to: nil) // vs 330
        }
        
        
        
        
    }
    
    /*
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     let max = 2
     let ms = minSwim.text! as NSString
     let ss = secSwim.text! as NSString
     
     let sr = secRun.text!
     let mr = minRun.text!
     
     
     
     }
     */
    let usrl = "gs://sportify-a6150.appspot.com"
    
    
    @objc func signup(sender: UIButton!){
        let email = nfield.text!
        let pswd = pfield.text!
        let stime = "\(minSwim.text!):\(secSwim.text!)" // ADD THE SECONDS !!!
        let rtime = "\(minRun.text!):\(secRun.text!)"
        let count = countfield.text!
        
        let rsec = secRun.text!
        let rmin = minRun.text!
        let ssec = secSwim.text!
        let smin = minSwim.text!
        let nickname = nicknamefield.text!
        
        
        // let gender = self.passgen
        
        
        
        
        var errors = ""
        
        if nickname == ""{
            nicknamefield.layer.borderWidth = 1.5
            nicknamefield.layer.borderColor = hex("#e74c3c").cgColor
            //  alert(title: "Nickname", m: "You have to set a nickname")
            errors += "invalid nickname \n"
            errors += "\n"
        } else {
            nicknamefield.layer.borderWidth = 0.0
        }
        
        // shortest acceptable email a@b.c
        
        if email.count < 5 || (email.contains("@") == false) || (email.contains(".") == false) {
            // nfield.backgroundColor = UIColor.red
            nfield.layer.borderWidth = 1.5
            nfield.layer.borderColor = hex("#e74c3c").cgColor
            print("WHERE IS @")
            
            //  alert(title: "Invalid email", m: "Email adress has to contain @")
            errors += "email was not in correct format \n"
            errors += "\n"
            
        } else {
            nfield.layer.borderWidth = 0.0
        }
        
        
        
        if pswd.count < 6 {
            pfield.layer.borderWidth = 1.5
            pfield.layer.borderColor = hex("#e74c3c").cgColor
            
            // alert(title: "Invalid password", m: "Password has to be at least 6 characters long")
            errors += "password has to be at least 6 characters long \n"
            errors += "\n"
        } else {
            pfield.layer.borderWidth = 0.0
        }
        
        
        
        
        if count == ""{
            countfield.layer.borderWidth = 1.5
            countfield.layer.borderColor = hex("#e74c3c").cgColor
            // alert(title: "Swimruns", m: "You have to set finished swimruns count")
            errors += "you have to set finished swimruns count \n"
            errors += "\n"
        } else {
            countfield.layer.borderWidth = 0.0
        }
        
        
        if rsec.count != 2 || Int(rsec)! > 59 {
            secRun.layer.borderWidth = 1.5
            secRun.layer.borderColor = hex("#e74c3c").cgColor
            // alert(title: "Swimruns", m: "You have to set finished swimruns count")
            errors += "running seconds were not in correct format \n"
            errors += "\n"
        } else {
            secRun.layer.borderWidth = 0.0
        }
        
        
        
        if rmin.count != 2 || Int(rmin)! <= 28 || Int(rmin)! >= 99 {
            minRun.layer.borderWidth = 1.5
            minRun.layer.borderColor = hex("#e74c3c").cgColor
            // alert(title: "Swimruns", m: "You have to set finished swimruns count")
            errors += "running minutes were not in correct format \n"
            errors += "\n"
        } else {
            minRun.layer.borderWidth = 0.0
        }
        
        
        if ssec.count != 2 || Int(ssec)! >= 59 {
            secSwim.layer.borderWidth = 1.5
            secSwim.layer.borderColor = hex("#e74c3c").cgColor
            // alert(title: "Swimruns", m: "You have to set finished swimruns count")
            errors += "swimming seconds were not in correct format \n"
            errors += "\n"
        } else {
            secSwim.layer.borderWidth = 0.0
        }
        
        
        if smin.count != 2 || Int(smin)! < 10 || Int(smin)! >= 59 {
            minSwim.layer.borderWidth = 1.5
            minSwim.layer.borderColor = hex("#e74c3c").cgColor
            // alert(title: "Swimruns", m: "You have to set finished swimruns count")
            errors += "swimming minutes were not in correct format \n"
            errors += "\n"
        } else {
            minSwim.layer.borderWidth = 0.0
        }
        
        if gender == "" {
            errors += "Please choose a gender \n"
            errors += "\n"
        }
        
        if country == "" {
            errors += "Please choose your country \n"
            errors += "\n"
        }
        
        
        func ctime(rmin: String, rsec: String, smin: String, ssec: String) -> Bool {
            var allow = true
            
            
            if (rmin.count != 2 || rsec.count != 2 || smin.count != 2 || ssec.count != 2){
                allow = false
            } else {
                if Int(rsec)! <= 59 {
                    
                } else {
                    allow = false
                }
                
                
                
                if Int(rmin)! >= 28 && Int(rmin)! <= 99{
                    
                } else {
                    allow = false
                }
                
                
                if Int(smin)! >= 10 && Int(smin)! <= 59 {
                    
                } else {
                    allow = false
                }
            }
            
            
            
            print("all \(allow)")
            return allow
        }
        
        
        
        
        
        let timecheck = ctime(rmin: rmin, rsec: rsec, smin: smin, ssec: ssec)
        
        if (count == "" || nickname == "" || email == "" || ssec.count != 2 || smin.count != 2 || rsec.count != 2 || rmin.count != 2 || gender == "" || country == "" || timecheck == false) {
            print("TIMECHECK \(timecheck)")
            
            alert(title: "Following errors found: ", m: errors)
        }
        
        
        
        
        if email != "" && nicknamefield.text! != "" && pswd != "" && stime != "" && rtime != "" && count != "" && new.count > 0 && rsec.count == 2 && rmin.count == 2 && ssec.count == 2 && smin.count == 2 && country != "" && gender != "" && timecheck == true {
            
            let ref = Database.database().reference()
            ref.child("Users").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.value) { (snap) in
                if snap.exists() { //
                    let a = Alert()
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in }
                    a.show(on: self, title: "This email is already taken.", messsage: "Please use another email address.", actions: [action])
                    
                } else {
                    
                    sender.titleLabel?.text = "Creating account"
                    
                    Auth.auth().createUser(withEmail: email, password: pswd) { (user, error) in
                        if error != nil {
                            print("Sign up ERROR \(error!.localizedDescription)") // Already used
                        } else {
                            
                            let uid = Auth.auth().currentUser?.uid
                            let ref = Database.database().reference()
                            
                            var str = ""
                            for val in self.new {
                                str.append(val)
                            }
                            
                            let storage = Storage.storage().reference(forURL: self.usrl).child("pimage").child(uid!)
                            
                            
                            var datas:Data?
                            if self.selected == nil {
                                datas = UIImage(named: "ocean.jpg")?.pngData()
                            } else {
                                
                                let r = Resizer(image: self.selected!, to: CGSize(width: 300, height: 300))
                                let e = r.resize()
                                datas = e.pngData()
                            }
                            
                 
                            storage.putData(datas!, metadata: nil, completion: { (meta, err) in
                                
                                if err != nil {
                                   
                                } else {
                                    storage.downloadURL(completion: { (url, err) in
                                        if err != nil {
                                           
                                        } else {
                                            let path = url!.absoluteString
                                           
                                            let data : [String:Any] = ["nickname": nickname,
                                                                       "email": email,
                                                                       "password": pswd,
                                                                       "rtime":rtime,
                                                                       "stime":stime,
                                                                       "race": "",
                                                                       "ids": "",
                                                                       "country": str,
                                                                       "gender": self.gender,
                                                                       "count": count,
                                                                       
                                                                       //  "filter":ra,
                                                "url": path,
                                                // "gender": gender,
                                                "token": Messaging.messaging().fcmToken!]
                                            
                                            
                                            // Tokener has
                                            // "exY3jgVQExE:APA91bHW1JKc2BjEPbv3-CqI4tGzBS7pz44DOit70BI40SyHY0euIVAfLrbHamod9z5ryrT-op2j8fA483Y6tLUTXDuruZUGhuh7o6TxkLJJlNCO2EV348omurq-1JcZ7HN5QC7sulwh"
                                            
                                            // ADD GENDER
                                            
                                            ref.child("Users").child(uid!).setValue(data)
                                            
                                            UserDefaults.standard.set("NO", forKey: "isout")
                                            
                                            /* DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // + 2 necessary ???
                                             self.present(TabController(), animated: true, completion: nil)
                                             } */
                                            
                                            self.present(TabController(), animated: true, completion: nil)
                                            
                                        }
                                    })
                                }
                            })
                            
                            
                            
                            
                            
                            
                            
                            
                            //  }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                    }
                    
                    
                    // self.present(TabController(), animated: true, completion: nil)
                    /*  DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // + 2 necessary ???
                     UserDefaults.standard.set("YES", forKey: "isout")
                     self.present(TabController(), animated: true, completion: nil)
                     } */
                    
                } // --------
            }
            
            
        } else {
            // alert user
            let r = Alert()
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in }
            r.show(on: self, title: "Invalid values", messsage: "All fields must contain text and you must select at least one race.", actions: [action]) // remove action, it blocks
        }
    }
    
    
    func alert(title: String, m: String){
        let r = Alert()
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in }
        r.show(on: self, title: title, messsage: m, actions: [action])
    }
    
    /*
     @objc func login(sender: UIButton!){ // CONSTRAIN
     present(LogController(), animated: true, completion: nil)
     }
     */
    
    @objc func skip(sender: UIButton!){
        self.present(LogController(), animated: true, completion: nil)
    }
    
    
    /*   func postToken(token: [String: AnyObject]){
     let db = Database.database().reference()
     db.child("fcmAuth").child(Messaging.messaging().fcmToken!).setValue(token)
     }*/
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // SELF LOGIN
        /*
         let f = UFetcher(ename: "Users", key: "users")
         let users = f.fetchR()
         
         if users.count > 0 {
         let us = users[users.count - 1]
         let l = Logger(email: us.email, password: us.password, pres: TabController(), on: self)
         l.logina()
         //  let l = Logger(email: "filipan@a.com", password: "123456", pres: TabController(), on: self)
         }
         */
        
        let r = [String]()
        
        for r in rso {
            results.append(RO(value: r, isSelected: false))
        }
        
        
        /*   let f = TextFetcher(edit: r)
         // url with countries
         f.mefetcha(url: "http://swimrunny.co/countries.txt") { (resa) in
         
         for i in 0..<resa.count {
         self.results.append(RO(value: resa[i], isSelected: false)) // CHANGE BAC TO TRUE
         
         }
         
         
         
         print("THIRD")
         print(self.results[0])
         
         DispatchQueue.main.sync {
         self.tableView.reloadData()
         }
         }*/
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RACell", for: indexPath)
        
        let modelClass = results[indexPath.row]
        
        if modelClass.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell.textLabel?.text = modelClass.value
        return cell
    }
    
    
    func removeTicks(){
        
        for res in results {
            res.isSelected = false
        }
        
        for cell in self.tableView.visibleCells{
            print("CELL")
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        new.removeAll()
        removeTicks()
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        results[indexPath.row].isSelected = !results[indexPath.row].isSelected
        new.append(results[indexPath.row].value)
        
        print("SELECTED \(results[indexPath.row].value)")
        print("MUST BE ONE \(new.count)")
        
        /*   if new.contains(results[indexPath.row].value) {
         tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
         results[indexPath.row].isSelected = !results[indexPath.row].isSelected
         let id = new.index(of: "\(results[indexPath.row].value)")
         new.remove(at: id!)
         } else {
         
         if new.count == 0 {
         
         
         tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
         results[indexPath.row].isSelected = !results[indexPath.row].isSelected
         
         new.append(results[indexPath.row].value)
         }
         /*  } else {
         let a = Alert()
         let act = UIAlertAction(title: "Ok", style: .default, handler: nil)
         a.show(on: self, title: "Country", messsage: "You may select only one country", actions: [act])
         }*/
         } */
        
        
        idx = indexPath.row
        
        country = results[indexPath.row].value
        
    }
}

class model: NSObject {
    var isSelected: Bool = false
}





//
//  LogController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 30/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase

class LogController: UIViewController, UITextFieldDelegate {
    
    var time = ""
    
    let loglbl: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 31)
        l.text = "Swimrun world"
        l.textAlignment = .center
        return l
    }()
    
    
    let lognfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
       // f.textColor = .black
        f.font = UIFont.boldSystemFont(ofSize: 18)
       // f.layer.cornerRadius = 1.0
       // f.clipsToBounds = true
       // f.placeholder = "Email"
         f.attributedPlaceholder = NSAttributedString(string: "e-mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])

        f.layer.cornerRadius = 4.0
        // f.layer.borderColor = UIColor.white.cgColor
        f.layer.backgroundColor = UIColor.white.cgColor
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: f.frame.height + 6))
        f.leftView = padding
        f.leftViewMode = .always
        return f
    }()
    
    let logpfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.isSecureTextEntry = true
        f.font = UIFont.boldSystemFont(ofSize: 18)
        f.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        f.layer.cornerRadius = 4.0
        f.layer.backgroundColor = UIColor.white.cgColor
   
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: f.frame.height + 6))
        f.leftView = padding
        f.leftViewMode = .always
        return f
    }()
    
    
    
    
    let backv: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#f2f2f2")
        v.layer.cornerRadius = 4.0
        return v
    }()
    
    let backvb: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#f2f2f2")
        v.layer.cornerRadius = 4.0
        return v
    }()
 
    
    lazy var logsbtn: UIButton = { // work on this
        let b = SignB()
        b.setTitle("Log in", for: [])
        b.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        /*     b.backgroundColor = hex("#1abc9c")
         b.layer.cornerRadius = 8
         b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
         b.layer.cornerRadius = 30.0 */
        
        return b
    }()
    /*
    var infol: UILabel = {
        let l = UILabel()
        l.text = "Don't have an account yet ?"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()*/
    
    lazy var tosign: LoginB = {
        let b = LoginB()
        b.setTitle("Create an account", for: [])
        b.setTitleColor(UIColor.white, for: [])
        b.addTarget(self, action: #selector(toSign(sender:)), for: .touchUpInside)
        // b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return b
    }()
    
    /*
    lazy var fillbtn: UIButton = {
        let b = UIButton()
        b.setTitle("♥", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        b.setTitleColor(UIColor.black, for: [])
        b.addTarget(self, action: #selector(fill(sender:)), for: .touchUpInside)
        // b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return b
    }()*/
    
    
    
    
    var backimg: UIImageView = {
        let b = UIImageView()
        b.image = UIImage(named: "corr-petr.png") // finalpetr.png
        b.contentMode = .scaleAspectFill
        return b
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            print("He exists!")
            
            let f = UFetcher(ename: "Users", key: "users")
            let users = f.fetchR()
            
            if users.count > 0 {
                let us = users[users.count - 1]
               // let l = Logger(email: us.email, password: us.password, pres: TabController(), on: self)
                print("US \(us)")
                
             //   l.logina()
                // l.logina() // autologin enabled (comment autolgin line in class if you don't want autologin)
            }
        } else {
            print("He doesn't exist :(")
        }
    }
    
    
    let logfields = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        view.addGestureRecognizer(tap)
        
        logfields.axis = .vertical
        logfields.distribution = .fillEqually
        logfields.addArrangedSubview(lognfield)
        logfields.addArrangedSubview(logpfield)
        logfields.spacing = 10
        
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
             loglbl.font = UIFont.boldSystemFont(ofSize: 41)
        }
        
        [backimg, backv, backvb, loglbl, logfields, logsbtn, tosign].forEach {view.addSubview($0)}
        
        
        backimg.stretch(within: self.view, insets: [0,0,0,0])
        
    
        constrainUI()
        
        [lognfield, logpfield].forEach {$0.autocorrectionType = .no}
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        logpfield.placeholder = nil
        lognfield.placeholder = nil
    }
    
  
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
        self.resignFirstResponder()
    }
    
    @objc func toSign(sender: UIButton!){
        present(SignController(), animated: false, completion: nil)
    }
    
    @objc func fill(sender: UIButton!){
        lognfield.text = "filip@a.com"
        logpfield.text = "123456"
    }
    
    @objc func login(sender: UIButton!){ // CONSTRAIN
        if self.lognfield.text == "" || self.logpfield.text == "" { // not &&
          
            
            let email = self.lognfield.text ?? ""
            
            
            var errors = ""
            if email == "" {
                errors += "you have to fill-in e-mail \n"
            } else if (email.contains("@") == false) {
                errors += "email adress is not in correct format \n"
            }
            
            
            
            if self.logpfield.text == ""{
                errors += "you have to fill-in passsword"
            }
            
            let r = Alert()
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            
            r.show(on: self, title: "Following errors found:", messsage: errors, actions: [action])
           // lognfield.layer.borderWidth = 1.0
           // lognfield.layer.borderColor = UIColor.red.cgColor
         
            
            
        } else {
            
            
            // check internet connection
            
            let d = Connection()
            if d.isConnected() == false {
                let a = Alert()
                let dism = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                a.show(on: self, title: "You are offline", messsage: "Please, connect to internet and try again", actions: [dism])
            } else {
                 login()
            }
            
           
        }
        
    }
    
    
}



extension LogController {
    func login(){
        let ref = Database.database().reference()
        ref.child("Users").queryOrdered(byChild: "email").queryEqual(toValue: self.lognfield.text!).observe(.value) { (snap) in
            if snap.exists() { //
                
                let l = Logger(email: self.lognfield.text!, password: self.logpfield.text!, pres: TabController(), on: self)
                l.logina()
                UserDefaults.standard.set("NO", forKey: "isout")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // +2
                    self.present(TabController(), animated: true, completion: nil)
                }
                
            } else {
                let r = Alert()
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                r.show(on: self, title: "Invalid user", messsage: "Account doesn't exist", actions: [action])
            }
        }
    }
}


//
//  GroupController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 10/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications



class FR {
    var title: String
    var empty: Bool
    
    init(title: String, empty: Bool){
        self.title = title
        self.empty = empty
    }
    
}


class GroupController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var results = [String]()
    var races = [RO]()
    var supported = ["Prague", "Zlin", "Otrokovice"] // will = filter array from SignUpVC :)
    let ref = Database.database().reference()
    var passemail = ""
    var passeruntime = ""
    var passeswimtime = ""
    var passename = ""
    var rectoken = ""
    
    var tickedvalues = [String]()
    

    
    var explabel: UILabel = {
        let l = UILabel()
        l.text = "init"
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.textColor = .white
        return l
    }()
    
    
   /* lazy var unreadBtn: UIButton = {
    let b = BMaker(title: "Unread", color: "#3498db", size: 20.0, action: #selector(self.toUnread(sender:)))
    return b.gen()
    }() */
    
    @objc func toUnread(sender: UIButton!){
    present(MessageController(), animated: true, completion: nil)
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(RaceCell.self, forCellReuseIdentifier: "GRCell")
        
       /* let r = UIRefreshControl()
        r.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
        t.addSubview(r) */
        
        t.separatorColor = .clear
        return t
    }()
    
    
    /*
    @objc func refresh(sender: UIRefreshControl){
        tableView.reloadData()
        sender.endRefreshing()
    }*/
    
    var dislabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 30)
        
        l.text = "No connection"
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let disview: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#3498db")
        return v
    }()
    
    lazy var trybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Try again", for: [])
        btn.addTarget(self, action: #selector(self.check), for: .touchUpInside)
        return btn
    }()
    
    @objc func check(){
        let c = Connection()
        
        if c.isConnected() == false {
            addConnectionError()
            disview.isHidden = false
            dislabel.isHidden = false
            trybutton.isHidden = false
            print("YES")
        } else {
            disview.isHidden = true
            dislabel.isHidden = true
            trybutton.isHidden = true
        }
    }
    
    
    
    
    lazy var racesTable: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "RNCell")
        t.alpha = 0 // BEWARE
        // t.frame = CGRect(x: 0, y: 290, width: view.frame.width, height: 180)
        return t
    }()
    
    
    var titlel: UILabel = {
        var l = UILabel()
        l.text = "Races"
        //  l.font = UIFont.boldSystemFont(ofSize: 38)
        
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
            l.font = UIFont.systemFont(ofSize: 55, weight: UIFont.Weight.heavy)
        } else {
            l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        }
        
        // heavy? or medium? , x black
        l.textColor = .black // gray
        return l
    }()
    
    
    lazy var showBtn: AddB = {
        let s = AddB()
        s.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        s.setTitle("+ add", for: [])
        s.addTarget(self, action: #selector(toggletv(sender:)), for:.touchUpInside)
        return s
    }()
    
    
    

    
 
    
    lazy var hidebtn: UIButton = {
        let b = UIButton()
        b.setTitle("Go back", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.addTarget(self, action: #selector(toggletv(sender:)), for: .touchUpInside)
        //  b.isHidden = true
        b.alpha = 0
        b.backgroundColor = hex("#e74c3c")
        return b
    }()
    
    
    
    
    @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                 tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    }
    
    
    
    @objc func toggletv(sender: UIButton!){
        
        
        
      
        
        if racesTable.alpha == 1 {
            UIView.animate(withDuration: 0.4) {
                self.racesTable.alpha = 0// hide table view
                self.searchbar.alpha = 0
                self.searchback.alpha = 0
                self.hidebtn.alpha = 0 // show hider
                self.showBtn.alpha = 1
                self.view.endEditing(true)
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.racesTable.alpha = 1// hide table view
                self.searchbar.alpha = 1 // 0 ?????????????????????
                self.searchback.alpha = 1
                self.hidebtn.alpha = 1 // show hider
                self.showBtn.alpha = 0
                
                /* for g in self.view!.gestureRecognizers! {
                 self.view.removeGestureRecognizer(g)
                 }*/
            }
        }
    }
    
    
    // Seaching
    var isSearching = false
    var filtered = [RO]()
    
    var new = [RO]()
    var side = [RO]()
    
    
    
    
    lazy var searchbar: UISearchBar = {
        let s = UISearchBar()
        s.delegate = self
        s.returnKeyType = .done
        s.alpha = 0
        s.transluescent()
        s.placeholder = "Search races"
        // .value(forKey: "searchField") as? UITextField
        
        let po = s.value(forKey: "searchField") as? UITextField
        po?.font = po?.font?.withSize(22)
        // textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(12)
        
        
        // s.layer.borderColor = UIColor.gray.cgColor
        // s.layer.cornerRadius = 4.0
        
        return s
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var allraces = [String]()
    
    
    func loadRaces(){
        let r = [String]()
        let f = TextFetcher(edit: r)
        f.mefetcha(url: "http://swimrunny.co/database.txt") { (resa) in
            self.races.removeAll()
            
            for (i, _) in resa.enumerated(){
                let el = RO(value: resa[i], isSelected: false)
                
                self.races.append(el)
                
            }
            DispatchQueue.main.sync {
                self.racesTable.reloadData()
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadRaces()
        UserDefaults.standard.set("group", forKey: "leftat")
        
        check()
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests) in
            for r in requests {
                print("Req \(r)")
            }
        }
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
                let uid:String = (Auth.auth().currentUser?.uid)! // CRASH when loggin in on a new device ??
                // let uid = Auth.auth().currentUser!.uid
                
                
                
                let photo = Auth.auth().currentUser?.photoURL
                
                // https://stackoverflow.com/questions/39398282/retrieving-image-from-firebase-storage-using-swift
                
                Database.database().reference().child("myfiles").observeSingleEvent(of: .value) { (snap) in
                    if snap.exists() {
                        print("Snap trully exists!!!!")
                    } else {
                        print("No")
                    }
                }
                
                
                //  print("PATH is : \(path)")
                
                // print("MAYBE PHOTO \(photo)")
                if photo != nil {
                    print("Photo without a doubt URL is \(photo!)")
                }
                
                self.ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
                    
                    let s = snap
                    let v = s.value as? NSDictionary
                    let em = v?["email"] as? String ?? "not found"
                    self.passemail = em
                    
                    //  let filterarr = v?["filter"] as? String ?? "x"
                    
                    
                    let st = v?["stime"] as? String ?? "not found"
                    let rt = v?["rtime"] as? String ?? "not found"
                    self.passeruntime = rt
                    self.passeswimtime = st
                    
                    let name = v?["nickname"] as? String ?? "not found"
                    self.passename = name // necessary ??
                    
                    let token = v?["token"] as? String ?? "not found"
                    
                    let fr = v?["race"] as? String ?? "x"
                    let we = fr.components(separatedBy: "-")
                    
                    self.results.removeAll()
                    self.tickedvalues.removeAll()
                    for var q in we {
                        // var rc = FR(title: "", empty: true)
                        
                        if q != ""{
                            self.results.append(q)
                            self.tickedvalues.append(q)
                            print("APPENDING FROM DB\(q)")
                            
                        }
                        
                    }
                    
                    
                    
                    
                    let blocked = v?["blocked"] as? String ?? "NF"
                    
                    
                    let races = v?["race"] as? String ?? "not found"
                    let arr = races.split(separator: "-")
                    
                    // self.chosen.removeAll()
                    self.new.removeAll()
                    self.side.removeAll()
                    
                    for a in arr {
                        self.new.append(RO(value: String(a), isSelected: true)) //
                        self.side.append(RO(value: String(a), isSelected: true)) //
                    }
                    
                    self.racesTable.reloadData()
                    
                    
                    
                    
                    let alf = FetchAll(name: "Users", nofetch: self.passemail, blocked: blocked) // EXCLUDE ME !!!! (works with "vera@a.com"
                    // nofetch
                    
                    alf.observe { (res) in
                        self.allraces = res
                        print("RACES")
                        print(self.allraces)
                        self.tableView.reloadData()
                    }
                }
                
                
                
                
                
                
                
            }
            
        } 
    }
    
    var timer:Timer?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(false, forKey: "isinchat")
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.check4Notif), userInfo: nil, repeats: true)
        
    }
    
    
    lazy var searchback: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.alpha = 0
        return v
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        [/*background,*/ tableView, titlel, searchback, searchbar, hidebtn, racesTable, showBtn /*slabel, rlabel*/].forEach {view.addSubview($0)}
        constrainUI()
        // unreadBtn.pin(a: .top, b: .center, ac: 30, bc: 0, w: 130, h: 30, to: nil)
        //stack.pin(a: .top, b: .center, ac: 80, bc: 0, w: view.frame.width - 40, h: 90, to: nil)
        
      
        
       
        showBtn.pin(a: .top, b: .right, ac: 36, bc: 20, w: 110, h: 40, to: nil)
        
        searchback.pin(a: .top, b: .center, ac: 64, bc: 0, w: view.frame.width - 12, h: 60, to: nil)
        
        searchbar.pin(a: .top, b: .center, ac: 78, bc: 0, w: view.frame.width - 12, h: 60, to: nil)
        
        hidebtn.pin(a: .top, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 50, to: nil)
        //tableView.stretchPin(top: 60, left: nil, right: nil, bottom: savebtn)
        //tableView.pin(a: .top, b: .left, ac: 60, bc: 0, w: view.frame.width, h: 50, to: nil)
        racesTable.bottomPin(top: 100)
        
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, err) in
            if err != nil { }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return results.count // never add 1 !!!!! rather append
        } else {
            
            if isSearching {
                return filtered.count
            } else {
                return races.count
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var ret = 0.0
        
        let c = Checker()
        
        if c.isIpad() {
            ret = 65.0
        } else {
            ret = 50.0
        }
        
        return CGFloat(ret) //   return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GRCell") as! RaceCell // Blue and black races cells
            
            
            let res = results[indexPath.row]
            print("RES IS \(res)")
            
            if indexPath.row <= results.count { // !=
                
                cell.updateUI(text: res.shorten(), allRaces: allraces, result: res)
                
                
                
                
            } else { cell.textLabel?.text = "+" }
            return cell
            
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RNCell", for: indexPath)
            
            
            let row = indexPath.row
            
            var titles = [String]()
            new.map{titles.append($0.value)}
            
            
            var model = races[row]
            
            
            
            if (titles.contains(races[row].value)){
                model.isSelected = true
                self.tickedvalues.append(races[row].value)
            }
            
            
            if isSearching == false {
                
                if tickedvalues.contains(races[row].value){ // FIX Hír
                    if model.isSelected {
                        cell.accessoryType = .checkmark
                    } else {
                        cell.accessoryType = .none
                    }
                    /*  } else {
                     cell.accessoryType = .none
                     }*/
                } else {
                    cell.accessoryType = .none
                }
                
                
            }
            
            if isSearching == true {
                if tickedvalues.contains(filtered[row].value){
                    filtered[row].isSelected = true
                    cell.accessoryType = .checkmark
                    // racesTable.cellForRow(at:IndexPath(row: indexPath.row, section: 0))?.accessoryType = .checkmark
                } else {
                    filtered[row].isSelected = false
                    cell.accessoryType = .none
                    // racesTable.cellForRow(at:IndexPath(row: indexPath.row, section: 0))?.accessoryType = .none
                }
            }
            
            if model.value !=  "" { // ???????
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                
                if isSearching {
                    cell.textLabel?.text = filtered[row].value
                } else {
                    cell.textLabel?.text = "\(model.value)"
                }
                
            }
            
            return cell
        }
        
        // return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView == self.tableView {
            
            
            if self.allraces.contains(self.results[indexPath.row]) {
                let match = MatchControllersqs()
                match.location = results[indexPath.row]
                match.viewWillAppear(true) // again
                match.email = passemail
                match.psswim = passeswimtime
                match.psrun = passeruntime
                match.nick = self.passename // might be empty and cause problems
                print("PASSE \(self.passename)")
                
                // SOLVE TOKENS AND CHAT ONLY IN MATCHVC
                
                present(match, animated: true, completion: nil)
            } else {
                let a = Alert()
                let dis = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    let deselect: IndexPath? = tableView.indexPathForSelectedRow
                    if let path = deselect {
                        tableView.deselectRow(at: path, animated: false)
                    }
                })
                
                a.show(on: self, title: "You are the first listed athlete.", messsage: "Wait. Someone will join soon.", actions: [dis])
            }
        }
            
            
        // -------------------------------------------------------- RACES TABLE VIEW --------------------------------------------------------
            
        else {
            
            if isSearching == false {
                
                let row = indexPath.row
                
                var titles = [String]() //                              IS SEARCHING == FALSE
                new.map {titles.append($0.value)}
                
                // REMOVE HERE FROM
                
                if titles.contains(races[row].value){
                    let sl = racesTable.cellForRow(at: IndexPath(row: row, section: 0))
                    sl?.isSelected = false
                    sl?.accessoryType = .none
                    
                    
                    showFoundAlert()
                    races[row].isSelected = false //!races[row].isSelected
                    
                    let id = titles.index(of: "\(races[row].value)")
                    titles.remove(at: id!)
                    new.remove(at: id!)
                    
                    let sw = RaceSwitcher() // no need for "update" !! :)
                    let mr = new.map {String($0.value)} // get races in array, which was selected !!!
                    print("MR FOUND \(mr)")
                    
                    sw.update(races: mr, ticked: false)
                    results = mr
                   
                    self.tableView.reloadData()
                    self.racesTable.reloadData()
                    
                } else { // DID SELECT "isSearching" FALSE - does not contain value !
                   
                    
                    races[row].isSelected = true // !races[row].isSelected
                    
                    titles.append(races[row].value)
                    new.append(RO(value: races[row].value, isSelected: true)) // results[row].isSelected
                    
                    let sw = RaceSwitcher() // no need for "update" !! :)
                    let mr = new.map {String($0.value)} // get races in array, which was selected !!!
                    sw.update(races: mr, ticked: true) // BIG PROBLEM HERE
                    
                    print("MR  \(mr)") // BIG PROBLEM HERE !!!!!!!
                    
                    results = mr
                    
                    let scell = racesTable.cellForRow(at: IndexPath(row: row, section: 0))
                    scell?.accessoryType = .checkmark
                    scell?.isSelected = true
                    
                    self.tableView.reloadData() // RESULTS
                    self.racesTable.reloadData() // RACES
                }
                
            }
            
            
            
            
            else { // -------------------------------------------------------------------------------------- DID SELECT is searching == TRUE
               /*
                 self.tableView.reloadData() // RESULTS
                 self.racesTable.reloadData() // RACES
                 
                 isSearching == TRUE ---> filtered
                 isSearching == FALSE ---> races
                 */
                
                let row = indexPath.row
                
                var titles = [String]()
                new.map {titles.append($0.value)} // titles array are currently selected races
                print("TITLES \(titles)")
               
                
                // --------------------------------- (CONTAINS) DID SELECT is searching == TRUE
                if titles.contains(races[row].value) { // does "titles" array contain curently selected race ?
                  
                  /*  print("SELECTED DOES CONTAINS \(races[row].value)") // VALUE FROM ORIGINAL UNFILTERED ARRAY, (VISIBLE)
                  
                    let flatraces = races.map {$0.value}
                    print("ALL \(flatraces.count)") // 227
                    
                    let idx = getIndexOf(val: filtered[row].value, arr: flatraces) // arr is original array
                    races[idx].isSelected = false
                  
                    let id = getIndexOf(val: races[row].value, arr: titles)
                    titles.remove(at: id)
                    new.remove(at: id)
                    
                    let sw = RaceSwitcher() // no need for "update" !! :)
                    let mr = new.map {String($0.value)} // get races in array, which was selected !!!
                    sw.update(races: mr, ticked: false)
                    results = mr
    
                    self.tableView.reloadData()
                  */
                    
                    let ac = Alert()
                    let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    ac.show(on: self, title: "Swipe to deselect", messsage: "Swipe from Races screen to deselct the race", actions: [action])
                } else {
               
                   // DO NOT TICK ANYTHING AT RACESTABLE.cellforrow, when fltered is in action
                    // ONLY ALERT AND SET IS SELECTED TO TRUE
                    
                    if titles.contains(filtered[row].value){
                        let ac = Alert()
                        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                        ac.show(on: self, title: "Swipe to deselect", messsage: "Swipe from Races screen to deselct the race", actions: [action])
                    } else {
                        
                    
                        let ac = Alert()
                        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                        ac.show(on: self, title: "Race selected", messsage: "Races \(filtered[row].value) has been selected ", actions: [action])
                        
                        
                        // TRY TO TICK THE CELL
                      
                        
                        let flatraces = races.map {$0.value}
                        let idx = getIndexOf(val: filtered[row].value, arr: flatraces)
                        racesTable.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryType = .checkmark
                       // racesTable.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
                        // reload rows !!!
                        
                      //  print("Uruguay idx should be 5 \(idx)")
                    
                    titles.append(filtered[row].value)
                    new.append(RO(value: filtered[row].value, isSelected: true)) // results[row].isSelected
                    
                    
                    let sw = RaceSwitcher() // no need for "update" !! :)
                    let mr = new.map {String($0.value)} // get races in array, which was selected !!!
                    sw.update(races: mr, ticked: true) // BIG PROBLEM HERE
                    results = mr
                    
                    self.tableView.reloadData() // RESULTS
                    self.racesTable.reloadData() // RACES
                    }
                }
                
                
              
                
                
            }
            
            
            
            
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == self.tableView {
            
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                print("DEL NOW")
                
                let row = indexPath.row
                
                let race = results[row] // y
                
                if tickedvalues.contains(race) {
                    let tz = getIndexOf(val: race, arr: tickedvalues)
                    tickedvalues.remove(at: tz)
                    // racesTable.cellForRow(at: IndexPath(row: tz!, section: 0))?.accessoryType = .none
                }
                
                
                var strraces = [String]()
                races.map {strraces.append($0.value)}
                
                let ppo = getIndexOf(val: race, arr: strraces)
                races[ppo].isSelected = false
                
                var titles = [String]()
                new.map {titles.append($0.value)}
                
                
                
                let sw = RaceSwitcher() // y
                sw.remove(race: race)
                
                // gET INDEX OF RESULTS ROW IN RACES TICKING ARRAY AND SET CHECKMARK TO NONE
                
                
                
                print("NEW ROW \(new[row].value)")
                print("TITLES ROW \(titles[row])")
                print("RESULTS ROW \(results[row])")
                
              
                let idx = getIndexOf(val: results[row], arr: strraces)
                racesTable.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryType = .none
                
                if titles.contains(new[row].value){
                  //  let id = titles.index(of: "\(new[row].value)")
                    let id = getIndexOf(val: new[row].value, arr: titles)
                    
                    print("SWIMPING \(new[row].value)")
                    titles.remove(at: id)
                    new.remove(at: id)
                    results.remove(at: row) // really ???
                    
                    showFoundAlert()
                }
                self.tableView.reloadData()
                self.racesTable.reloadData()
                
                
                
            }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == self.racesTable {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    
}





extension GroupController {
    
    func showFoundAlert(){
        
        // if editingStyle == UITableViewCell.EditingStyle.delete {
        
        var titles = [String]()
        new.map {titles.append($0.value)}
        
        // let row = indexPath.row
        //   let loc = results[row]
        // let f = Finder(slocation: loc.value)
        
        
        let r = Alert()
        let remove = UIAlertAction(title: "I have found a partner", style: .default) { (action) in
            // f.removeMatched()
            
            // fetch prev. value of "Yes" and add one to it
            let getter = IncrGet(name: "Yes")
            getter.get(completion: { (val) in
                let r = val
                
                let q = r[0].value
                let w = Int(q)
                
                let inc = Increaser(name: "Yes")
                inc.add(val: w! + 1)
            })
            
            
        }
        
        
        
        
        let no = UIAlertAction(title: "Won't take part", style: .default) { (action) in
            
            // SAVE DATA
            
            // self.tableView.reloadData()
            
            // fetch prev. value of "No" and add one to it
            let getter = IncrGet(name: "No")
            getter.get(completion: { (val) in
                let r = val
                
                let q = r[0].value
                let w = Int(q)
                
                let inc = Increaser(name: "No")
                inc.add(val: w! + 1)
            })
            
            
        }
        
        
        
        r.show(on: self, title: "", messsage: "Have you found a partner ?", actions: [remove, no])
        // Have you found a partner ?
        
        // }
    }
}



extension GroupController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            racesTable.reloadData()
        } else {
            isSearching = true
            
            /*filtered = races.filter {
             // print("VAL \($0.value)")
             $0.value.lowercased().contains(searchbar.text!.lowercased())
             }*/
            
            filtered = races.filter {$0.value.range(of: searchBar.text!, options: .caseInsensitive) != nil}
            print(filtered.map {$0.value})
            
            
            // print(" RACES[1]  \(races[1].value)")
            racesTable.reloadData()
        }
    }
}

// self.filtered = exercises.filter {$0.name.range(of: searchText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }





extension GroupController {
    
    func getIndexOf(val:String, arr: [String]) -> Int{
        var i = -1
        if arr.contains(val){
            i = arr.firstIndex(of: val)!
        }
        return i
    }

}





//
//  MatchController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class MatchControllersqs: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate {
    
    var fids = [Int]()
    var ref = Database.database().reference()
    
    let fake = ["Petr", "Filip", "Ryclonožka"]
    let racenames = ["Horska Vyzva", "Moraviaman", "Oravaman"]
    
    var email = ""
    var location = ""
    var nick = ""
    var rectoken = ""
    var sendertoken = ""
    var blocked = ""
    var passeimage: UIImage?
    var selfimage: UIImage?
    var real = [User]()
    var urls = [String]()
    
    var psswim = ""
    var psrun = ""
    
     var allowd = false
    
    
    var hheight: NSLayoutConstraint?
    var theight: NSLayoutConstraint?
    
    let imv: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "darker-jump.png") // jumpf
        i.contentMode = .scaleAspectFill // sclaAspectFill
        i.clipsToBounds = false
        return i
    }()
    
    var hw: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        return v
    }()
    
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UCell.self, forCellReuseIdentifier: "MCell")
        t.separatorColor = .clear
        t.backgroundColor = .white // ??? or white
        t.alpha = 1.0 // rem ?????
        return t
    }()
    
    var loadingLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Loading"
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var label:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.heavy) // UIFont.boldSystemFont(ofSize: 30)
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    
    
    lazy var back: UIButton = {
        let b = UIButton()
        b.setTitle("←", for: [])
        b.setTitleColor(hex("#ffffff"), for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        return b
    }()
    
    var dislabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 30)
        l.text = "No connection"
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let disview: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#3498db")
        return v
    }()
    
    let saveview: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var trybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Try again", for: [])
        btn.addTarget(self, action: #selector(self.check), for: .touchUpInside)
        return btn
    }()
    
   /*
    let imgview: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()*/
    
    @objc func check(){
        let c = Connection()
        
        if c.isConnected() == false {
            addConnectionError()
            disview.isHidden = false
            dislabel.isHidden = false
            trybutton.isHidden = false
            print("YES")
        } else {
            disview.isHidden = true
            dislabel.isHidden = true
            trybutton.isHidden = true
        }
    }
    
    
    @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    }

    
    
    @objc func back(sender: UIButton!){
        
     
        let tab = TabController()
        present(tab, animated: false, completion: nil)
        
        
       // self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func getSize(url: String, completion: @escaping (Int64, Error?) -> Void){
        let timeout = 5.0
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout)
        request.httpMethod = "HEAD"
      
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let size = response?.expectedContentLength ?? NSURLSessionTransferSizeUnknown
            print("SIZE is \(size)")
            completion(size, error)
            group.leave()
        }.resume()
        
    }
    
    
    
    
    
    func sizeFromLink(url: URL)  {
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            DispatchQueue.main.async() {
                
                if data != nil {
                    let image = UIImage(data: data!)
                    print("DATA SIZED \(data!.count)")
                    
                    let count = data!.count
                    let bcf = ByteCountFormatter()
                    bcf.allowedUnits = [.useMB]
                    bcf.countStyle = .file
                    let res = bcf.string(fromByteCount: Int64(count))
                    print("RES IS \(res)")
                }
            }
            
            }.resume()
    }
    /*
     
     func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
     contentMode = mode
     URLSession.shared.dataTask(with: url) { data, response, error in
     guard
     let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
     let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
     let data = data, error == nil,
     let image = UIImage(data: data)
     else { return }
     DispatchQueue.main.async() {
     self.image = image
     }
     }.resume()
     }
     */
    
        func sizePerMB(url: URL?) -> Double {
            
            print("URL is \(url)")
            print("URL path is \(url!.path)")
            print("URL absolute string \(url!.absoluteString)");
             print("URL absolute ULR \(url!.absoluteURL)");
            
            
            guard let filePath = url?.path else {
                return 0.0
            }
            
          
            
            do {
                let str = url!.path
                
                let attribute = try FileManager.default.attributesOfItem(atPath: str) // or filepath
                if let size = attribute[FileAttributeKey.size] as? NSNumber {
                    
                    let ret =  size.doubleValue / 1000000.0
                    print("SIZE IN MB is \(ret)")
                    return ret
                }
                
            } catch {
                print("SIZE ERRORA: \(error)")
            }
            return 0.0
        }
    // ABFU5848DTDTZ644 (??)
    
    
    override func viewWillAppear(_ animated: Bool) { // did?
        check()
        getmyData()
        // observe()
        let deselect: IndexPath? = tableView.indexPathForSelectedRow
        if let path = deselect {
            tableView.deselectRow(at: path, animated: false)
        }
        
        
        let uid:String = (Auth.auth().currentUser?.uid)!
        ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            
            let v = s.value as? NSDictionary
            
            let w = v?["ids"] as? String ?? "not found" // HIHI
            let res = smart(str:w) // "12-2-3" -> [12, 2, 3]
            self.fids = res
           
            let device = UIDevice.modelName
            
            if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
                self.label.font = UIFont.boldSystemFont(ofSize: 25)
            }
            
            let c = Checker()
            
            if c.isIpad() {
                self.label.font = UIFont.boldSystemFont(ofSize: 50)
            }
            
            self.label.text =  self.location.shorten()
           
           
            let url = v?["url"] as? String ?? "x"
         
            self.sendertoken = v?["token"] as? String ?? "token not found"
            print("DOES FILIP HAVE TOKEN \(self.sendertoken)") // FILIP DOES NOT HAVE
            
            
            
             self.blocked = v?["blocked"] as? String ?? "not set"
           
            
            if url.count > 3 && url != "x" && url != "not found" {
                
                
                
                
     
                
                let storage = Storage.storage().reference(forURL: url)
                storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                    
                    if err != nil {
                        let ac = Alert()
                        let dis = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in })
                        
                        ac.show(on: self, title: "Error when fetching image", messsage: "\(err?.localizedDescription)", actions: [dis])
                    }
                    
                    
                    
                    if data != nil {
                        let image = UIImage(data: data!)
                        print("IMAGE DIMENSIONS \(image!.size)")
                        // self.selfimage = image
                        // self.passeimg = image
                    }
                })
                
            }
        }
        
        
        // SAVE CURRENT STATE
        
        let data = MatchData(email: self.email, location: self.location, run: self.psrun, swim: self.psswim)
        let saver = StateSaver(ename: "ChatState", key: "chatstate", obj: data)
        saver.save()
        
        UserDefaults.standard.set("match", forKey: "leftat")
        
        
        
    }
    /*
     // deselect the selected row if any
     let selectedRow: IndexPath? = tableView.indexPathForSelectedRow
     if let selectedRowNotNill = selectedRow {
     tableView.deselectRow(at: selectedRowNotNill, animated: true)
     }
     }
     */
    
    
    /*
    func fetchImage(){
        let uid:String = (Auth.auth().currentUser?.uid)!
        ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            
            let v = s.value as? NSDictionary
            
            let w = v?["ids"] as? String ?? "not found" // HIHI
            let res = smart(str:w) // "12-2-3" -> [12, 2, 3]
            self.fids = res
            self.label.text =  self.location.shorten()
            
            
            let url = v?["url"] as? String ?? "x"
            print("URL is \(url)")
            
            let storage = Storage.storage().reference(forURL: url)
            storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                
                if err != nil {
                    let ac = Alert()
                    let dis = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in })
                    
                    ac.show(on: self, title: "Error when fetching image", messsage: "\(err?.localizedDescription)", actions: [dis])
                }
                
                
                
                if data != nil {
                    let image = UIImage(data: data!)
                    print("IMAGE DIMENSIONS \(image!.size)")
                    self.selfimage = image
                    self.imgview.image = image
                    // self.passeimg = image
                }
            })
        }
    } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(hw)
        [label, back, /*imgview*/].forEach {view.addSubview($0)}

      
        hw.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hw.topAnchor.constraint(equalTo: view.topAnchor),
            hw.leftAnchor.constraint(equalTo: view.leftAnchor),
            hw.rightAnchor.constraint(equalTo: view.rightAnchor),
            ])
        
        hheight = hw.heightAnchor.constraint(equalToConstant: 600)
        hheight?.isActive = true
        
        hw.addSubview(imv)
        hw.addSubview(label)
        
        imv.fillsuperview(top: 0, left: 0, right: 0, bottom: 0)
        view.addSubview(saveview)
        view.addSubview(tableView)
        
       // hw.alpha = 0.3
        
       
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          //  tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        theight = tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        theight?.isActive = true
        
        view.addSubview(loadingLabel)
       
        
        let c = Checker()
        
        if c.isIpad() {
             label.pin(a: .top, b: .left, ac: 53, bc: 0, w: view.frame.width, h: 70, to: nil)
             self.loadingLabel.pin(a: .top, b: .center, ac: 350, bc: 0, w: self.view.frame.width, h: 60, to: nil)
             back.pin(a: .top, b: .left, ac: 25, bc: 0, w: 85, h: 30, to: nil)
        } else {
         self.loadingLabel.pin(a: .top, b: .center, ac: 250, bc: 0, w: self.view.frame.width, h: 60, to: nil)
             label.pin(a: .top, b: .left, ac: 70, bc: 0, w: view.frame.width, h: 30, to: nil)
             back.pin(a: .top, b: .left, ac: 12, bc: 2, w: 80, h: 30, to: nil) // + 5 everywhere
        }
        
        
       
        
        
        //self.imgview.pin(a: .bottom, b: .center, ac: 60, bc: 0, w: 200, h: 300, to: nil)
        constrainUI()
        observe() // back here ??
        
        // fetchImage()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, err) in
            if err != nil {
                print("Mistake \(String(describing: err))")
            }
        }
        
     
    }
    
    
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
         UserDefaults.standard.set(false, forKey: "isinchat")
       
        

    }
    
  
    
    
    
    
    // get results array from JSON
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return real.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CALL JUST FILLER HERE !!!!!!!! PASS JUST PROXIMITY FROM each object from real :D, what a clean code :)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCell", for: indexPath) as! UCell
        let row = indexPath.row
        let el = real[row]
        
        cell.updateUI(email: el.showNick, swim: el.swim, run: el.run, color: "#3498db", experince: el.experience, image: el.image, nowrite: self.email)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        
        return cell
    }
    
    
    
    
    
    
    var Mnotifurl = ""
    var Mnotifname = ""
    var fromsender = ""
    
    // SEND MY DATA THROUGH NOTIFICATION !!!!!!! add "M" prefix
    func getmyData(){
        let uid:String = (Auth.auth().currentUser?.uid)! // ???
        let ref = Database.database().reference()
        ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            let v = s.value as? NSDictionary
            
            let url = v?["url"] as? String ?? "x"
            self.Mnotifurl = url
            
            let fromo = v?["nickname"] as? String ?? "x"
            self.fromsender = fromo
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let name = real[indexPath.row].name
        let uid:String = (Auth.auth().currentUser?.uid)!
        
        let user = real[indexPath.row]
        
        let vc = ChatController()
        let sender = self.fromsender
        let Rname = user.showNick
        
       
        // DATA ABOUT ME (as Filip)
         vc.from = uid
         vc.toid = real[indexPath.row].uid
        
         vc.Mnotifurl = self.Mnotifurl
         vc.Sname = sender
         vc.sendertoken = self.sendertoken
         vc.location = self.location
         vc.imurl = user.imurl
    
        // DATA ABOUT RECEIVER
         vc.Rname = Rname
         print("Rname presenting \(Rname)")
         vc.rectoken = user.rectoken
  
        // OTHER DATA
         vc.allowd = allowd
         vc.backtext = "Matches"
         vc.fromnotif = false
     
        
        let vars = [uid,
                    user.uid,
                    self.Mnotifurl,
                    sender,
                    self.sendertoken,
                    self.location,
                    user.imurl,
                    Rname,
                    user.rectoken
        ]
        
        for v in vars {
            print("ITEM \(v) \n")
        }
      
         present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var ret = 0.0
        
        let c = Checker()
        
        if c.isIpad() {
            ret = 140.0
        } else {
            ret = 100.0
        }
        
      return CGFloat(ret) //   return 100.0
        
        
    }
    
    
   
    
    func observe(){ // is called once
        let px = psrun.toSec()
        let sx = psswim.toSec()
        
        
        // self.label.text = "No matches"
         self.loadingLabel.text = "Loading..."
        
         let ob = Observer(name: "Users")
        
        /*
        let urlo = URL(string: url)
        URLSession.shared.dataTask(with: urlo!) { data, response, error in
            
            DispatchQueue.main.async() {
                
                if data != nil {
                    //   let image = UIImage(data: data!)
                    print("DATA SIZED \(data!.count)")
                    
                 /*   let count = data!.count
                    let bcf = ByteCountFormatter()
                    bcf.allowedUnits = [.useMB]
                    bcf.countStyle = .file
                    let res = bcf.string(fromByteCount: Int64(count))
                    print("RES IS \(res)") */
                    
                    
                  
                }
            }
            
            }.resume()
        
        */
        
        var counter = 0;
        
        ref.child("Users").queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            
            
            var test = 100
            for s in snap.children {
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                let locationa = v?["race"] as? String ?? "not found" // PROBLEM HERE :D Delete users (new)
               // let count = v?["count"] as? String ?? "N/A"
                
                let url = v?["url"] as? String ?? "x"
                
                print("URL was \(url)")
                
                let gender = v?["gender"] as? String ?? "nog"
                
                let arr = locationa.split(separator: "-")
                var allow = false
                let lm = self.location.suffix(self.location.count)
                
                if arr.contains(lm){
                    allow = true
                }
                
                if allow == true {
                    counter += 1
                }
                
               
                
            }
            
            
            
           // print("COUNT OF USERS IS \(counter)")
            
          
           
            
            
            
            
            
            let a = Alert()
            let dismiss = UIAlertAction(title: "Do not download", style: .default, handler: { (action) in
                ob.observe(blocked: self.blocked, selfloc: self.location, selfmail: self.email, selfrun: px, selfswim: sx, download: false) { (res) in
                    
                    self.allowd = false
                    
                    if res.count > 0 {
                        self.real = res
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.loadingLabel.textColor = .clear
                          //  self.loadingLabel.isHidden = true
                            self.tableView.reloadData()
                            self.tableView.separatorColor = .gray
                            self.tableView.alpha = 1
                        })
                    }
                }
            })
            
            
            
            let ok = UIAlertAction(title: "Download", style: .default, handler: { (action) in
                ob.observe(blocked: self.blocked, selfloc: self.location, selfmail: self.email, selfrun: px, selfswim: sx, download: true) { (res) in
                    
                    
                    self.allowd = true
                    
                    if res.count > 0 {
                        self.real = res
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.loadingLabel.textColor = .clear
                            self.tableView.reloadData()
                            self.tableView.separatorColor = .gray
                            self.tableView.alpha = 1
                        })
                    }
                }
            })
            
            
            // multiply with users.count
            a.show(on: self, title: "", messsage: "Download profile images (\(counter * 2) MB) ?", actions: [ok, dismiss])
            
     
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      // Make observer without images
       
        
       // callinobserve()
      
        
        
}
    
    //-----------------------------------------------------------------------------
    
    func callinobserve(){
        let ref = Database.database().reference()
        
        ref.child("Users").queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            var i = 0
            
            for s in snap.children{
                i += 1
                
                let w = s as! DataSnapshot
                let v = w.value as? NSDictionary
                let url = v?["url"] as? String ?? "x"
                
                 let locationa = v?["race"] as? String ?? "not found"
                let arr = locationa.split(separator: "-")
              
                 let lm = self.location.dropFirst(0)
                
                 var allow = false
                
                if arr.contains(lm){
                    allow = true
                }
                
                
               
                // CHECK ONLY IF USER IS SIGNED UP TO THIS RACE !!!!!
                
                
                
                if allow == true {
                // GET IMAGES FROM URL
               /* if url.count > 3 { // URL ---------------------------
                    let storage = Storage.storage().reference(forURL: url)
                    storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                        
                     /*   if err != nil {
                            let ac = Alert()
                            let dis = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in })
                            
                            ac.show(on: self, title: "Error when fetching image", messsage: "\(err?.localizedDescription)", actions: [dis])
                        }*/
                        
                        if data != nil {
                            let image = UIImage(data: data!)
                            // print("IMAGE DIMENSIONS \(image!.size)")
                            self.images.append(image!)
                            print("IMAGESCOUNT \(self.images.count)")
                            
                        }
                    })
                    
                } else { // URL ---------------------------
                    let def = UIImage(named: "ocean.jpg")
                    self.images.append(def!)
                    print("IMAGESCOUNT \(self.images.count)")
                } */
                
            }
                
            }
            
            
           
        }
    }

}






extension MatchControllersqs:UIScrollViewDelegate {
    
    func animateHeader() {
        self.hheight?.constant = 600
        self.theight?.constant = 200
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if Double((self.hheight?.constant)!) > 600.0 {
            animateHeader()
        }
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            
            if Int((self.hheight?.constant)!) < 670 { // < 670
                self.hheight!.constant += abs(scrollView.contentOffset.y) / 3 // 7
               print("END DRagging")
            }
            
            
            
        }
        else if scrollView.contentOffset.y > 0 && self.hheight!.constant >= 600 {
            self.hheight!.constant -= scrollView.contentOffset.y / 3 // 6
            
        }
        
        
        
        if scrollView.contentOffset.y < 0 {
            
            if Int((self.theight?.constant)!) < 800 { // < 670
                self.theight!.constant += abs(scrollView.contentOffset.y) / 7
                print("HOHOHOHO")
                print("JOHOHOHO")
            }
        }
            
            
            
        else if scrollView.contentOffset.y > 0 {
            self.theight!.constant = 200 // 6
            print("UPUPUPU")
        }
        
        //  self.theight!.constant += abs(scrollView.contentOffset.y) / 7
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}





//
//  AllController.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 03/01/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase

class AllController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    // ::: Filtering (gmin, gmax, gcountry, ggender)
   var gmin = -1
   var gmax = -1
   var gcountry = "ANY"
   var ggender = "ANY"
    
    var allowf = false
    
    
    var ref = Database.database().reference()
    var email = ""
    var location = ""
    var nick = ""
    var rectoken = ""
    var sendertoken = ""
    var blocked = ""
    var passeimage: UIImage?
    var selfimage: UIImage?
    var real = [User]()
    var backup = [User]()
    var urls = [String]()
    
    
    var passemail = ""
    var passeruntime = ""
    var passeswimtime = ""
    var passename = ""
    
    
    var fromsender = ""
    var Mnotifurl = ""
    

    var psswim = ""
    var psrun = ""
    
    var allowd: Bool = false
    
    var dislabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 30)
        
        l.text = "No connection"
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let disview: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#3498db")
        return v
    }()
    
    
    var loadingLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Loading..."
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    
    
    
    lazy var trybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Try again", for: [])
        btn.addTarget(self, action: #selector(self.check), for: .touchUpInside)
        return btn
    }()
    
    @objc func check(){
        let c = Connection()
        
        if c.isConnected() == false {
            addConnectionError()
            disview.isHidden = false
            dislabel.isHidden = false
            trybutton.isHidden = false
            print("YES")
        } else {
            disview.isHidden = true
            dislabel.isHidden = true
            trybutton.isHidden = true
        }
    }
    
    var titlel: UILabel = {
        var l = UILabel()
        l.text = "Competitors"
        //  l.font = UIFont.boldSystemFont(ofSize: 38)
      //  l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
      
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
            l.font = UIFont.systemFont(ofSize: 55, weight: UIFont.Weight.heavy)
        } else {
            l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        }
        
        // heavy? or medium? , x black
        l.textColor = .black // gray
        return l
    }()
    
    /*
    lazy var sortb: UIButton = {
        let b = BMaker(title: "Filter", color: "#1abc9c", size: 19, action: #selector(self.make(sender:)))
        return b.gen()
    }()*/
    
    /*
    lazy var filterStack: UIStackView = {
        let b = BMaker(title: "Experience", color: "#3498db", size: 19, action: #selector(self.make(sender:)))
        let c = BMaker(title: "Country", color: "#3498db", size: 19, action: #selector(self.country(sender:)))
        let g = BMaker(title: "Gender", color: "#3498db", size: 19, action: #selector(self.gendera(sender:)))

        let s = UIStackView()
        s.distribution = .fillEqually
        [b.gen(), c.gen(), g.gen()].forEach {s.addArrangedSubview($0)}
        return s
    }()*/
    
    lazy var filterStack: UIStackView = {
        let e = AddB()
        
       let f = UIDevice.modelName
        if f == "iPhone SE" || f == "Simulator iPhone SE" || f == "iPhone 5s" || f == "Simulator iPhone 5s" {
             e.setTitle("Exp.", for: [])
        } else {
             e.setTitle("Experience", for: [])
        }
        
       
        e.addTarget(self, action: #selector(self.make(sender:)), for: .touchUpInside)
        e.backgroundColor = hex("#3498db")
        
        let c = AddB()
        c.setTitle("Country", for: [])
        c.addTarget(self, action: #selector(self.country(sender:)), for: .touchUpInside)
        c.backgroundColor = hex("#3498db")
        
        let g = AddB()
        g.setTitle("Gender", for: [])
        g.addTarget(self, action: #selector(self.gendera(sender:)), for: .touchUpInside)
        g.backgroundColor = hex("#3498db")
       
        let s = UIStackView()
        s.distribution = .fillEqually
        s.spacing = 20.0
        [e, c, g].forEach {s.addArrangedSubview($0); $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)}
        return s
        
        
        
    }()
    
    
    
    
    @objc func make(sender: UIButton!){
        
        if allowf == true {
            
        
        
        let a = UIAlertController(title: "Experience", message: "Filter by experience", preferredStyle: .actionSheet)
        // let ob = Oberver(name: "Users")
        
        
        let m = UIAlertAction(title: "Beginner 0 - 2", style: .default) { (action) in
          //  self.filter(gender: "Man", min: 0, max: 2)
           
            sender.setTitle("0 - 2", for: [])
            
            self.gmin = 0
            self.gmax = 2
            
            self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        let b = UIAlertAction(title: "Intermediate 3 - 6", style: .default) { (action) in
          //  self.filter(gender: "Man", min: 3, max: 6)
            sender.setTitle("3 - 6", for: [])
            
            self.gmin = 3
            self.gmax = 6
            
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        let c = UIAlertAction(title: "Advanced 7+", style: .default) { (action) in
          //  self.filter(gender: "Man", min: 7, max: 10000)
            sender.setTitle("7+", for: [])
            
            self.gmin = 7
            self.gmax = 10000
            
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        
        
        let nofilter = UIAlertAction(title: "Any", style: .default) { (action) in
            self.gmin = -1
            self.gmax = -1
            
          //  self.filter(gender: "Man", min: 0, max: 10000)
            print("No filter") // filter and reload here
            sender.setTitle("Experience", for: [])
            
            self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        
        
         let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
         print("Cancel") // filter and reload here
         }
        
        a.addAction(m)
        a.addAction(b)
        a.addAction(c)
        a.addAction(nofilter)
        a.addAction(cancel)
        
        let o = Checker()
        if o.isIpad() || o.isBiggestIpad() {
            a.popoverPresentationController?.sourceView = self.view
            a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            self.present(a, animated: true, completion: nil)
        } else {
            self.present(a, animated: true, completion: nil)
        }
       // sheet.show(on: self, title: "Experience", messsage: "Filter by experience", actions: [a, b, c, nofilter, cancel])
        
        // real filter
        }
    }
    
    
    @objc func gendera(sender: UIButton!){
       
        if allowf == true {
            
        
        let a = UIAlertController(title: "Gender", message: "Filter by gender", preferredStyle: .actionSheet)
        
        let m = UIAlertAction(title: "Man", style: .default) { (action) in
           // self.filter(gender: "Man", min: 0, max: 2)
            
            self.ggender = "man"
            
            print("Man") // filter and reload here
            sender.setTitle("Man", for: [])
            
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        let w = UIAlertAction(title: "Woman", style: .default) { (action) in
           // self.filter(gender: "Man", min: 3, max: 6)
            
            self.ggender = "woman"
            print("Woman") // filter and reload here
            sender.setTitle("Woman", for: [])
            
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        let nofilter = UIAlertAction(title: "Any", style: .default) { (action) in
          
            self.ggender = "ANY"
            
           // self.filter(gender: "Man", min: 0, max: 10000)
            print("No filter") // filter and reload here
            sender.setTitle("Gender", for: [])
            
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel") // filter and reload here
        }
        
        a.addAction(m)
        a.addAction(w)
        a.addAction(nofilter)
        a.addAction(cancel)
        
        let o = Checker()
        if o.isIpad() || o.isBiggestIpad() {
            a.popoverPresentationController?.sourceView = self.view
            a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            self.present(a, animated: true, completion: nil)
        } else {
            self.present(a, animated: true, completion: nil)
        }
       // sheet.show(on: self, title: "Gender", messsage: "Filter by gender", actions: [m, w, nofilter, cancel])
        }
    }
    
    
    
  let fake = ["ABW","AFG","AGO","AIA","ALB","AND","ANT","ARE","ARG","ARM","ASM","ATA","ATF","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BVT","BWA","CAF","CAN","CCK","CHE","CHL","CHN","CIV","CMR","COD","COG","COK","COL","COM","CPV","CRI","CUB","CXR","CYM","CYP","CZE","DJI","DMA","DNK","DOM","DZA","ECU","EGY","ERI","ESH","ESP","EST","ETH","EUE","FIN","FJI","FLK","FRA","FRO","FSM","GAB","GBR","GEO","GER","GHA","GIB","GIN","GLP","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUF","GUM","GUY","HKG","HMD","HND","HRV","HTI","HUN","IDN","IND","IOT","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KNA","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MCO","MDA","MDG","MDV","MEX","MHL","MKD","MLI","MLT","MMR","MNE","MNG","MNP","MOZ","MRT","MSR","MTQ","MUS","MWI","MYS","MYT","NAM","NCL","NER","NFK","NGA","NIC","NIU","NLD","NOR","NPL","NRU","NZL","OMN","PAK","PAN","PCN","PER","PHL","PLW","PNG","POL","PRI","PRK","PRT","PRY","PSE","PYF","QAT","REU","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SGS","SHN","SJM","SLB","SLE","SLV","SMR","SOM","SPM","SRB","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCA","TCD","TGO","THA","TJK","TKL","TKM","TLS","TON","TTO","TUN","TUR","TUV","TWN","TZA","UGA","UKR","UMI","URY","USA","UZB","VAT","VCT","VEN","VGB","VIR","VNM","VUT","WLF","WSM","YEM","ZAF","ZMB","ZWE"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fake.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fake[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gcountry = fake[row]
        
        let btn = filterStack.arrangedSubviews[1] as! UIButton
        btn.setTitle(gcountry, for: [])
        
        print("UPDATED GCOUNTRY")
        self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
        
    }
    
    
    
    @objc func country(sender: UIButton!){
      
        if allowf == true {
            
        
      let v = UIViewController()
        v.preferredContentSize = CGSize(width: 250, height: 250) // height: 300
        
            var x:CGFloat = 0.0
            var picker:UIPickerView?
            
            let c = Checker()
            if c.isIpad() {
                picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            } else {
                 x = view.frame.width / 2 - 135
                 picker = UIPickerView(frame: CGRect(x: x, y: 0, width: 250, height: 250))
            }
       
       // let picker = UIPickerView(frame: CGRect(x: v.view.frame.maxX, y: v.view.frame.minY, width: 250, height: 250))
      // let picker = UIView(frame: CGRect(x: v.view.frame.maxX, y: v.view.frame.minY, width: 250, height: 250))
        
        picker!.delegate = self
        picker!.dataSource = self
        v.view.addSubview(picker!)
        
        let sheet = UIAlertController(title: "Country", message: "Filter by country", preferredStyle: .actionSheet)
        sheet.setValue(v, forKey: "contentViewController")
        
     
        let cancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let dis = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
        let nofilter = UIAlertAction(title: "Any", style: .default) { (action) in
            self.gcountry = "ANY"
            // self.filter(gender: "Man", min: 0, max: 10000)
             self.filtera(gender: self.ggender, min: self.gmin, max: self.gmax, country: self.gcountry)
            print("No filter") // filter and reload here
            sender.setTitle("Country", for: [])
        }
        
        
        sheet.addAction(dis)
        sheet.addAction(cancel)
        sheet.addAction(nofilter)
       
        let o = Checker()
        if o.isIpad() || o.isBiggestIpad() {
            sheet.popoverPresentationController?.sourceView = self.view
            sheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            sheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            self.present(sheet, animated: true, completion: nil)
        } else {
            self.present(sheet, animated: true, completion: nil)
        }
       
        }
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UCell.self, forCellReuseIdentifier: "CCell")
        t.separatorColor = .clear // changed in observe block, once data load
        t.backgroundColor = .clear // ??? or white
        return t
    }()
    
    
    
    func getMyData(){

        let uid: String = (Auth.auth().currentUser?.uid)!
        self.ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            let v = s.value as? NSDictionary
            let em = v?["email"] as? String ?? "not found"
            self.passemail = em
            
            //  let filterarr = v?["filter"] as? String ?? "x"
            
            
            let st = v?["stime"] as? String ?? "not found"
            let rt = v?["rtime"] as? String ?? "not found"
            self.passeruntime = rt
            self.passeswimtime = st
            
            let name = v?["nickname"] as? String ?? "not found"
            self.passename = name // necessary ??
            
            let url = v?["url"] as? String ?? "x"
            self.Mnotifurl = url
            
            let fromo = v?["nickname"] as? String ?? "x"
            self.fromsender = fromo
            
            let token = v?["token"] as? String ?? "not found"
            self.sendertoken = token
            
            self.location = "any" // ??????
            
            self.observe() // has to be called when I got my data
        }
    }
    
    func observe(){
       
        
        // make things happen iniside of the block which will get users count and approx size
        
        
        let ref = Database.database().reference()
        ref.child("Users").queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
            var counter = 0
            
            
            for s in snap.children{
                counter += 1
                
            }
            

            var px = 0
            var sx = 0
            
            if self.passeruntime.count > 0 && self.passeswimtime.count > 0 {
                px = self.passeruntime.toSec()
                sx =  self.passeswimtime.toSec()
            }
            
            
            print(" paseruntim \(self.passeruntime) \(self.passeswimtime)  SEX \(sx)")
            
            // print("COUNT OF USERS IS \(counter)")
            
            
            
            
            
            
            let ob = Observer(name: "Users")
            
            let a = Alert()
            let dismiss = UIAlertAction(title: "Do not download", style: .default, handler: { (action) in
                
                ob.observeA(blocked: "", selfmail: self.passemail, selfrun: px, selfswim: sx, download: false) { (res) in
                    
                    self.allowd = false
                    
                    print("CRP \(res.count)")
                    if res.count > 0 {
                        self.real = res
                        
                        self.backup = res
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            // self.loadingLabel.textColor = .white
                            self.tableView.reloadData()
                            self.tableView.alpha = 1
                            self.allowf = true
                            self.loadingLabel.textColor = .white
                            self.tableView.separatorColor = .gray
                        })
                    }
                }
            })
            
            
            /*
             let ok = UIAlertAction(title: "Download", style: .default, handler: { (action) in
             ob.observe(blocked: self.blocked, selfloc: self.location, selfmail: self.email, selfrun: px, selfswim: sx, download: true) { (res) in
             
             
             self.allowd = true
             
             print("CRP \(res.count)")
             if res.count > 0 {
             self.real = res
             
             DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
             //  self.loadingLabel.textColor = .white
             self.tableView.reloadData()
             self.tableView.alpha = 1
             })
             }
             }
             })*/
            
            let ok = UIAlertAction(title: "Download", style: .default, handler: { (action) in
                ob.observeA(blocked: "", selfmail: self.passemail, selfrun: px, selfswim: sx, download: true) { (res) in
                    // dynamic selfmail
                    
                    self.allowd = true
                    
                    print("CRP \(res.count)")
                    if res.count > 0 {
                        self.real = res
                        self.backup = res
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            //  self.loadingLabel.textColor = .white
                            self.tableView.reloadData()
                            self.tableView.alpha = 1
                            self.allowf = true
                            self.loadingLabel.textColor = .white
                            self.tableView.separatorColor = .gray
                        })
                    }
                }
            })
            
            
            // multiply with users.count
            a.show(on: self, title: "", messsage: "Download profile images (\(counter * 2) MB) ?", actions: [ok, dismiss])
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     check()
         UserDefaults.standard.set("all", forKey: "leftat")
        
        let deselect: IndexPath? = tableView.indexPathForSelectedRow
        if let path = deselect {
            tableView.deselectRow(at: path, animated: false)
        }
        
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
     var timer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.check4Notif), userInfo: nil, repeats: true)
        

    }
    
    
    @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    }
    
    
    
    override func viewDidLoad() {
        
       getMyData()
        
        view.backgroundColor = .white
        [titlel, loadingLabel, tableView, filterStack].forEach {view.addSubview($0)}
       
        
        let c = Checker()
        if c.isIpad() {
             filterStack.pin(a: .top, b: .center, ac: 120, bc: 0, w: view.frame.width - 200, h: 40, to: nil)
             self.loadingLabel.pin(a: .top, b: .center, ac: 380, bc: 0, w: self.view.frame.width, h: 60, to: nil)
        } else {
             filterStack.pin(a: .top, b: .center, ac: 120, bc: 0, w: view.frame.width - 30, h: 40, to: nil)
             self.loadingLabel.pin(a: .top, b: .center, ac: 200, bc: 0, w: self.view.frame.width, h: 60, to: nil)
        }
        
       
        
        
        
       

        constrainUI()
    }
    
    var results = ["ww", "dw"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return real.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var ret = 0.0
        
        let c = Checker()
        
        if c.isIpad() {
            ret = 140.0
        } else {
            ret = 100.0
        }
        
        return CGFloat(ret) //   return 100.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CCell") as! UCell
        
      
        let row = indexPath.row
        
      
        
        
        
        let el = real[row]
        
        cell.updateUI(email: el.showNick, swim: el.swim, run: el.run, color: "#3498db", experince: el.experience, image: el.image, nowrite: self.passemail)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        
        
        
        
        let c = Checker()
        
        if c.isIpad() {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        } else {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        }
        
        
        
        
        /*
         if self.allraces.contains(self.results[row]) {
         cell?.textLabel?.textColor = hex("#3498db")
         } else {
         cell?.textLabel?.textColor = UIColor.black
         }
         return cell!*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uid:String = (Auth.auth().currentUser?.uid)!
        
        let user = real[indexPath.row]
        
        let vc = ChatController()
        let sender = self.fromsender
        let Rname = user.showNick
        
        
      
        // DATA ABOUT ME (as Filip)
        vc.from = uid
        vc.toid = real[indexPath.row].uid
        
        vc.Mnotifurl = self.Mnotifurl
        vc.Sname = sender
        vc.sendertoken = self.sendertoken
        vc.location = self.location
        vc.imurl = user.imurl
        
        // DATA ABOUT RECEIVER
        vc.Rname = Rname
        vc.rectoken = user.rectoken
        
        // OTHER DATA
        vc.allowd = allowd
        vc.backtext = "Matches"
        vc.fromnotif = false
        
        
        let vars = [uid,
                    user.uid,
                    self.Mnotifurl,
                    sender,
                    self.sendertoken,
                    self.location,
                    user.imurl,
                    Rname,
                    user.rectoken
        ]
        
        for v in vars {
            print("ITEM \(v) \n")
        }
        
        present(vc, animated: true, completion: nil)
    }
}





extension AllController {
   /* func filter(gender: String, min: Int, max: Int){
        
        self.real = self.backup
        self.real = self.real.filter { Int($0.experience)! >= min && Int($0.experience)! <= max}
        self.tableView.reloadData()
        
        print("SELF:BACKUP \(self.backup.count)")
         // self.real = self.backup // reset data
    } */
    
    
    
    func filtera(gender: String, min: Int, max: Int, country: String){
        
       
            
        
        
        self.real = self.backup
        
         print("GMAX \(gmax) GMIN \(gmin)  GCOUNTRY \(gcountry)    GGENDER \(ggender)  ")
       
        
        var alo = false
        
        print("Users count is \(self.real.count)")
        
        for (i, el) in self.real.enumerated(){
            print("FUser \(i + 1) \(el.experience) NICK \(el.showNick)   \(el.uid)")
            
            // ONE PERSON HAS NOT SET EXPERIENCE (prepare for this)
            
            if self.real[i].experience.count == 0 {
                alo = false
                print("KNOW!!!!")
            }
        }
        
        
        if self.real.count > 0 {
            print("ALO IS \(alo)")
         //   if alo == true {
                if gmax != -1 && gmin != -1 {
                    self.real = self.real.filter {
                        Int($0.experience)! >= min && Int($0.experience)! <= max
                    }
                }
          //  }
            
       
        
        
        if gcountry != "ANY" {
            self.real = self.real.filter {
              $0.country == gcountry
            }
            print("COUNTRYY \(gcountry)")
        }
        
        if ggender != "ANY" {
            self.real = self.real.filter {
                $0.gender == ggender
            }
        }
        
        
        // self.tableView.setContentOffset(.zero, animated: true)  // MAKES BUG
        // let ip = IndexPath(row: 0, section: 0)
        //  self.tableView.scrollToRow(at: ip, at: .top, animated: true)
            
        self.tableView.reloadData()
      
    }
        print("SELF:BACKUP \(self.backup.count)")
        
        
    }
}







//
//  ChatController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 02/09/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var backtext: String = ""
    var allowd:Bool = false
    
    var BCA: NSLayoutConstraint? // FIELD
    var PCA: NSLayoutConstraint? // HEIGHT OF POSTVIEW
    
    
    
    var TA: NSLayoutConstraint?
    var TL: NSLayoutConstraint?
    var TR: NSLayoutConstraint?
    
    var PA:NSLayoutConstraint?
    var PL:NSLayoutConstraint?
    var PR:NSLayoutConstraint?
    
    
    var XT:NSLayoutConstraint?
    var XL:NSLayoutConstraint?
    var XR:NSLayoutConstraint?
    var XB: NSLayoutConstraint?
    
    
    
    var from = "" //
    
    var toid = ""
    var location = ""
    
    
    
    var imurl:String?
    var fromnotif: Bool = false
    
    var rectoken = ""
    var sendertoken = ""
    var Mnotifurl = ""
    
    
    var Rname = ""
    var Sname = ""
    
    
    let ref = Database.database().reference() // or index
    
    var posts = [MS]()
    var dict: [String:String] = [:]
    var sizes = [CGFloat]()
    
    let imgview = Rounded()
    
    let u = UIStackView()
    let topview = UIStackView()
    let st = UIStackView()
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 31, weight: UIFont.Weight.heavy)
        l.text = "Q & A with Petr"
        return l
    }()
    
    let urllabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textAlignment = .center
        l.isHidden = true
        
        return l
    }()
    
    let askfield: UITextView = {
        let f = UITextView()
        f.autocapitalizationType = .none
        f.font = .systemFont(ofSize: 16)
        f.layer.cornerRadius = 6.0
        f.backgroundColor = hex("#ecf0f1")
        return f
    }()
    
    lazy var send: UIButton = {
        let b = UIButton()
        b.setTitle(" Send", for: [])
        b.addTarget(self, action: #selector(self.ask(sender:)), for: .touchUpInside)
        b.setTitleColor(hex("#3498db"), for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        return b
    }()
    
    
    lazy var navBar: UINavigationBar = {
        let n = UINavigationBar()
        n.makeTransparent()
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "←", style: .plain, target: nil, action: #selector(self.back(sender:)))
        // let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(toShare))
        let blockItem = UIBarButtonItem(title: "Report", style: .plain, target: nil, action: #selector(self.report(sender:)))
        
        doneItem.tintColor = .black
        [doneItem, blockItem].forEach {
            $0.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
                ], for: [])
        }
        
        blockItem.tintColor = .black
        
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = blockItem
        n.setItems([navItem], animated: false)
        return n
    }()
    
    
    lazy var postView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(CHTCell.self, forCellReuseIdentifier: "CHCell")
        t.allowsSelection = true
        t.separatorColor = .clear
        
        
        let c = UIDevice.modelName
        
        if c == "iPhone SE" || c == "iPhone 5s" || c == "Simulator iPhone SE" || c == "Simulator iPhone 5s" {
            t.rowHeight = UITableView.automaticDimension
            t.estimatedRowHeight = 600
        }
        
        return t
    }()
    
    let w: UIWebView = {
        let w = UIWebView()
        w.backgroundColor = .white
        w.isHidden = true
        return w
    }()
    
    lazy var closeb: CloseB = {
        let b = CloseB()
        b.setTitle("X", for: [])
        b.addTarget(self, action: #selector(self.close(sender:)), for: .touchUpInside)
        b.isHidden = true
        return b
    }()
    
    
    var webback: UIView = {
        let b = UIView()
        b.backgroundColor = .white
        b.isHidden = true
        return b
    }()
    
    
    @objc func close(sender: UIButton!){
        sender.isHidden = true
        sender.layer.cornerRadius = sender.frame.width / 2
        w.isHidden = true
        webback.isHidden = true
        urllabel.isHidden = true
    }
    
    
    var dislabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 30)
        l.text = "No connection"
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let disview: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#3498db")
        return v
    }()
    
    
    @objc func report(sender: UIButton!){
        let c = ReportViewController()
        c.name = Rname
        c.email = Rname
        present(c, animated: true, completion: nil)
    }
    
    
    @objc func back(sender: UIButton!){
        
        if fromnotif == true {
            
           /* let tab = UITabBarController()
            let match = GroupController()
            match.tabBarItem = UITabBarItem(title: "Races", image: UIImage(named: "refresh.png"), tag: 0)
            
            let profile = EditController()
            profile.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "stpwa.png"), tag: 2)
            
            let all = AllController()
            all.tabBarItem = UITabBarItem(title: "Competitors", image: UIImage(named: "list-icon.png"), tag: 3)
            
            let messages = MessageController()
            messages.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "ruler-7.png"), tag: 4)
            
            
            let list = [match, all, messages, profile]
            tab.viewControllers = list
        
            present(tab, animated: true, completion: nil)*/
            
            let tab = TabController()
            present(tab, animated: false, completion: nil)
            
        } else {
            dismiss(animated: true, completion: nil)
        }
        
        UserDefaults.standard.set(false, forKey: "isinchat")
    }
    
    
    
    
    
    
    
    @objc func ask(sender: UIButton!){
        let t = askfield.text!
        if t.count > 0 {
            post(m: t)
        }
    }
    
    
    
    
    
    lazy var trybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Try again", for: [])
        btn.addTarget(self, action: #selector(self.check), for: .touchUpInside)
        return btn
    }()
    
    @objc func check(){
        let c = Connection()
        
        if c.isConnected() == false {
            addConnectionError()
            disview.isHidden = false
            dislabel.isHidden = false
            trybutton.isHidden = false
            
        } else {
            disview.isHidden = true
            dislabel.isHidden = true
            trybutton.isHidden = true
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        closeb.layer.cornerRadius = 0.5 * closeb.frame.size.width
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "isinchat")
        
        if allowd == true {
            let storage = Storage.storage().reference(forURL: imurl!)
            storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                
                if data != nil {
                    let image = UIImage(data: data!)
                    self.imgview.image = image
                }
            })
            
        } else {
            self.imgview.image = UIImage(named: "ocean.jpg")
        }
        
        postView.scroll()
        
        
        
        
        
        if fromnotif == true {
            
            // print("SHOULD UPDATE \(self.Rname)") // why empty ????
        }
        
        
        let data = ChatData(name: Sname, location: location, from: from, toid: toid, imurl: imurl!, allowd: allowd, mnotifyurl: Mnotifurl, mnotifyname: Rname, sender: Sname, sendertoken: sendertoken, rectoken: rectoken)
        let saver = CHStateSaver(ename: "RChatState", key: "rChatState", obj: data)
        saver.save()
        
        UserDefaults.standard.set("chat", forKey: "leftat")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.Rname
        check()
    }
    
    var hconst:CGFloat = 0.0
    
    // postT, postB, postL, postR
    override func viewDidLoad() {
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        tap.cancelsTouchesInView = false // IMPORTANT
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
      //  nameLabel.text = Sname
        
        
        let c = Checker()
        
        if c.isIpad() || c.isBiggestIpad() {
            nameLabel.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.heavy)
        }
        
        topview.alignment = .center
        topview.axis = .vertical
        
        topview.addArrangedSubview(imgview)
        topview.addArrangedSubview(nameLabel)
        
        [topview, navBar, postView, st, webback, w, closeb, urllabel].forEach {view.addSubview($0)}
        
        closeb.pin(a: .top, b: .right, ac: 30, bc: 30, w: 30, h: 30, to: nil)
        webback.pin(a: .top, b: .left, ac: 0, bc: 0, w: view.frame.width, h: view.frame.height / 2, to: nil)
       
       
        if c.isIpad(){
             urllabel.pin(a: .top, b: .center, ac: 43, bc: 0, w: view.frame.width - 106, h: 30, to: nil)
        } else {
             urllabel.pin(a: .top, b: .left, ac: 30, bc: 20, w: view.frame.width - 106, h: 30, to: nil)
        }
       
        
        
        if c.isIpad() || c.isBiggestIpad() {
            hconst = 220.0
        } else {
            hconst = 160.0
        }
        
        
        
        
        w.bottomPin(top: 80)
        
        // download Heart of glass mp3
        
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        
        [TA, TL, TR].forEach {$0?.isActive = false}
        
        PA = postView.topAnchor.constraint(equalTo: view.topAnchor, constant: hconst)
        PA?.isActive = true
        
        PL = postView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        PL?.isActive = true
        
        PR = postView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        PR?.isActive = true

        
        
        /* if c.isIpad(){
         NSLayoutConstraint.activate([
         postView.topAnchor.constraint(equalTo: view.topAnchor, constant: hconst),
         
         
         postView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130),
         postView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -130),
         ])
         
         } else {
         
         
         }*/
        
      
       
        
        PCA = postView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        PCA!.isActive = true
        
        st.addArrangedSubview(askfield)
        st.addArrangedSubview(send)
        
        st.translatesAutoresizingMaskIntoConstraints = false
        
        XL = st.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        XL?.isActive = true
        XR = st.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        XR?.isActive = true
        
        NSLayoutConstraint.activate([
          //  st.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
          //  st.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            st.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        BCA = st.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        BCA!.isActive = true
        
        
        
        
        
        
      
        
        
      //  st.translatesAutoresizingMaskIntoConstraints = false
        
        
        navBar.pin(a: .top, b: .center, ac: 40, bc: 0, w: view.frame.width - 16, h: 60, to: nil)
       // constrainUI()
        
        
        if c.isIpad() {
            imgview.heightAnchor.constraint(equalToConstant: 90).isActive = true
            imgview.widthAnchor.constraint(equalToConstant: 90).isActive = true
            topview.pin(a: .top, b: .center, ac: /*80 */ 100, bc: 0, w: 700, h: 160, to: nil)
        } else {
            imgview.heightAnchor.constraint(equalToConstant: 53).isActive = true // or 50
            imgview.widthAnchor.constraint(equalToConstant: 53).isActive = true
            topview.pin(a: .top, b: .center, ac: 60, bc: 0, w: 300, h: 105, to: nil)
            
        }
        
        
        let r = UIView()
        r.backgroundColor = UIColor.orange
        view.addSubview(r)
        
        r.alpha = 0.3
        r.isUserInteractionEnabled = false
        observe()
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
          
            [PA, PL, PR].forEach {$0?.isActive = false}
 
            let c = Checker()
            if c.isIpad(){
                TA = postView.topAnchor.constraint(equalTo: view.topAnchor, constant: hconst - 10)
                TA?.isActive = true
            } else {
                TA = postView.topAnchor.constraint(equalTo: view.topAnchor, constant: hconst - 50)
                TA?.isActive = true
            }
            
          
            TL = postView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100)
            TL?.isActive = true
            
            TR = postView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
            TR?.isActive = true
            
            XR?.constant = -70
            XL?.constant = 70
            
            //  ])
        } else {
            [TA, TL, TR].forEach {$0?.isActive = false}

            PA = postView.topAnchor.constraint(equalTo: view.topAnchor, constant: hconst)
            PA?.isActive = true
            
            PL = postView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
            PL?.isActive = true
            
            PR = postView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            PR?.isActive = true
            
            XR?.constant = -20
            XL?.constant = 20
            
        }
            
        
    }
    
    
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHCell", for: indexPath) as! CHTCell
        cell.selectionStyle = .none
        
        let text = posts[indexPath.row]
        // cell.contentView.backgroundColor = hex(posts[indexPath.row].color) // Make in subclass
        
        if text.color == "#3498db" {
            cell.updateUI(m: text.m, isIncoming: false)
        } else {
            cell.updateUI(m: text.m, isIncoming: true)
        }
        
        return cell
    }
    
    /* WONT ALLOW TAP
     func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
     return false
     }*/
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = self.posts[indexPath.row].m
        
        let a = UIAlertController(title: "Actions", message: "", preferredStyle: .actionSheet)
        
        let ac = UIAlertAction(title: "Copy", style: .default) { (action) in
            print("row selected")
            
            UIPasteboard.general.string = post
        }
        
        let open = UIAlertAction(title: "Open website", style: .default) { (action) in
            print("row selected")
            
            // we are in this block, open custom webview
            self.closeb.layer.cornerRadius = self.closeb.frame.width / 2
            self.closeb.isHidden = false
            self.w.isHidden = false
            self.webback.isHidden = false
            self.urllabel.isHidden = false
            
            self.urllabel.text = post
            
            let req = URLRequest(url: URL(string: post)!) // post
            self.w.loadRequest(req)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        
        print(post)
        
        if post.hasPrefix("http://") || post.hasPrefix("https://") || post.hasPrefix("www.") || post.hasSuffix(".com") {
            
            
            
            let c = Checker()
            if c.isIpad(){
                a.popoverPresentationController?.sourceView = self.view
                a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
                a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            }
            
            a.addAction(open)
            a.addAction(ac)
            a.addAction(cancel)
            
            self.present(a, animated: true, completion: nil)
            
            //  s.show(on: self, title: "Copy link", messsage: "Copy link", actions: [ac, open, cancel])
        } else {
            let c = Checker()
            if c.isIpad(){
                a.popoverPresentationController?.sourceView = self.view
                a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
                a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            }
            
            
            
            a.addAction(ac)
            a.addAction(cancel)
            self.present(a, animated: true, completion: nil)
            
        }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = posts[indexPath.row].m
        
        
        
        var awidth:CGFloat = 0.0
        let device = UIDevice.modelName
        
        if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
            awidth = view.frame.width / 2 // 2.3
        } else {
            awidth = 300
        }
        
        // 285 on iphone SE
        
        
        
        let size = CGSize(width: awidth, height: 1000)
        let attr = [kCTFontAttributeName: UIFont.systemFont(ofSize: 17)]
        let estframe = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr as [NSAttributedString.Key : Any], context: nil)
        
        // ADD SUBVIEW "messageLabel" and set constraint to it, solve in "CHTcell" subclass
        //  print("Width: \(estframe.width) text: \(text)")
        
        var ret = CGSize(width: 0, height: 0)
        
        if device == "iPhone SE" || device == "Simulator iPhone SE" || device == "iPhone 5s" || device == "Simulator iPhone 5s" {
            
            
            if text.count < 14 {
                ret = CGSize(width: estframe.width, height: estframe.height + 12)
                // print("< 14 SIZE")
            } else if text.count < 39 {
                ret = CGSize(width: estframe.width, height: estframe.height + 28)
                // print("< 39 SIZE")
            } else {
                //  ret = CGSize(width: estframe.width, height: 1.3 * estframe.height + 260)
                ret = CGSize(width: estframe.width, height: 1.3 * estframe.height + 130) // 260
                // print("< ELSE SIZE")
            }
            
            // + 250
            
        } else {
            ret = CGSize(width: estframe.width, height: estframe.height + 39) // 30 ??
        }
        
        return ret.height
    }
    
    
    
    // https://www.youtube.com/watch?v=B92vSN5K4Rc&t=1393s
    
    
    
    
    
    
    
    
    
    
}









extension ChatController{
    func getWidth(text:String, tsize: CGFloat) -> CGFloat {
        
        let awidth = 300 // 300
        let size = CGSize(width: awidth, height: 1000)
        let attr = [kCTFontAttributeName: UIFont.systemFont(ofSize: tsize)]
        let estframe = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr as [NSAttributedString.Key : Any], context: nil)
        
        let ret = CGSize(width: estframe.width, height: estframe.height + 15)
        return ret.width
    }
}






/*-------------------------------------------------- HANDLE KEYBOARD --------------------------------------------------*/
extension ChatController {
    // https://stackoverflow.com/questions/49346171/how-to-change-layout-constraint-programmatically-in-swift
    
    
    @objc func kbWillShow(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            willShow(ksize: kbsize)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.postView.scroll()
            }
            
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func kbWillHide(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            willHide(ksize: kbsize)
            
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    func willHide(ksize: CGRect){
        BCA?.constant = -30
        PCA?.constant = -90
        // print("WILL HIDE")
        
    }
    
    func willShow(ksize: CGRect){
        BCA?.constant = -(ksize.height + 10)
        PCA?.constant = -(ksize.height + 70) // -19 // postview
        // print("WILL SHOW \(sq)")
    }
    
}






extension ChatController {
    //  var count = 1
    func observe() {
        
        ref.child("Chat").queryOrderedByKey().observe(.childAdded) { (snap) in // or childAdded
            
            let val = (snap.value as? NSDictionary)?["body"] as? String ?? ""
            let from = (snap.value as? NSDictionary)?["from"] as? String ?? ""
            let to = (snap.value as? NSDictionary)?["to"] as? String ?? ""
            
            let curr = Auth.auth().currentUser?.uid
            
            if to == curr! && from == self.toid { // and from == self.toif
                let r = MS(from: from, to: to, m: val, color: "#3498db")
                self.posts.append(r)
                let w = self.getWidth(text: val, tsize: 16)
                self.sizes.append(w)
                self.postView.reloadData()
                self.postView.scroll()
            }
            
            
            if from == curr! && to == self.toid {
                let r = MS(from: from, to: to, m: val, color: "#d3d3d3") // I post
                self.posts.append(r)
                let w = self.getWidth(text: val, tsize: 16)
                self.sizes.append(w)
                self.postView.reloadData()
                self.postView.scroll()
            }
            
            
            // self.count += 1
            
            //  print(" RNAMe \(self.Rname)  FROM \(from)   TO \(to)")
        }
    }
}



extension ChatController {
    
    func post(m: String) {
        
        
        let c = Connection()
        
        if c.isConnected() {
            if (m.count > 0){
                
                // SEND MY DATA THROUGH POST FUNCTION
                let pt = Poster(name: "Chat")
                
                var vrectoken = rectoken
                var vsendertoken = self.sendertoken
                
                print("POST \(Rname) SNAME \(Sname)")
                // Switch rectoken and sendertoken when opening from notification
                if fromnotif == true {
                    vsendertoken = rectoken
                    vrectoken = self.sendertoken
                }
                
                // DECIDE FROM NOTIF ONLY IN APPDELEGATE AND MATCH VC !!!!
                pt.post(to: toid,
                        rname: Rname,
                        sname: Sname, message: m,
                        location: self.location,
                        imageurl: Mnotifurl,
                        rectoken: vrectoken,
                        sendertoken: vsendertoken)
                
                askfield.text = ""
                
                
                var wrong = "" // may be "a"
                
                if toid == "" {
                    wrong += "TOID" + "\n"
                }
                
                if Rname == "" {
                    wrong += "NAME" + "\n"
                }
                
                if m == "" {
                    wrong += "M" + "\n"
                }
                
                if self.location == "" {
                    wrong += "SELF.LOCATION" + "\n"
                }
                
                if Mnotifurl == "" {
                    wrong += "Mnotifurl" + "\n"
                }
                
                if Sname == "" {
                    wrong += "SENDER" + "\n"
                }
                
                if rectoken == "" {
                    wrong += "RECTOKEN" + "\n"
                }
                
                if sendertoken == ""{
                    wrong += "SENDERTOKEN"
                }
                
                
            }
        } else {
            let a = Alert()
            let dis = UIAlertAction(title: "Okay", style: .default, handler: nil)
            a.show(on: self, title: "Message was not sent.", messsage: "Connect to the internet.", actions: [dis])
        }
        
        
        
    }
}



//
//  MessageController.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 16/02/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase


class MessageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passemail = ""
    var passeruntime = ""
    var passeswimtime = ""
    var passename = ""
    var sendertoken = ""
    var location = ""
    
    var allowd = false
    var fromsender = ""
    var Mnotifurl = ""
    

    var reversed = false
    
    var allowedfetch = [String]()
    
    // get all messages sent to me
    
    
    var mbyname = [[String]]()
    var sub = [String]()
    
  
    
    
    var psswim = ""
    var psrun = ""
    
  //  var multim = [[String]]()
    
    class Post {
        var from: String
        var sender: String
        var message: String
        
        init(from: String, sender: String, message: String) {
            self.from = from
            self.sender = sender
            self.message = message
        }
    }
    
        var globalAll = [Post]()
    
    var posts = [Post]()
    
    var real = [User]()
    
    var timer:Timer?
    
    
    
    @objc func callin6sec(){
        if self.real.count == 0 {
            self.loadingLabel.text = "Messages unavailable"
        }
    }
    
    var loadingLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Loading..."
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()

    var titlel: UILabel = {
        var l = UILabel()
        l.text = "Messages"
        //  l.font = UIFont.boldSystemFont(ofSize: 38)
        
        let c = Checker()
        if c.isIpad() || c.isBiggestIpad() {
            l.font = UIFont.systemFont(ofSize: 55, weight: UIFont.Weight.heavy)
        } else {
            l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        }
        
        // heavy? or medium? , x black
        l.textColor = .black // gray
        return l
    }()
    
    
    
    /*
     
     Fetch only users, who have sent me a message
     
     
     
     
     
     */
    
    

    
    let ob = Observer(name: "Users")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return real.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCCell") as! MessageCell
        
       
        var r = getForUser(sname: real[row].showNick, allmessages: globalAll)
        r = r.reversed()
        let latest = r[r.count - 1].message
       /* cell.textLabel?.text = real[row].showNick + "//     " + latest */
        cell.updateUI(name: real[row].showNick, message: latest)
        //"\(posts[row].sender):  \(posts[row].message)"
        return cell
        
        // fix posts[row]
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
   
    
    func getMyData(){
        
         let uid: String = (Auth.auth().currentUser?.uid)!
         self.ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            let v = s.value as? NSDictionary
            let em = v?["email"] as? String ?? "not found"
            self.passemail = em
            
            //  let filterarr = v?["filter"] as? String ?? "x"
            
            
            let st = v?["stime"] as? String ?? "not found"
            let rt = v?["rtime"] as? String ?? "not found"
            self.passeruntime = rt
            self.passeswimtime = st
            
            let name = v?["nickname"] as? String ?? "not found"
            self.passename = name // necessary ??
            
            let url = v?["url"] as? String ?? "x"
            self.Mnotifurl = url
            
            let fromo = v?["nickname"] as? String ?? "x"
            self.fromsender = fromo
            
            let token = v?["token"] as? String ?? "not found"
            self.sendertoken = token
            
            self.location = "any" // ??????
            
            self.observe() // has to be called when I got my data
        }
    }
    
    /*
    func justWhoSent(){
       var next = [User]()
        
        for r in real {
            if r.rectoken == uid {
                next.append(r)
            }
        }
        
        
        self.real = next
        self.tableView.reloadData()
        
        print("Next is \(next.count)")
    }*/
    
    
    func observe(){
   
            
            
            // make things happen iniside of the block which will get users count and approx size
            
            
            let ref = Database.database().reference()
            ref.child("Users").queryOrderedByKey().observeSingleEvent(of: .value) { (snap) in
                var counter = 0
                
                
                for s in snap.children{
                    counter += 1
                    
                }
                
                
                var px = 0
                var sx = 0
                
                if self.passeruntime.count > 0 && self.passeswimtime.count > 0 {
                    px = self.passeruntime.toSec()
                    sx =  self.passeswimtime.toSec()
                }
                
                
               print("GOT IT")
                
                // print("COUNT OF USERS IS \(counter)")
                
                
                
                let ob = Observer(name: "Users")
                
                ob.observeIfSent(letin: self.allowedfetch, blocked: "", selfmail: self.passemail, selfrun: px, selfswim: sx, download: false) { (res) in
                    
                    self.allowd = false
                    
                    print("STARWARS \(res.count)")
                    
                    if res.count > 0 {
                        self.real = res
                        print("170 \(self.real.count)")
                        
                      /*  for x in self.real {
                            self.getForUser(sname: x.showNick, allmessages: self.globalAll)
                        }*/
                        
                        
                        //  self.backup = res
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.loadingLabel.textColor = .clear
                            self.tableView.reloadData()
                            //print(self.multim)
                        })
                    } else {
                        self.loadingLabel.text = "No messages"
                    }
                }
                
               
            }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
         UIApplication.shared.applicationIconBadgeNumber = 0
        
         UserDefaults.standard.set("read", forKey: "highlight")
        
        
        
         print("SELECTED")
        
         let uid:String = (Auth.auth().currentUser?.uid)!
         
         let user = real[indexPath.row]
         
         let vc = ChatController()
         let sender = self.fromsender
         let Rname = user.showNick
         
         
         
         // DATA ABOUT ME (as Filip)
         vc.from = uid
         vc.toid = real[indexPath.row].uid
         
         vc.Mnotifurl = self.Mnotifurl
         vc.Sname = sender
         vc.sendertoken = self.sendertoken
         vc.location = self.location
         vc.imurl = user.imurl
         
         // DATA ABOUT RECEIVER
         vc.Rname = Rname
         vc.rectoken = user.rectoken
         
         // OTHER DATA
         vc.allowd = allowd
         vc.backtext = "Matches"
         vc.fromnotif = false
         
         
         let vars = [uid,
         user.uid,
         self.Mnotifurl,
         sender,
         self.sendertoken,
         self.location,
         user.imurl,
         Rname,
         user.rectoken
         ]
         
         for v in vars {
         print("ITEM \(v) \n")
         }
         
         present(vc, animated: true, completion: nil)
         
         
         
         
        }
   
    

    let ref = Database.database().reference()
    
    var timerb:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
          print("DID LOAD")
          timer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(callin6sec), userInfo: nil, repeats: false)
        
        fetchMessages()
        getMyData()
        
        
        [tableView, titlel, loadingLabel].forEach {view.addSubview($0)}
       
        let c = Checker()
        
        if c.isIpad() == true { // show whole name height
           titlel.pin(a: .top, b: .left, ac: 20, bc: 16, w: view.frame.width, h: 65, to: nil)
        } else {
           titlel.pin(a: .top, b: .left, ac: 35, bc: 16, w: view.frame.width, h: 50, to: nil)
        }
        
        
        if c.isIpad() {
            self.loadingLabel.pin(a: .top, b: .center, ac: 350, bc: 0, w: self.view.frame.width, h: 60, to: nil)
        } else {
            self.loadingLabel.pin(a: .top, b: .center, ac: 250, bc: 0, w: self.view.frame.width, h: 60, to: nil)
        }
        
     
        tableView.bottomPin(top: 110)
       
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "isinchat")
        UserDefaults.standard.set("messages", forKey: "leftat")
       
        print("DID APPEAR")
        
        let deselect: IndexPath? = tableView.indexPathForSelectedRow
        if let path = deselect {
            tableView.deselectRow(at: path, animated: false)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.check4Notif), userInfo: nil, repeats: true)

        
     //   timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.check4Notif), userInfo: nil, repeats: true)

      
    }
    
    
    @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    }
    
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(MessageCell.self, forCellReuseIdentifier: "MCCell")
        t.separatorColor = .clear // changed in observe block, once data load
        t.backgroundColor = .clear // ??? or white
        return t
    }()
    
    /*
    lazy var navBar: UINavigationBar = {
        let n = UINavigationBar()
        n.makeTransparent()
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "←", style: .plain, target: nil, action: #selector(self.back(sender:)))
        // let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(toShare))
       // let blockItem = UIBarButtonItem(title: "Report", style: .plain, target: nil, action: #selector(self.report(sender:)))
        
        doneItem.tintColor = .black
        [doneItem].forEach {
            $0.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
                ], for: [])
        }
        
       
        
        navItem.leftBarButtonItem = doneItem
      
        n.setItems([navItem], animated: false)
        return n
    }()
    
    @objc func back(sender: UIButton!){
    dismiss(animated: true, completion: nil)
    }*/
    
    
   
    
    func fetchMessages(){
        
        
        print("FETCHING...")
        self.posts.removeAll()
        self.allowedfetch.removeAll()
        
        ref.child("Chat").queryOrderedByKey().observe(.childAdded) { (snap) in // or childAdded
            
            let val = (snap.value as? NSDictionary)?["body"] as? String ?? ""
            let from = (snap.value as? NSDictionary)?["from"] as? String ?? ""
            let to = (snap.value as? NSDictionary)?["to"] as? String ?? ""
            let sname = (snap.value as? NSDictionary)?["sname"] as? String ?? ""
            
            let curr = Auth.auth().currentUser?.uid
            
            
            // 1 - get all messages from Peter, and all messages fro Nancya
            
            // get "w.key" for each User (send SENDER UID through each message)
            if to == curr! { // and from == self.toif
                print("\(sname): \(val)")
                let post = Post(from: to, sender: sname, message: val)
                self.posts.insert(post, at: 0)
                
                self.allowedfetch.append(from)
               
              /*  if self.reversed == false {
                    print("REVE")
                     self.posts.reverse()
                    self.reversed = true
                } */
                
                
                
                
                
               self.globalAll.insert(post, at: 0)
                
                self.tableView.reloadData()
                
                let ip = IndexPath(row: 0, section: 0)
               // self.tableView.scrollToRow(at: ip, at: .top, animated: true)
               // self.tableView.setContentOffset(.zero, animated: true)
            }
        }
        
        
     
    }
    
    
    func getForUser(sname: String, allmessages: [Post]) -> [Post]{
        var al = [Post]()
        al = allmessages.filter {$0.sender == sname}
        print(al)
        
        return al
    }
    
}



//
//  ReportViewController.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 08/12/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase


class ReportViewController: UIViewController {

    var name = ""
    var email = ""
    
    var titlel: UILabel = {
        var l = UILabel()
        l.text = "Report"
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        l.textColor = .black
        return l
    }()
    
    var contentL: UITextView = {
        let l = UITextView()
        l.font = UIFont.boldSystemFont(ofSize: 23)
        l.textAlignment = .center
        l.isEditable = false
        l.isSelectable = false
        l.isScrollEnabled = false
        return l
    }()
    
    var reportfield: UITextView = {
        let l = UITextView()
        l.font = UIFont.systemFont(ofSize: 19)
        l.layer.borderColor = UIColor.black.cgColor
        l.layer.cornerRadius = 6.0
        l.layer.borderWidth = 2.0
        l.autocorrectionType = .no
        return l
    }()
    
    

    lazy var navBar: UINavigationBar = {
        let n = UINavigationBar()
        n.makeTransparent()
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "←", style: .plain, target: nil, action: #selector(self.back(sender:)))
        // let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(toShare))
        let blockItem = UIBarButtonItem(title: "Block", style: .plain, target: nil, action: #selector(self.block(sender:)))
        
        doneItem.tintColor = .black
        [doneItem, blockItem].forEach {
            $0.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            ], for: [])
            
        }
        
        blockItem.tintColor = .black
        
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = blockItem
        n.setItems([navItem], animated: false)
        return n
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         UserDefaults.standard.set(false, forKey: "isinchat")
    }
    /*
    lazy var blockbtn: UIButton = {
        let b = BMaker(title: "Block", color: "#000000", size: 21, action: #selector(self.block(sender:)))
        return b.gen()
    }()*/
    
    @objc func block(sender: UIButton!){
    
    let c = Checker()
    if c.isIpad(){
        
        let a = UIAlertController(title: "Block \(self.name)", message: "Do you really want to block \(self.name) ?", preferredStyle: .alert)
        
    
        let decline = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let block = UIAlertAction(title: "Block", style: .destructive) { (action) in
            let bl = Blocker()
            bl.block(blocked: self.email)
            print("Email has been blocked.")
            
            let r = Alert()
            let ac = UIAlertAction(title: "OK", style: .default, handler: {(action) in
                
             /*   let tab = UITabBarController()
                let match = GroupController()
                match.tabBarItem = UITabBarItem(title: "Races", image: UIImage(named: "refresh.png"), tag: 0)
                
                let profile = EditController()
                profile.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "stpwa.png"), tag: 2)
                
                let all = AllController()
                all.tabBarItem = UITabBarItem(title: "Competitors", image: UIImage(named: "list-icon.png"), tag: 3)
                
                let messages = MessageController()
                messages.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "ruler-7.png"), tag: 4)
                
                /* let qa = QAController()
                 qa.tabBarItem = UITabBarItem(title: "Q & A", image: UIImage(named: "rss-7.png"), tag: 3) */
                
                let list = [match, all, messages, profile]
                /* let qa = QAController()
                 qa.tabBarItem = UITabBarItem(title: "Q & A", image: UIImage(named: "rss-7.png"), tag: 3) */
                
               
                tab.viewControllers = list
               
                self.present(tab, animated: true, completion: nil)
 
 */
                let tab = TabController()
                self.present(tab, animated: false, completion: nil)
                
                
                
            })
            r.show(on: self, title: "User blocked", messsage: "User \(self.name) has been blocked.", actions: [ac])
            
        }
        
        //a.show(on: self, title: "Are you sure?", messsage: "Do you really want to block \(name)?", actions: [block, decline])
        
        a.addAction(block)
        a.addAction(decline)
        
        a.popoverPresentationController?.sourceView = self.view
        a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        
        present(a, animated: true, completion: nil)
        
        
        
        
        
    } else {
        let a = Sheet()
        let decline = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let block = UIAlertAction(title: "Block", style: .destructive) { (action) in
            let bl = Blocker()
            bl.block(blocked: self.email)
            print("Email has been blocked.")
            
            let r = Alert()
            let ac = UIAlertAction(title: "OK", style: .default, handler: {(action) in
                
             /*   let tab = UITabBarController()
                let match = GroupController()
                match.tabBarItem = UITabBarItem(title: "Races", image: UIImage(named: "refresh.png"), tag: 0)
                
                let profile = EditController()
                profile.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "stpwa.png"), tag: 2)
                
                
                let messages = MessageController()
                messages.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "ruler-7.png"), tag: 4)
                
                
                let all = AllController()
                all.tabBarItem = UITabBarItem(title: "Competitors", image: UIImage(named: "list-icon.png"), tag: 3)
                
                
                /* let qa = QAController()
                 qa.tabBarItem = UITabBarItem(title: "Q & A", image: UIImage(named: "rss-7.png"), tag: 3) */
                
                let list = [match, all, messages, profile]
                tab.viewControllers = list
              
                self.present(tab, animated: true, completion: nil)
                */
                
                let tab = TabController()
                self.present(tab, animated: false, completion: nil)
                
                
                
            })
            r.show(on: self, title: "User blocked", messsage: "User \(self.name) has been blocked.", actions: [ac])
            
        }
        
        a.show(on: self, title: "Are you sure?", messsage: "Do you really want to block \(name)?", actions: [block, decline])
        }
        
    
   
    }
    
    /*
    lazy var back: UIButton = {
        let b = UIButton()
        b.setTitle("<", for: [])
        b.addTarget(self, action: #selector(self.back(sender:)), for: .touchUpInside)
        b.setTitleColor(UIColor.black, for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return b
    }()*/
    
    @objc func back(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    
    lazy var send: UIButton = {
        let b = UIButton()
        b.setTitle("Send", for: [])
        b.addTarget(self, action: #selector(self.send(sender:)), for: .touchUpInside)
        b.setTitleColor(UIColor.black, for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return b
    }()
    
    @objc func send(sender: UIButton!){
        let text = reportfield.text
        
        if text!.count > 0 {
        let ref = Database.database().reference()
        let data = ["User": name, "message": text]
        ref.child("Reports").childByAutoId().updateChildValues(data)
     
        let a = Alert()
        let dismiss = UIAlertAction(title: "Okay", style: .default) { (action) in
        }
        a.show(on: self, title: "Report sent", messsage: "Report has been successfully sent", actions: [dismiss])
        } else {
            
            let a = Alert()
            let dismiss = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            a.show(on: self, title: "Report empty", messsage: "Please enter your message", actions: [dismiss])
        }
        
        
        reportfield.text = nil
        
       // dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        [titlel, contentL, send, reportfield, navBar].forEach {view.addSubview($0 as! UIView)}
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        contentL.text = "Tell us what's wrong."
       
        navBar.pin(a: .top, b: .center, ac: 40, bc: 0, w: view.frame.width - 4, h: 60, to: nil)
        
        let model = UIDevice.modelName
        
        let c = Checker()
        
        if c.isIpad() == true { // show whole name height
            reportfield.pin(a: .top, b: .center, ac: 320, bc: 0, w: view.frame.width - 50, h: 190, to: nil)
            titlel.pin(a: .top, b: .left, ac: 90, bc: 16, w: view.frame.width, h: 52, to: nil)
            send.pin(a: .top, b: .center, ac: 540, bc: 0, w: 90, h: 30, to: nil)
            contentL.pin(a: .top, b: .center, ac: 220, bc: 0, w: view.frame.width, h: 170, to: nil)
       
        } else if model == "iPhone SE" || model == "Simulator iPhone SE" || model == "iPhone 5s" || model == "Simulator iPhone 5s"  {
            reportfield.pin(a: .top, b: .center, ac: 200, bc: 0, w: view.frame.width - 50, h: 100, to: nil)
            titlel.pin(a: .top, b: .left, ac: 55, bc: 16, w: view.frame.width, h: 52, to: nil)
            send.pin(a: .top, b: .center, ac: 300, bc: 0, w: 90, h: 30, to: nil)
            contentL.pin(a: .top, b: .center, ac: 186, bc: 0, w: view.frame.width, h: 170, to: nil)
        }
        
        else { // iPhone
            contentL.pin(a: .top, b: .center, ac: 220, bc: 0, w: view.frame.width, h: 170, to: nil)
            reportfield.pin(a: .top, b: .center, ac: 280, bc: 0, w: view.frame.width - 20, h: 210, to: nil)
            titlel.pin(a: .top, b: .left, ac: 50, bc: 16, w: view.frame.width, h: 45, to: nil)
            send.pin(a: .top, b: .center, ac: 430, bc: 0, w: 90, h: 30, to: nil)
        }
       
        //  back.pin(a: .top, b: .left, ac: 25, bc: 0, w: 60, h: 120, to: nil)
    }
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    @objc func kbWillShow(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            print("Keyboards will show")
            
            if view.frame.origin.y == 0 {
               
        
                
              //  self.view.frame.origin.y -= (kbsize.height - 20)
                
                
            }
        }
    }
    
    
    @objc func kbWillHide(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("Keyboards will hide")
            
            if view.frame.origin.y != 0 {
               
                
               // self.view.frame.origin.y += (kbsize.height - 20)
               
            }
        }
    }
    

   
}






//
//  EditController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 27/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class EditController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate {
    
    //    let supported = ["Prague", "Zlin", "Otrokovice"]
    
    
    var new = [RO]()
    var side = [RO]()
    // var saveids = [Int]()
    var years = 0
    

    var selected: UIImage?
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "RNCell")
        t.alpha = 0
        // t.frame = CGRect(x: 0, y: 290, width: view.frame.width, height: 180)
        return t
    }()
    
    let background: UIView = {
        let v = UIView()
        // v.backgroundColor = hex("#3498db")
        v.backgroundColor = .white
        return v
    }()
    
    
    // Seaching
    var isSearching = false
    var filtered = [RO]()
    
     lazy var searchbar: UISearchBar = {
        let s = UISearchBar()
        s.delegate = self
        s.returnKeyType = .done
        s.alpha = 0
        s.transluescent()
        s.placeholder = "Search races"
       // s.layer.borderColor = UIColor.gray.cgColor
       // s.layer.cornerRadius = 4.0
        
        return s
    }()
    
    
    let lbl: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        l.text = "Settings"
        return l
    }()
    
    let lstack: UIStackView = {
        let l = UIStackView()
        l.axis = .vertical
        l.distribution = .fillEqually
        return l
    }()
    
    let nickField: UITextField = {
        let f = UITextField()
        f.tag = 1
        f.textColor = hex("#000000")
        
        let c = Checker()
        if c.isIpad() {
            f.font = UIFont.systemFont(ofSize: 75, weight: UIFont.Weight.heavy)
        } else {
            f.font = UIFont.systemFont(ofSize: 41, weight: UIFont.Weight.heavy)
        }
        
        
        
       //UIFont.boldSystemFont(ofSize: 41) // 23
        f.placeholder = "nickname"
        return f
    }()
    
    /*
    let efield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.textColor = hex("#000000")
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "email"
        return f
    }()*/
    
    let swimfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.textColor = hex("#000000")
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "1k swim time"
        return f
    }()
    
    let runfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.textColor = hex("#000000")
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "10k run time"
        return f
    }()
    
    
    let experiencefield: Numeric = {
        let f = Numeric()
        f.autocapitalizationType = .none
        f.textColor = hex("#000000")
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "races"
        f.textAlignment = .center
        f.keyboardType = .numberPad
        return f
    }()
    
    let nicknamefield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "name"
        return f
    }()
    
    let minSwim: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "••"
        f.keyboardType = .numberPad
        f.textColor = hex("#000000")
        f.textAlignment = .center
        return f
    }()
    
    let secSwim: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "••"
        f.keyboardType = .numberPad
        f.textColor = hex("#000000")
        f.textAlignment = .center
        return f
    }()
    
    
    let minRun: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "••"
        f.keyboardType = .numberPad
        f.textColor = hex("#000000")
        f.textAlignment = .center
        return f
    }()
    
    let secRun: Numeric = {
        let f = Numeric()
        f.font = UIFont.boldSystemFont(ofSize: 23)
        f.placeholder = "••"
        f.keyboardType = .numberPad
        f.textColor = hex("#000000")
        f.textAlignment = .center
        return f
    }()
    
    
    let infoswim: UILabel = {
        let l = UILabel()
        l.text = "1k swim:"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = hex("#000000")
        return l
    }()
    
    let inforun: UILabel = {
        let l = UILabel()
        l.text = "10k  run:"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = hex("#000000")
        return l
    }()
    
    let infoexp: UILabel = {
        let l = UILabel()
        l.text = "races done:"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = hex("#000000")
        return l
    }()
    
    let dot: UILabel = {
        let l = UILabel()
        l.text = ":"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = hex("#000000")
        l.textAlignment = .center
        return l
    }()
    
    let dota: UILabel = {
        let l = UILabel()
        l.text = ":"
        l.font = UIFont.boldSystemFont(ofSize: 21)
        l.textColor = hex("#000000")
        l.textAlignment = .center
        return l
    }()
    
    
    
    lazy var sheetbtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "3-dots.png"), for: [])
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor.white, for: [])
        btn.addTarget(self, action: #selector(self.addSheet(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var dislabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 30)
        l.text = "No connection"
        l.textAlignment = .center
        l.textColor = hex("#ffffff")
        return l
    }()
    
    let disview: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#3498db")
        return v
    }()
    
    var timer: Timer?
    
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.check4Notif), userInfo: nil, repeats: true)

    }
    
    @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    }

    
    /*
     let secRun: UITextField = {
     let f = UITextField()
     f.font = UIFont.boldSystemFont(ofSize: 23)
     f.placeholder = "ss"
     f.keyboardType = .numberPad
     return f
     }()
     
     let infoswim: UILabel = {
     let l = UILabel()
     l.text = "1k swim:"
     l.font = UIFont.boldSystemFont(ofSize: 21)
     l.textColor = .white
     return l
     }()
     */
    
  /*  @objc func check4Notif(){
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            tabBarController?.tabBar.items?[2].badgeValue = "1"
        } else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
        }
        // eyJhbGciOiJSUzI1Ni
        
        if let val = UserDefaults.standard.value(forKey: "highlight") as? String {
            
            if val == "OP" {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            } else if val == "read" {
            } else {
                print("ELSELVAL \(val)")
            }
            
        } else {
            print("STILL NOTHING")
        }
    } */
    
    
    @objc func addSheet(sender: UIButton){
       
        
        
        let device = UIDevice.modelName
        
        
        /*
         :return "iPad 2"
         case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
         case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
         case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
         case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
         case "iPad6,11", "iPad6,12":                    return "iPad 5"
         case "iPad7,5", "iPad7,6":                      return "iPad 6"
         case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
         case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
         case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
         case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
         case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
         case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
         case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
         case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
         case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
         case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
         */
        
      //  let devices = ["iPad Pro (12.9-inch) (3rd generation)", "iPad Pro (11-inch)", "iPad Pro (10.5-inch)", "iPad Pro (12.9-inch) (2nd generation)", "iPad Pro (12.9-inch)", "iPad Pro (9.7-inch)", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad Air 2", "iPad Air"]
       
        
        let c = Checker()
        if c.isIpad() { // We are on the iPad
            
            let a = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let send = UIAlertAction(title: "Contact us", style: .default) { (action) in
                self.sendMail()
            }
            
            let privacy = UIAlertAction(title: "Privacy", style: .default) { (action) in
               // let url = URL(string: "https://filipvabrousek.weebly.com/privacy.html")
                //UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                let pr = PrivacyController()
                self.present(pr, animated: true, completion: nil)
            }
            
            
            // resize image before uploading and test on iPad Simulator !!!
            
            let logout = UIAlertAction(title: "Log out", style: .destructive) { (action) in
                let del = Eraser(ename: "Users") // remove user from core data
                del.erase()
                
                UserDefaults.standard.set("YES", forKey: "isout")
                let lc = LogController()
                self.present(lc, animated: true, completion: nil)
            }
            
            let deleteAccount = UIAlertAction(title: "Delete account", style: .default) { (action) in
            
             let ac = Alert()
                
                let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    
                     
                  //   https://stackoverflow.com/questions/49575903/swift4-delete-user-accounts-from-firebase-authentication-system
                     
                     let user = Auth.auth().currentUser
                     
                     user?.delete(completion: { (err) in
                     /*
                     if let err = err {
                   
                     } else {
                     self.present(SignController(), animated: true, completion: nil)
                     }*/
                        if let err = err {
                            print("Something went wrong with Deletion \(err)")
                            let ac = Alert()
                            let dis = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            ac.show(on: self, title: "Something went wrong", messsage: "\(err.localizedDescription)", actions: [dis])
                            
                            
                            
                        } else {
                            self.present(LogController(), animated: true, completion: nil)
                        }
                     
                     })
                })
                
                let cancel = UIAlertAction(title: "Keep", style: .default, handler: { (action) in
                    
                })
                
                
                ac.show(on: self, title: "Are you sure ?", messsage: "Do you really want to remove account", actions: [cancel, delete])
            
                
                
            }
            
            /*
             let deleteAccount = UIAlertAction(title: "Delete account", style: .destructive) { (action) in
             let ac = Alert()
             
             let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
             /*
             
             https://stackoverflow.com/questions/49575903/swift4-delete-user-accounts-from-firebase-authentication-system
             
             let user = Auth.auth().currentUser
             
             user?.delete(completion: { (err) in
             
             if let err = err {
             print("Something went wrong with Deleteion")
             } else {
             self.present(SignController(), animated: true, completion: nil)
             }
             
             })*/
             })
             
             
             let cancel = UIAlertAction(title: "Kepp", style: .default, handler: { (action) in
             
             })
             
             
             ac.show(on: self, title: "Are you sure ?", messsage: "Do you really want to remove account", actions: [delete, cancel])
             }
             
             
             let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
             }
             
             // remove change races in the code
             a.show(on: self, title: nil, messsage: nil, actions: [send, privacy, deleteAccount, logout, dismiss])
             }

             */
            
            
            
            
            
            /*
            let change = UIAlertAction(title: "Change races", style: .default) { (action) in
                if self.tableView.alpha == 1 {
                    UIView.animate(withDuration: 0.4) {
                        self.tableView.alpha = 0// hide table view
                        self.searchbar.alpha = 0
                        self.hidebtn.alpha = 0 // show hider
                        self.main.alpha = 1
                        
                    }
                } else {
                    UIView.animate(withDuration: 0.4) {
                        self.tableView.alpha = 1// hide table view
                        self.searchbar.alpha = 1
                        self.hidebtn.alpha = 1 // show hider
                        self.main.alpha = 0
                    }
                }
            }
            */
         
           
            a.addAction(send)
            
            a.addAction(privacy)
            a.addAction(logout)
         //   a.addAction(deleteAccount)
            
          //  a.addAction(dismiss)
            
            a.popoverPresentationController?.sourceView = self.view
            a.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            a.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            
            self.present(a, animated: true, completion: nil)
            
            
            
           // self.present(sheet, animated: true, completion: nil)
            
        } else {
            let a = Sheet()
            let send = UIAlertAction(title: "Contact us", style: .default) { (action) in
                self.sendMail()
            }
            
            let logout = UIAlertAction(title: "Log out", style: .destructive) { (action) in
                let del = Eraser(ename: "Users") // remove user from core data
                del.erase()
                
                UserDefaults.standard.set("YES", forKey: "isout")
                let lc = LogController()
                self.present(lc, animated: true, completion: nil)
            }
            
            
            
            let privacy = UIAlertAction(title: "Privacy", style: .default) { (action) in
               /* let url = URL(string: "https://filipvabrousek.weebly.com/privacy.html")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)*/
                let pr = PrivacyController()
                self.present(pr, animated: true, completion: nil)
            }
            
            
            /*
            let change = UIAlertAction(title: "Change races", style: .default) { (action) in
                if self.tableView.alpha == 1 {
                    UIView.animate(withDuration: 0.4) {
                        self.tableView.alpha = 0// hide table view
                         self.searchbar.alpha = 0
                        self.hidebtn.alpha = 0 // show hider
                        self.main.alpha = 1
                    }
                } else {
                    UIView.animate(withDuration: 0.4) {
                        self.tableView.alpha = 1// hide table view
                        self.searchbar.alpha = 1
                        self.hidebtn.alpha = 1 // show hider
                        self.main.alpha = 0
                    }
                }
            }*/
            
            
            let deleteAccount = UIAlertAction(title: "Delete account", style: .default) { (action) in
                let ac = Alert()
                
                let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    
                     
                   // https://stackoverflow.com/questions/49575903/swift4-delete-user-accounts-from-firebase-authentication-system
                    
                     let user = Auth.auth().currentUser
                     
                     user?.delete(completion: { (err) in
                     
                     if let err = err {
                     print("Something went wrong with deletion \(err)")
                    let ac = Alert()
                    let dis = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        ac.show(on: self, title: "Something went wrong", messsage: "\(err.localizedDescription)", actions: [dis])
                        
                        
                        
                     } else {
                     self.present(LogController(), animated: true, completion: nil)
                     }
                     
                     })
                })
                
                
                let cancel = UIAlertAction(title: "Keep", style: .default, handler: { (action) in
                    
                })
                
                
                ac.show(on: self, title: "Are you sure ?", messsage: "Do you really want to remove account", actions: [cancel, delete])
            }
            
            
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
            }
            
            // remove change races in the code
            a.show(on: self, title: nil, messsage: nil, actions: [send, privacy, logout, dismiss])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        return true
    }
    
    var explabel: UILabel = {
        var l = UILabel()
        l.text = "exp"
        l.textColor = hex("#3498db")
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 21)
        return l
    }()
    
    
    lazy var stepper: UIStepper = {
        let s = UIStepper()
        s.wraps = false // do not resume from beginning
        s.autorepeat = true // stepper will inrement on hold
        s.maximumValue = 100 // max 100 years
        s.tintColor = hex("#3498db")
        s.addTarget(self, action: #selector(self.step(sender:)), for: .touchUpInside)
        return s
    }()
    
    
    
    var infol: UILabel = {
        var l = UILabel()
        l.textAlignment = .center
        l.textColor = hex("#3498db")
        l.text = "Enter number of swimruns finished"
        return l
    }()
    
    
    lazy var imgview: Rounded = {
        let r = Rounded()
        return r
    }()
    
    
    
    
    lazy var savebtn: AddB = {
       /* let b = UIButton()
        b.setTitle("Save", for: [])
        b.setTitleColor(hex("#3498db"), for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        b.addTarget(self, action: #selector(self.update(sender:)), for: .touchUpInside)
        return b*/
        
        let b = AddB()
        b.setTitle("Save", for: [])
        b.setTitleColor(hex("#ffffff"), for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.addTarget(self, action: #selector(self.update(sender:)), for: .touchUpInside)
        b.backgroundColor = hex("#3498db")
        return b
    }()
    
    
    lazy var logoutb: UIButton = {
        let b = UIButton()
        b.setTitle("LOG OUT", for: [])
        b.setTitleColor(UIColor.white, for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        b.addTarget(self, action: #selector(self.logout(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    var v: UIView = {
        let v = UIView()
        v.backgroundColor = hex("#f7f8f8")
        return v
    }()
    
    var stepperLabel: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.text = "----"
        l.textAlignment = .center
        return l
    }()
    
    
    lazy var trybutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Try again", for: [])
        btn.addTarget(self, action: #selector(self.check), for: .touchUpInside)
        return btn
    }()
    
    lazy var hidebtn: UIButton = {
        let b = UIButton()
        b.setTitle("Go back", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.addTarget(self, action: #selector(toggletv(sender:)), for: .touchUpInside)
        //  b.isHidden = true
        b.alpha = 0
        b.backgroundColor = hex("#e74c3c")
        return b
    }()
    
    /*
    lazy var togglebtn: UIButton = {
        let b = UIButton()
        b.setTitle("Change races", for: [])
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        b.setTitleColor(hex("#000000"), for: [])
        b.addTarget(self, action: #selector(toggletv(sender:)), for: .touchUpInside)
        return b
    }()*/
    
    
    @objc func check(){
        let c = Connection()
        
        if c.isConnected() == false {
            addConnectionError()
            disview.isHidden = false
            dislabel.isHidden = false
            trybutton.isHidden = false
            print("YES")
        } else {
            disview.isHidden = true
            dislabel.isHidden = true
            trybutton.isHidden = true
        }
    }
    
    
    
    var results = [RO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        
        [background,  v, infol, lbl, lstack, /*savebtn*/ /*logoutb*/ sheetbtn, imgview, hidebtn, tableView, searchbar].forEach {view.addSubview($0)}
        addStack() // has to be below because of background
        constrainUI()
        
        searchbar.pin(a: .top, b: .center, ac: 70, bc: 0, w: view.frame.width - 20, h: 60, to: nil)
        
        hidebtn.pin(a: .top, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 50, to: nil)
        //tableView.stretchPin(top: 60, left: nil, right: nil, bottom: savebtn)
        //tableView.pin(a: .top, b: .left, ac: 60, bc: 0, w: view.frame.width, h: 50, to: nil)
        
        tableView.bottomPin(top: 100)
       
    
        [nickField].forEach {$0.autocorrectionType = .no}
        
        let tapa = UITapGestureRecognizer(target: self, action: #selector(self.changePhoto(_:)))
        tapa.cancelsTouchesInView = false
        // tor(ViewController.myviewTapped(_:)))
        imgview.addGestureRecognizer(tapa)
        imgview.isUserInteractionEnabled = true
        // enable user interaction ??????
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        fetchImage()
        // ref.child("Yes").setValue(["count":-1])
        // ref.child("No").setValue(["count":-1])
        
    }
    
    
    @objc func kbWillShow(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            print("Keyboards will show")
            
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (kbsize.height - 20)
                
                
            }
        }
    }
    
    
    @objc func kbWillHide(notification: Notification){
        if let kbsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("Keyboards will hide")
            
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += (kbsize.height - 20)
               // postView.scroll()
            }
        }
    }

    
    
    @objc func changePhoto(_ sender: UITapGestureRecognizer){
        print("TAPPPED")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func toggletv(sender: UIButton!){
        
        if tableView.alpha == 1 {
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 0// hide table view
                self.searchbar.alpha = 0
                self.hidebtn.alpha = 0 // show hider
                self.main.alpha = 1
                
                self.view.endEditing(true)
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1// hide table view
                self.searchbar.alpha = 1 // 0 ?????????????????????
                self.hidebtn.alpha = 1 // show hider
                self.main.alpha = 0
                
               /* for g in self.view!.gestureRecognizers! {
                    self.view.removeGestureRecognizer(g)
                }*/
            }
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let edited = info[.editedImage] as? UIImage {
            selected = edited
            
        } else if let data = info[.originalImage] as? UIImage {
            selected = data
            
        }
        
        print("SIZE: \(selected!.size)")
        // imgview.image = selected!
        imgview.image = selected
        
        dismiss(animated: true, completion: nil)
    }
    
    
    let main = UIStackView()
    func addStack(){
        
        
        
        let c = Checker()

        if c.isIpad() == true {
            
            [minSwim, secSwim, minRun, secRun, dot, dota].forEach {
                
                if $0 is Numeric{
                    let v = $0 as! Numeric
                    v.font = UIFont.boldSystemFont(ofSize: 32)
                    
                }
                
                if $0 is UILabel{
                    let v = $0 as! UILabel
                    v.font = UIFont.boldSystemFont(ofSize: 32)
                }
            }
            
            lbl.font = UIFont.systemFont(ofSize: 55, weight: UIFont.Weight.heavy)
            
            savebtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            
        }
        
        
        
        let st = UIStackView()
        st.distribution = .fillProportionally
        
        let tst = UIStackView()
        tst.distribution = .equalSpacing
        tst.addArrangedSubview(minSwim)
        tst.addArrangedSubview(dot)
        tst.addArrangedSubview(secSwim)
        
        st.addArrangedSubview(infoswim)
        st.addArrangedSubview(tst)
        
        
        let rt = UIStackView()
        // st.alignment = .fill
        rt.distribution = .fillProportionally
        rt.spacing = 0.5
        let trt = UIStackView()
        trt.distribution = .equalSpacing
        trt.addArrangedSubview(minRun)
        trt.addArrangedSubview(dota)
        trt.addArrangedSubview(secRun)
        
        rt.addArrangedSubview(inforun)
        rt.addArrangedSubview(trt)
        
        
        main.axis = .vertical
        main.distribution = .equalSpacing
        main.addArrangedSubview(nickField)
     //   main.addArrangedSubview(efield)
        main.addArrangedSubview(st)
        main.addArrangedSubview(rt)
        
     
        
        let s = UIStackView(arrangedSubviews: [infoexp, experiencefield])
        s.distribution = .fillEqually // ????
        
        var sp:CGFloat = 6.0
    
        if c.isIpad() || c.isBiggestIpad() {
            sp = 11.0
        }
        
        s.spacing = sp
        
        main.addArrangedSubview(s)
        main.addArrangedSubview(savebtn)
       
       
        
        view.addSubview(main)
        
        [nickField, experiencefield].forEach {
            $0.textAlignment = .center
        }
        
      //  main.pin(a: .top, b: .center, ac: 370, bc: 30, w: 210, h: 250, to: nil)

        
    }
    
    
    
    @objc func step(sender: UIStepper!){
        years = Int(stepper.value)
        print("Years \(years)")
        stepperLabel.text = String(years)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let device = UIDevice.modelName
        
        print("DEVICE is \(device)")
        
        UserDefaults.standard.set("edit", forKey: "leftat")
        
        check()
        
        /*
         let c = Connection()
         
         if c.isConnected() == false {
         addConnectionError()
         disview.isHidden = false
         dislabel.isHidden = false
         print("YES")
         } else {
         disview.isHidden = true
         dislabel.isHidden = true
         } */
        
        
        let r = [String]()
        let f = TextFetcher(edit: r)
        f.mefetcha(url: "http://swimrunny.co/database.txt") { (resa) in
            self.results.removeAll()
            
            for (i, _) in resa.enumerated(){
                let el = RO(value: resa[i], isSelected: false)
                self.results.append(el)
                
            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        
        
        
        let ref = Database.database().reference()
        let uid:String = (Auth.auth().currentUser?.uid)!
        ref.child("Users").observeSingleEvent(of: .value) { (snap) in
            for s in snap.children {
                let w = s as! DataSnapshot
                
                if w.key == uid {
                    let v = w.value as? NSDictionary
                   // let email = v?["email"] as? String ?? "not found"
                   // self.efield.text = email
                    
                    let nickname = v?["nickname"] as? String ?? "not found"
                    self.nickField.text = nickname
                    
                    let count = v?["count"] as? String ?? "not found"
                    self.experiencefield.text = count
                    
                    
                    let stime = v?["rtime"] as? String ?? "not found"
                    let rtime = v?["stime"] as? String ?? "not found"
                    //  print("RTIME \(rtime)  STIME \(stime)")
                    
                    let rpls = rtime.split(separator: ":")
                    let rmin = rpls[0]
                    let rsec = rpls[1]
                    
                    let spls = stime.split(separator: ":")
                    let smin = spls[0]
                    let ssec = spls[1]
                    
                    self.minRun.text = String(smin)
                   self.secRun.text = String(ssec)
                    
                   self.minSwim.text = String(rmin)
                   self.secSwim.text = String(rsec)
                    
                    let races = v?["race"] as? String ?? "not found"
                    let arr = races.split(separator: "-")
                    
                    // self.chosen.removeAll()
                    self.new.removeAll()
                    self.side.removeAll()
                    
                    for a in arr {
                        self.new.append(RO(value: String(a), isSelected: true)) //
                        self.side.append(RO(value: String(a), isSelected: true)) //
                    }
                    
                    self.tableView.reloadData()
                    
                    
                }
                
            }
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filtered.count
        }
        
        return results.count
    }
    
    var idx = -1
    var raceids = [String]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RNCell", for: indexPath)
        
        
        let row = indexPath.row
        
        var titles = [String]()
        new.map{titles.append($0.value)}
        
        
        let model = results[row]
        
      
    
        if (titles.contains(results[row].value)){
            model.isSelected = true
        }
        
        if model.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if model.value !=  "" { // ???????
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.text = "\(model.value)"
        }
        
        return cell
    }
    
    
    
    func showFoundAlert(){
        
        // if editingStyle == UITableViewCell.EditingStyle.delete {
        
        var titles = [String]()
        new.map {titles.append($0.value)}
        
        // let row = indexPath.row
        //   let loc = results[row]
        // let f = Finder(slocation: loc.value)
        
        
        let r = Alert()
        let remove = UIAlertAction(title: "I have found a partner", style: .default) { (action) in
            // f.removeMatched()
            
            // fetch prev. value of "Yes" and add one to it
            let getter = IncrGet(name: "Yes")
            getter.get(completion: { (val) in
                let r = val
                
                let q = r[0].value
                let w = Int(q)
                
                let inc = Increaser(name: "Yes")
                inc.add(val: w! + 1)
            })
            
            /*  self.results[row].isSelected = false
             
             if titles.contains("\(self.results[row].value)"){
             let id = titles.index(of: "\(self.results[row].value)" )
             self.new.remove(at: id!)
             }
             
             // tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
             
             var titles = [String]()
             self.new.map {titles.append($0.value)}
             let f = NewFinder(sarr: titles)
             f.saveCurrent()
             
             self.tableView.reloadData() */
        }
        
        
        
        
        let no = UIAlertAction(title: "Won't take part", style: .default) { (action) in
            
            // SAVE DATA
            
            // self.tableView.reloadData()
            
            // fetch prev. value of "No" and add one to it
            let getter = IncrGet(name: "No")
            getter.get(completion: { (val) in
                let r = val
                
                let q = r[0].value
                let w = Int(q)
                
                let inc = Increaser(name: "No")
                inc.add(val: w! + 1)
            })
            
            
        }
        
        
        
        r.show(on: self, title: "", messsage: "Have you found a partner ?", actions: [remove, no])
        // Have you found a partner ?
        
        // }
    }
    
    /*
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
     
     
     }
     
     */
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        
        var titles = [String]()
        new.map {titles.append($0.value)}
        
        if titles.contains(results[row].value){
            
            showFoundAlert()
            
            results[row].isSelected = !results[row].isSelected
            
            let id = titles.index(of: "\(results[row].value)")
            titles.remove(at: id!)
            new.remove(at: id!)
            tableView.reloadData()
            
        } else {
            results[row].isSelected = !results[row].isSelected
            
            titles.append(results[row].value)
            new.append(RO(value: results[row].value, isSelected: true)) // results[row].isSelected
            tableView.reloadData()
        }
        
    }
    
    
    
    @objc func sendMaila(sender: UIButton!){
        sendMail()
    }
    
    
    func sendMail(){
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["filipvabrousek1@gmail.com"])
            mail.setSubject("Suggestion/Issue")
            mail.setMessageBody("", isHTML: false)
            present(mail, animated: true)
        } else {
        /*    print("Sth went wrong")
           
            if let url = URL(string: "itunes.apple.com/gb/app/mail/id1108187098?mt=8") {
                UIApplication.shared.open(url, options: [:], completionHandler: { (ok) in
                   print("Everythin wen smoothly")
                })
            }*/
            
            let ac = Alert()
            let dismiss = UIAlertAction(title: "OK", style: .default)
            ac.show(on: self, title: "Contact us", messsage: "filipvabrousek1@gmail.com", actions: [dismiss])
            
            
            
            // URL(string: "itunes.apple.com/gb/app/mail/id1108187098?mt=8")!
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func update(sender: UIButton!){
        update() // Call on all update paths
    }
    
    func update(){
        let up = Updater(value: "Users") // UPDATE FILTER HERE
        let stime = "\(minSwim.text!):\(secSwim.text!)" // ADD THE SECONDS !!!
        let rtime = "\(minRun.text!):\(secRun.text!)"
        
        let nickname = nickField.text!
        let experience = experiencefield.text!
        
        var titles = [String]()
        new.map {titles.append("\($0.value)-")} // change to ForEach
        
        
        
        
        let swimcheck = checkTime(time: stime, type: "swim")
        let runcheck = checkTime(time: rtime, type: "run")
        
        
        
        if stime.count != 5 || rtime.count != 5 || nickname.count == 0 || experiencefield.text?.count == 0 || swimcheck == false || runcheck == false {
            
            if stime.count != 5 || swimcheck == false {
                let a = Alert()
                let dis = UIAlertAction(title: "Okay", style: .default) { (action) in
                }
                
                a.show(on: self, title: "Wrong format", messsage: "Swimming time was not in corect format.", actions: [dis])
            }
            
            if rtime.count != 5 || runcheck == false {
                let a = Alert()
                let dis = UIAlertAction(title: "Okay", style: .default) { (action) in
                }
                
                a.show(on: self, title: "Wrong format", messsage: "Running time was not in corect format.", actions: [dis])
            }
            
            
            if nickname.count == 0 {
                let a = Alert()
                let dis = UIAlertAction(title: "Okay", style: .default) { (action) in
                }
                
                a.show(on: self, title: "Wrong format", messsage: "Nickname can't be empty.", actions: [dis])
            }
            
            if experiencefield.text?.count == 0 {
                let a = Alert()
                let dis = UIAlertAction(title: "Okay", style: .default) { (action) in
                }
                
                a.show(on: self, title: "Wrong format", messsage: "Experience can't be empty.", actions: [dis])
            }
            
            
           
            
            
            
            
        } else {
            up.update(nickname: nickField.text!, stime: stime, rtime: rtime,  new: titles, filter: [String](), count: experiencefield.text!, selected: self.selected)
            let dis = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            
            let a = Alert()
            a.show(on: self, title: "Done.", messsage: "Data updated successfully", actions: [dis])
        }
        
      
    }
    
    
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func logout(sender: UIButton!){
        let del = Eraser(ename: "Users") // remove user from core data
        del.erase()
        
        UserDefaults.standard.set("YES", forKey: "isout")
        let lc = LogController()
        present(lc, animated: true, completion: nil)
    }
}



extension EditController{
    func fetchImage(){
        let uid:String = (Auth.auth().currentUser?.uid)! // ???
        let ref = Database.database().reference()
        ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snap) in
            
            let s = snap
            
            let v = s.value as? NSDictionary
            
            let url = v?["url"] as? String ?? "x"
            
            
            if url.count > 3 && url != "not found" {
                let storage = Storage.storage().reference(forURL: url)
                storage.getData(maxSize: 1 * 2048 * 2048, completion: { (data, err) in // do not exceed maximum file size
                    
                    if err != nil {
                        let ac = Alert()
                        let dis = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in })
                        
                        ac.show(on: self, title: "Error when fetching image", messsage: "\(err?.localizedDescription)", actions: [dis])
                    }
                    
                    if data != nil {
                        let image = UIImage(data: data!)
                        print("IMAGE DIMENSIONS \(image!.size)")
                        self.imgview.image = image
                    }
                })
            } else {
                let image = UIImage(named: "ocean.jpg")
                self.imgview.image = image
            }
        }
        
        
    }
}



extension EditController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filtered = results.filter {
               // print("VAL \($0.value)")
                $0.value.contains(searchbar.text!)
            }
            
            tableView.reloadData()
        }
    }
}



extension EditController {
    func ctime(rmin: String, rsec: String, smin: String, ssec: String) -> Bool {
        var allow = true
        
        
        if (rmin.count != 2 || rsec.count != 2 || smin.count != 2 || ssec.count != 2){
            allow = false
        } else {
            if Int(rsec)! <= 59 {
                
            } else {
                allow = false
            }
            
            
            
            if Int(rmin)! >= 28 && Int(rmin)! <= 99{
                
            } else {
                allow = false
            }
            
            
            if Int(smin)! >= 10 && Int(smin)! <= 59 {
                
            } else {
                allow = false
            }
        }
        
        
        
        print("all \(allow)")
        return allow
    }
}






//
//  PrivacyController.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 05/01/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit

class PrivacyController: UIViewController {
    
    lazy var navBar: UINavigationBar = {
        let n = UINavigationBar()
        n.makeTransparent()
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(self.back(sender:)))
        // let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(toShare))
        
        
        doneItem.tintColor = .black
        [doneItem].forEach {
            $0.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
                ], for: [])
        }
        
        
        
        navItem.leftBarButtonItem = doneItem
        
        n.setItems([navItem], animated: false)
        return n
    }()
    
    
   let ww = UIWebView()
    
    
    @objc func back(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
        
        [navBar, ww].forEach {view.addSubview($0)}
          navBar.pin(a: .top, b: .center, ac: 40, bc: 0, w: view.frame.width - 4, h: 60, to: nil)
        
        
        ww.bottomPin(top: 80)
        
        let req = URLRequest(url: URL(string: "http://swimrunny.co/privacy.html")!)
        ww.loadRequest(req)
        
    }
    
 
    
    
}



//
//  DiconnectedVC.swift
//  Swimrunny
//
//  Created by Filip Vabroušek on 31/10/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit


class Diconnectejd: UIViewController {
  
    var titlea: UILabel = {
    var l = UILabel()
    l.font = UIFont.boldSystemFont(ofSize: 30)
    l.text = "No connection"
    l.textAlignment = .center
    l.textColor = .white
    return l
    }()
    
    var lbl: UILabel = {
        var l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.text = "Connect to the internet and try again"
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = hex("#3498db")
        [titlea, lbl].forEach {view.addSubview($0)}
        titlea.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width, h: 40, to: nil)
        lbl.pin(a: .top, b: .center, ac: 140, bc: 0, w: view.frame.width, h: 40, to: nil)
    }
    
    
}





