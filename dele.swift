//
//  ViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 13.01.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import CoreData
import CoreMotion
import CoreBluetooth


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, UIGestureRecognizerDelegate, Reset, LOC, CadD {
    
    // start 18.5
   

    // BOOLEANS
    var isRunning = false

    // INSTANCES
    var ref = PlayerController()
    let PM = CMPedometer()
    var LM = LMO()
    var shot: UIImage? = nil
    var bmanager: CBCentralManager!
    var PR: CBPeripheral?
    
    // TIMERS
    var timer: Timer?
    var baterryTimer: Timer?
    var sectionTimer: Timer?
    var backupTimer = Timer()
    var AL = CLLocation(latitude: 0, longitude: 0)
    
    // SCALARS (Numbers)
    var sec = 0
    var paceSec = 1.0
    var minutes = 0
    var secDuration = 0.0
    var travelled = 0.0
    var adding = 0 // SPLIT scalars begin, info about how many km will be added
    var temp = 0.0
    var limit = 1.0
    var sectionsec = 0
    var sectiondist = 0.0
    var steps = 0
    var travelledsection = 0.0
    var fetchedd = 0.0
    
    
    // SCALARS (Strings)
    var distanceString = ""
    var fillinloc = "" // changed in functions
    var fillinweather = "" // changed in functions
    var sectionstr = ""
    
    
    // ARRAYS
    var latPoints = [Double]() // not used yet, to create polyline
    var lonPoints = [Double]()
    var latMarkers = [Double]()
    var lonMarkers = [Double]()
    var locs: [CLLocation] = []
    var secs = [Int]()
    var cadences = [Int]()
    var peripherlas = [CBPeripheral]()
    var pernames = [String]()
    var bldevs = [String]() // Bluetooth devices
    var chartcad = [Double]()
    var chartmin = [Int]()
    var hrarr = [Int]()
    
    
    
    // ELEMENTS
    let titlel = Flabel(text: "Runny", font: UIFont.boldSystemFont(ofSize: 24), color: .black, align: .center)
    
    lazy var mainTitles = MainTitles()
    lazy var main = MainStack()

    let distSubline = Flabel(text: "Distance", font: .boldSystemFont(ofSize: 14), color: .gray, align: .center)
  
    lazy var bluetoothView = BluetoothTable(delegate: self, identifier: "BLCell", hide: true)!
    lazy var ppicker = Pickerba(action: #selector(self.shot(sender:)), vc: self)!
    lazy var showbl = ShowbBLA(action: #selector(self.pair(sender:)), vc: self)!
    lazy var startMain = SectionB(action: #selector(self.startSection(sender:)), vc: self)!
    lazy var startBtn = StartButton(selector: #selector(self.start(sender:)), vc: self)
    lazy var songsBtn = SongButton(selector: #selector(self.switcho(sender:)), vc: self)
    
    var BLBack: UIView = {
        let b = UIView()
        b.backgroundColor = .white
        b.isHidden = true
        return b
    }()
    
    
    
    var bllabel: UILabel = {
        let l = Flabel(text: "Accessories", font: .systemFont(ofSize: 34, weight: UIFont.Weight.heavy), color: .black, align: .left)
        l.isHidden = true
        return l
    }()
    
    
    @objc func shot(sender: UIButton!){
        let p = IP()
        p.showPicker(on: self)
        UserDefaults.standard.set(true, forKey: "blockreset")
    }

    @objc func incrsection(){
        sectionsec.inc() // += 1
    }
    
    lazy var map: MKMapView = {
        let m = Map(del: self, compass: true)
        return m // cannot simplify
    }()

   // lazy var segments = Seg(items: ["Map", "Music"], vc: self, selector: #selector(self.switchSegment(_:)))
   // lazy var segments = Seg(items: ["Map", "Music"], vc: self, selector: #selector(self.switchSegment(_:)))
    
    lazy var segments: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["Map", "Music"])
        seg.tintColor = .black
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(self.switchSegment(_:)), for: .valueChanged)
        
        let attrs:[NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
        seg.setTitleTextAttributes(attrs, for: [])
        return seg
        
    
    }()
    
    @objc func switchSegment(_ sender: UISegmentedControl!){
        switch sender.selectedSegmentIndex {
        case 0:
            [map, startBtn, songsBtn].forEach {$0.isHidden.toggle()}
            ref.view.isHidden = true
            break
        case 1:
            [map, startBtn, songsBtn].forEach {$0.isHidden.toggle()}
            ref.view.isHidden = false
            break
        default:
            break
        }
    }
    
    
    
   
    
    
    func setupVC(){
        view.backgroundColor = .white
        tabBarController?.tabBar.tintColor = .black
    }
    
    func setupBluetooth(){
        bmanager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey : true])
    }
    
    func setupBaterry(){
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    
    func setLM() {
        let e = LMO.shared
        e.delegate = self
    }
    
    
    func setupChild(){ // set-up Player Controller as cild
        let an = ref
        ref.view.isHidden = true
        addChild(an)
        view.addSubview(an.view)
        
        let dev = UIDevice()
        if dev.is47 {
            an.view.pin(a: .bottom, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 347, to: nil)
        } else {
            an.view.pin(a: .bottom, b: .left, ac: 0, bc: 0, w: view.frame.width, h: 422, to: nil)
        }
        
        an.didMove(toParent: self)
    }
    
    // 5DD85I5LHB
    /*-------1------------------------------------------------- LIFECYCLE ------------------------------------------------------*/
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupBaterry()
        setupBluetooth()
        setupChild()
        setupUI()
        setLM()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAppear()
        handleUIReset()
        handleUnfinished()
        bmanager.scanHR()
        fixRotation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavBar()
        checkLocation()
    }
    
    
    func fixRotation(){
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
    func hideNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func handleAppear(){
        let a = AppearHandler(isRunning: isRunning)
        a.handleMap(map: &map, LM: &LM.lm)
    }
    
    lazy var m: Reseter = {
        let r = Reseter()
        r.delegate = self
        return r
    }()
    
    @objc func checkLevel(){
        m.saveIfLowBattery()
    }
    
    @objc func increaseTimer(){
        m.setTTLabels(isRunning: true)
    }
    
    
    func setTLabels() {
        paceSec.inc()
        secDuration.inc()
        
        let k = travelled.tokm()
        let p = PaceFormatter(sec: Int(secDuration), dist: k)
        
        let sta = main.arrangedSubviews[1] as! UIStackView
        
        let timer = sta.arrangedSubviews[0] as! UILabel
        timer.text = p.getTime()
        
        let pace = sta.arrangedSubviews[2] as! UILabel
        pace.text = p.getPace()
    }
    
    
    
    @objc func pair(sender: UIButton!) {
        m.allPair(state: bmanager.state, btn: sender)
    }
    
    
    func setPoweredOn(sender: UIButton){
        var e = sender
        
        bluetoothView.changeBtnTitle(btn: &e)
        bluetoothView.isHidden.toggle()
        BLBack.isHidden.toggle()
        bllabel.isHidden.toggle()
    }
    
    
    func notPowered(){
        m.handleNotPowered(hidden: bluetoothView.isHidden)
    }
    
    
    func BLShow(){
        bluetoothView.isHidden.toggle()
        BLBack.isHidden.toggle()
        bllabel.isHidden.toggle()
        showbl.behaveBLSHOW()
    }
    
    func BLHidden(){
        let ac = UIAlertController.BLAlert()
        present(ac, animated: true, completion: nil)
    }
    
    
    func handleHideRecovery(){
        
        self.tabBarController?.tabBar.isHidden = true
        let sfin = UserDefaults.standard.bool(forKey: "sfin")
        let ins = UserDefaults.standard.bool(forKey: "insection")
        
        startMain.behave(fin: sfin) // TRUE -> HIDE
        startMain.behaveAppeareance(fin: ins)
        m.startSectionT() // set section timer, YF sfin is false
    }
    
    
    func setSectionTimer(){ // set section timer, YF sfin is false
        sectionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.incrsection), userInfo: nil, repeats: true)
    }
    
    
    
    
    /* INSECTION deciding between issFalse and issTrue   "m.hndSection()"     */
    @objc func startSection(sender: UIButton!){
        m.hndSection() // issFalse() OR issTrue()
    }
    
    func issFalse(){ // insection is false
        sectionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.incrsection), userInfo: nil, repeats: true)
        UserDefaults.standard.set(true, forKey: "insection")
        self.cadence()
        startMain.setTitle("Start cooldown", for: [])
        startMain.backgroundColor = hex("#e74c3c")
    }
    
    func issTrue(){ // insection is true
        UserDefaults.standard.set(true, forKey: "sfin")
        startMain.isHidden = true
        sectionTimer?.invalidate()
    }
    
    
    func cadence(){
        if CMPedometer.isCadenceAvailable(){
            
            PM.startUpdates(from: Date()) { (data, err) in
                
                 let cd = data?.getCAD()
                 if cd != nil && cd != 0 {
                 self.fillCads(cadence: cd!)
                 }
                
                /*let cd = CadWorker(data: data)
                 cd.callFillCads()*/
            }
            
        } else {
            print("Cadence not available")
        }
    }
    
    
    func fillCads(cadence: Double){
        var cd = cadence
        let res = cd.toCad()
        self.cadences.append(Int(res))
        self.chartcad.append(Double(res))
        let e = self.secDuration.cadMin()
        self.chartmin.append(Int(e))
    }
    
    
    /*handleunfinihed */
    fileprivate func handleUnfinished(){
        m.showUnfinishedAlert(isRunning: isRunning)
    }
    
    
    func showUnf(){
        let a = Alert()
        let rec = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.initUI()
            self.recover() // recover to latest data
            self.isRunning = true
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            let e = Eraser(ename: "Backups")
            e.erase()
            UserDefaults.standard.set(true, forKey: "finished") // not to popup again
        }
        
        a.show(on: self, title: "It seems you have unfinished run", messsage: "Do you wish to recover ?", actions: [rec, cancel])
    }
    
    
    
    
    
    func initUI(){
        isRunning = true
        LM.lm.startUpdatingLocation()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        baterryTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.checkLevel), userInfo: nil, repeats: true)
        backupTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.tempSave), userInfo: nil, repeats: true)
        
        startBtn.backgroundColor = hex("#e74c3c")
        startBtn.setTitle("Stop", for: [])
    }
    
    
    /*---------------2--------------------------------------------START---------------------------------------------------------*/
    
    @objc func start(sender: UIButton!){
        
        // only YF we have give the accesss
        let status = CLLocationManager.authorizationStatus()
        
        var allow = false
        
        switch status {
        case .notDetermined:
            print("Denied")
            
        case .denied, .restricted:
            print("DENIED")
            
        case .authorizedWhenInUse:
            allow = true
            
        case .authorizedAlways:
            allow = true
            print("ALWAYS")
        //
        @unknown default:
            allow = true // maybe bug
        }
        
        
        
        if allow == false {
            let a = Alert()
            let rec = UIAlertAction(title: "Enable", style: .default) { (action) in
                self.openSettings()
            }
            
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            }
            
            a.show(on: self, title: "Location services are diabled.", messsage: "You have to enable 'Always' option in Location Usage to start a run.", actions: [rec, cancel])
        } else {
            startrun()
        }
    }
    
    
    func openSettings(){
        let bid = Bundle.main.bundleIdentifier
        let s = SettingsOpener(bid: bid)
        s.open()
    }
    
    
    
    
    func setForRun(){
        isRunning = true
        
        UserDefaults.standard.set(false, forKey: "insection")
        UserDefaults.standard.set(false, forKey: "sfin")
        UserDefaults.standard.set(false, forKey: "finished")
        
        startMain.setTitle("Effective pace", for: [])
        startMain.backgroundColor = UIColor.black
        startMain.isHidden = false
        
        self.resetUI()
        startTimers()
        
        startBtn.backgroundColor = hex("#e74c3c")
        startBtn.setTitle("Stop", for: [])
        
        LM.lm.startUpdatingLocation()
    }
    
    
    func startrun(){
        m.handleStart(isRunning: isRunning)
        self.tabBarController?.tabBar.isHidden = true
        let cm = CMPedometer()
        cm.startEventUpdates { (event, err) in
        }
    }
    
    
    
    func startTimers(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        baterryTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.checkLevel), userInfo: nil, repeats: true)
        backupTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.tempSave), userInfo: nil, repeats: true)
    }
    
    
    func fillVariables(run: Run){
        latPoints = run.latPoints
        lonPoints = run.lonPoints
        latMarkers = run.latMarkers
        lonMarkers = run.lonMarkers
        secDuration = Double(run.duration)
        travelled = run.distance.toMeters()
        sectionsec = run.sectionSecs
        chartcad = run.cadarr
        chartmin = run.minarr
        hrarr = run.hrarr
        sectiondist = Double(run.sectionDist) ?? 0.0
    }
    
    
    
    func setSplits(run: Run){
        let sp = getLastSplit()
        let ret = SplitFiller(sp: sp, cura: adding, curs: secs, pacesec: paceSec, curLimit: limit)
        let res = ret.getData()
        
        adding = res.0
        secs = res.1
        paceSec = res.2
        limit = res.3
        
        cadences.append(run.cadence) // append just last value to cadences - What can you do ? :)
    }
    
    
    
    func recover(){
        let last = getLastRun()
        m.try2callRecovero(last: last) // yf run != nil
    }
    
    
    func recovero(run: Run){
        let rec = run
        fillVariables(run: rec)
        setSplits(run: rec)
        handleHideRecovery()
        
        let f = LocFiller(run: rec)
        locs = f.fill()
    }
    
    
    fileprivate func handleUIReset() {
        m.try2CallReset() // call resetUI yf blockReset = FALSE
    }
    
    
    func resetUI(){ // reset UI labels, set variables to 0 and clear all arrays
        LM.lm.stopUpdatingLocation()
        
        let top =  main.arrangedSubviews[0] as! UILabel
        top.text = "0.0"
        
        let sta = main.arrangedSubviews[1] as! UIStackView
        
        let timer = sta.arrangedSubviews[0] as! UILabel
        timer.text = "00:00" //p.getTime()
        
        let heart = sta.arrangedSubviews[1] as! UILabel
        heart.text = "--"
        
        let pace = sta.arrangedSubviews[2] as! UILabel
        pace.text = "00:00"
        
        
        paceSec = 0
        travelled = 0.0
        secDuration = 0
        temp = 0.0
        
        latPoints.removeAll()
        lonPoints.removeAll()
        locs.removeAll()
        secs.removeAll()
        
        map.removeOverlays(map.overlays)
        
        let lt = LM.lm.location?.coordinate.latitude
        let lo = LM.lm.location?.coordinate.longitude
        
        
        /*
         yf lt != nil { // set AL to current location to start counting distance from 0
         let nl = CLLocation(latitude: lt!, longitude: lo!)
         AL = nl
         }
         */
        
        AL = lt.setLat(currAL: AL, lo: lo)
        
        self.timer?.invalidate()
        self.baterryTimer?.invalidate()
        
        self.cadences.removeAll()
    }
    
    
    func save(){
        let distkm = travelled.tokm()
        let k = distkm.frounded(to: 2)
        let dist = String(k)
        let dur =  Int(secDuration)
        let coord = getCoord()
        let day = getDate()
        let dater = Dater()
        let week = dater.getWeek()
        let month = dater.getMonth()
        let year = dater.getYear()
        let id = Int.random(in: 1000000..<9999999)
        let avg = getCad()
        
        sectionstr = "\(sectiondist)"
        
        let run = Run(date: day, year: year, month: month, week: week, distance: dist, location: fillinloc, weather: fillinweather, lat: coord.0, lon: coord.1, duration: dur, sectionSecs: sectionsec, sectionDist: sectionstr, laps: secs, latPoints: latPoints, lonPoints: lonPoints, latMarkers: latMarkers, lonMarkers: lonMarkers, cadence: steps, id: "\(id)", realcad: avg, cadarr: chartcad, minarr: chartmin, hrarr:hrarr)
        
        let a = ActivitySaver()
        a.save(run: run, distkm: distkm, dur: dur)
    }
    
    
    
    func getCoord() -> (CLLocationDegrees, CLLocationDegrees) {
        let llat = AL.coordinate.latitude
        let llon = AL.coordinate.longitude
        return (llat, llon)
    }
    
    func getDate() -> String {
        let d = Dater()
        let res = d.getDate()
        return res
    }
    
    func getLastRun() -> Run? {
        let f = LastFetcher()
        return f.last()
    }
    
    func getLastSplit() -> Splitso? {
        let f = LastFetcher()
        return f.lastSplit()
    }
    
    
    func bck(){
        
        let distkm = travelled.tokm()
        let k = distkm.frounded(to: 2)
        let dist = String(k)
        let dur =  Int(secDuration)
        let coord = getCoord()
        let day = getDate()
        let dater = Dater()
        let week = dater.getWeek()
        let month = dater.getMonth()
        let year = dater.getYear()
        
        let id = Int.random(in: 1000000..<9999999)
        let avg = getRealCad()
        sectionstr = "\(sectiondist)"
        
        
        let run = Run(date: day, year: year, month: month, week: week, distance: dist, location: fillinloc, weather: fillinweather, lat: coord.0, lon: coord.1, duration: dur, sectionSecs: sectionsec, sectionDist: sectionstr, laps: secs, latPoints: latPoints, lonPoints: lonPoints, latMarkers: latMarkers, lonMarkers:lonMarkers, cadence: steps, id: "\(id)", realcad: avg, cadarr: chartcad, minarr: chartmin, hrarr:hrarr)
        
        
        let r = ActivitySaver()
        r.backup(run: run, distkm: distkm, dur: dur, adding: adding, limit: limit, paceSec: paceSec, secs: secs)
    }
    
    
    
    @objc func tempSave(){
        bck()
    }
    
    
    func updateLoca(location: CLLocation?) {
        m.try2callUpdateLoc(isRunning: isRunning, loc: location!)
        AL = location!
    }
    
    func updateLoc(curr: CLLocation){
       // locations.append(curr)
        fillArrays(loc: curr)
        drawPolyline(locs: locs, on: map)
        map.update()
        updateLabels(travelled: travelled)
        handleUpdate(curr)
        getGeodata(location: curr, supported: ["Cupertino", "Sunville", "Los Altos", "Los Altos Hills", "Redwood city", "Portola Valley"])
    }
    
    
    
    fileprivate func handleUpdate(_ location: CLLocation) {
        travelled += round(location.distance(from: AL))
        temp = temp.formatTemp(travelled: travelled)
        
        let r = SectionHandler(dist: location.distance(from: AL))
        let d = r.getSectionDist()
        sectiondist += d.0
        sectionstr += d.1
        
        
        if (temp > limit){
            adding = adding + 1000
            secs.append(Int(paceSec))
            
            let coord = getCoord()
            latMarkers.append(Double(coord.0))
            lonMarkers.append(Double(coord.1))
            limit = limit + 1
        }
    }
}







/*-------------------5----------------------------------------DRAW POLYLINE--------------------------------------------------------*/
extension ViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = hex("#1abc9c")
        renderer.lineWidth = 4
        return renderer
    }
}




extension ViewController {
    
    func drawPolyline(locs: [CLLocation], on: MKMapView){
        let p = PolylinePoints(locs: locs)
        let a = p.getLocs()
        
        let polyline = MKPolyline(coordinates: a, count: a.count)
        on.addOverlay(polyline)
    }
}



/*----------------------6----------------------------------- GET CITY NAME AND WEATHER -------------------------------------------------------*/
extension ViewController{
    
    fileprivate func getGeodata(location: CLLocation, supported: [String]) {
        let f = GeoFetcher(location: location, supported: supported)
        f.geodata { (res) in
            self.fillinloc = res
        }
    }
    
    
    @objc func switcho(sender: UIButton!){
        let ac = Sheet()
        
        let standard = UIAlertAction(title: "Normal", style: .default) { (action) in
            self.map.mapType = .standard
        }
        
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { (action) in
            self.map.mapType = .hybrid
        }
        
        let flyover = UIAlertAction(title: "FlyOver", style: .default) { (action) in
            self.map.mapType = .hybridFlyover
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        ac.show(on: self, title: "Map type", messsage: "", actions: [standard, hybrid, flyover, cancel])
    }
}



extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherlas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BLCell") as! BLCell
        cell.updateUI(name: peripherlas[indexPath.row].name ?? "Unknown")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let row = indexPath.row
        
        if bmanager.state == .poweredOn {
            
            PR = peripherlas[row]
            PR?.delegate = self
            bmanager.stopScan()
            bmanager.connect(PR!)
            UserDefaults.standard.set(PR!.name, forKey: "myhr")
            
        } else {
            let a = UIAlertController.BLAlert()
            present(a, animated: true, completion: nil)
        }
    }
}







/*-------------------------------------------BLUETOOTH----------------------------------------------------------
 bmanager.scanHR()
 m.connectKnowP - yf device name stored unter "myHR" exists
 // https://www.kevinhoyt.com/2016/05/20/the-12-steps-of-bluetooth-swift/
 */

extension ViewController {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bmanager.scanHR()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        bmanager.connect(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheral.delegate = self
        
        if peripheral.name != nil {
            m.try2callAppo(name: peripheral.name, peripheral: peripheral, pernames: pernames)
            m.callConnectKnown(pernames: pernames, peripherlas: peripherlas, pername: peripheral.name)
        }
    }
    
    
    func appo(name: String?, peripheral: CBPeripheral){
        pernames.append(name ?? "x")
        peripherlas.append(peripheral)
        bluetoothView.reloadData()
    }
    
    
    func connectKnown(per: inout CBPeripheral){
        PR = per // peripherlas[i]
        PR?.delegate = self
        bmanager.stopScan()
        bmanager.connect(PR!)
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let cb = CBUUID(string: "0x180D")
        PR?.discoverServices([cb])
    }
    
    // https://stackoverflow.com/questions/16212762/ble-characteristic-is-nil-when-the-service-is-not-nil-running-in-iphone
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        peripheral.delegate = self
        m.discoverService(sers: peripheral.services, pr: peripheral) // CALL discover(.. BELOW)
        setUIAfter() // hides he view
    }
    
    func discover(service: CBService, pr: CBPeripheral){
        pr.discoverCharacteristics(nil, for: service)
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        peripheral.delegate = self
        m.discoverChars(service: service, per: peripheral) // CALLS read and write below
    }
    
    // called by M.discoverChars
    func read(char: CBCharacteristic, per: CBPeripheral){
        per.delegate = self
        per.readValue(for: char)
    }
    
    func write(char: CBCharacteristic, per: CBPeripheral){
        per.delegate = self
        per.setNotifyValue(true, for: char)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        readChar(char: characteristic)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error.err) // OPTIONAL EXTENSION
    }
    

    func setUIAfter(){
        [bluetoothView, bllabel, BLBack].forEach {$0.isHidden = true}
        showbl.setTitle("♥", for: [])
        showbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }
}




/*-------------------------------------------CALLED IN DIDUPDATELOCATIONS----------------------------------------------------------*/
extension ViewController {
    
    func fillArrays(loc: CLLocation){
        latPoints.append(Double(loc.coordinate.latitude))
        lonPoints.append(Double(loc.coordinate.longitude))
        locs.append(loc) // append current location to locations array and show user pinition on the map
    }
    
    func updateLabels(travelled: Double){
        let inv = travelled.tokm()
        let value = inv.frounded(to: 2)
        distanceString = String(value)
        
        let d = main.arrangedSubviews[0] as! UILabel
        d.text = distanceString
    }
}


/*
 This extension Controls cadence and HR
 ----- BIG ENOUGH, NOTBIGENOUGH -----
 ---- m.getRate() ---
 */
extension ViewController {
    func getRealCad() -> Int {
        return cadences.avg
    }
    
    func readChar(char: CBCharacteristic){
        m.try2CallWriteHR(char: char)
    }
    
    func writeHR(char: CBCharacteristic){
        let hro = getRate(ch: char)
        let l = main.arrangedSubviews[1] as! UIStackView
        let r = l.arrangedSubviews[1] as! UILabel
        r.text = "\(hro)"
    }
    
    func getRate(ch: CBCharacteristic) -> Int {
        let c = ch.getRate()
        hrarr.append(c)
        return c
    }
}



extension ViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let s = info[.originalImage] as? UIImage
        print("SIZE \(String(describing: s?.size))")
        
        UIImageWriteToSavedPhotosAlbum(s!, nil, nil, nil)
        self.shot = s!
    }
}



/*
 This extension shows alert, when authorization status is not set to "Always"
 ----- BIG ENOUGH, NOTBIGENOUGH -----
 ---- self.m.handleFinish(travelled: self.travelled) ---
 */

extension ViewController {
    func checkLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        var allow = false
        
        switch status {
        case .notDetermined:
            print("Denied")
            
        case .denied, .restricted:
            print("DENIED")
            
        case .authorizedWhenInUse:
            allow = true
            
        case .authorizedAlways:
            allow = true
        @unknown default:
            allow = true // possible bug cause
        }
        
        m.showAlert(show: allow)
    }
    
    
    
    func showAlert(){
        let a = Alert()
        let rec = UIAlertAction(title: "Enable", style: .default) { (action) in
            self.openSettings()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        a.show(on: self, title: "We cannot track your run in the background.", messsage: "You have to enable 'Always' option in Location Usage to start run", actions: [rec, cancel])
    }
}

/*
 This extension Handles the stop of activity through
 ----- BIG ENOUGH, NOTBIGENOUGH -----
 ---- self.m.handleFinish(travelled: self.travelled) ---
 */

extension ViewController {
    func bigEnough(){ // dist > 0.02
        let c = UDHandler()
        self.LM.lm.stopUpdatingLocation()
        self.timer?.invalidate()
        self.save()
        c.setTravelled()
        self.startMain.isHidden = true
        self.tabBarController?.selectedIndex = 1
    }
    
    func notBigEnough(){ // dist < 0.02
        let c = UDHandler()
        let s = Speech()
        s.say(text: "Your activity was too short")
        self.tabBarController?.tabBar.isHidden = false
        self.resetUI()
        self.startMain.isHidden = true
        self.startMain.setTitle("Effective pace", for: [])
        self.startMain.backgroundColor = .black
        c.setSmall()
    }
    
    
    func createAlert(){
        
        let ac = Alert()
        self.LM.lm.stopUpdatingLocation()
        
        timer?.invalidate() // CHECK NOT NIL ??
        
        let w = travelled.desc()
        
        let finish = UIAlertAction(title: "OK", style: .default) { (action) in
            
            // call bigEnough OR notBigEnough above
            self.m.handleFinish(travelled: self.travelled)
            self.isRunning = false
            self.backupTimer.invalidate()
            self.startBtn.backgroundColor = hex("#000000")
            self.startBtn.setTitle("Start", for: [])
        }
        
        
        let carryon = UIAlertAction(title: "Not yet", style: .default) { (action) in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
            self.LM.lm.startUpdatingLocation()
            
            /*  YF self.LM.location != nil {
             self.AL = self.LM.location! // magic happens here
             } */
            
            self.AL = self.LM.lm.location!
        }
        
        ac.show(on: self, title: "Finish ?", messsage: "\(w)", actions: [finish, carryon])
    }
}


extension ViewController {
    func setupUI(){
        [titlel, main, map, mainTitles, distSubline, startBtn, songsBtn, segments, startMain, ppicker, BLBack, bllabel, bluetoothView, showbl].forEach {view.addSubview($0)}
        
        distSubline.pin(a: .top, b: .center, ac: 120, bc: 0, w: 200, h: 30, to: nil)
        bluetoothView.bottomPin(top: 140, safe: true)
        BLBack.bottomPin(top: 0, safe: false)
        bllabel.pin(a: .top, b: .left, ac: 70, bc: 20, w: view.frame.width, h: 60, to: nil)
        showbl.pin(a: .top, b: .left, ac: 25, bc: 10, w: 80, h: 30, to: nil)
        main.pin(a: .top, b: .center, ac: 100, bc: 0, w: view.frame.width - 70, h: 170, to: nil)
        mainTitles.pin(a: .top, b: .center, ac: 190, bc: 0, w: view.frame.width - 50, h: 190, to: nil)
        constrainUI()
    }
}


// https://stackoverflow.com/questions/35026093/peripheral-not-connecting-swift
// https://www.kevinhoyt.com/2016/05/20/the-12-steps-of-bluetooth-swift/
// https://stackoverflow.com/questions/26878173/ios-how-to-reconnect-to-ble-device-in-background
