//
//  ViewController.swift
//  APPTest2

//  Goal page View Controller.

//  Created by Tengzhe Li on 4/22/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import Charts  // A third party library for charts generation.



class ViewController: UIViewController {

    var WeekGoal:Double = 0.0
    var WeekBudget:Double = 0.0
    var MonthGoal: Double = 0.0
    var MonthBudget: Double = 0.0
    var Goal: Double = 0.0
    
    @IBOutlet weak var barChartView: BarChartView!
    

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var RandomNum1: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    @IBOutlet weak var MoneyYouHold: UITextField!
    @IBOutlet weak var BudgetGoal: UITextField!
    @IBOutlet weak var BudgetMonthly: UITextField!
    @IBOutlet weak var GoalMonthly: UITextField!
    @IBOutlet weak var FinalGoal: UITextField!
    
    
    
    @IBAction func CheckDouble(_ sender: Any) {
        
        let checkGoal = Double(BudgetGoal.text!)
        let checkhold = Double(MoneyYouHold.text!)
        let checkMonthGoal = Double(GoalMonthly.text!)
        let checkMonthBudget = Double(BudgetMonthly.text!)
        let checkFinalGoal = Double(FinalGoal.text!)
        
        
        if(checkGoal != nil  && checkhold != nil && checkMonthGoal != nil && checkMonthBudget != nil && checkFinalGoal != nil){
            print("good Goal")
            saveButton.isUserInteractionEnabled = true
               saveButton.backgroundColor = UIColor.blue
        }else{
            saveButton.isUserInteractionEnabled = false
            saveButton.backgroundColor = UIColor.gray
                print("bad Goal")
        }
    
    
    
    }
    
   
    
    
    
    func weeklyUpdate(){
        
    }
    
     // reset all
    @IBAction func resitGoal(_ sender: Any) {
        WeekGoal = 0.0
        WeekBudget = 0.0
        MonthBudget = 0.0
        MonthGoal = 0.0
        Goal = 0.0
        BudgetGoal.text = String(WeekGoal)
        MoneyYouHold.text = String(WeekBudget)
        BudgetMonthly.text = String(MonthBudget)
        GoalMonthly.text = String(MonthGoal)
        FinalGoal.text = String(Goal)

    }
    // manage local storage.
    @IBAction func saveGoal(_ sender: Any) {
        //Key and persistent data
        _ = UserDefaults.standard.object(forKey: "Goal")
        var goal:Double
        goal = Double(BudgetGoal.text!)!
        print("Goal\(goal)")
     UserDefaults.standard.set(goal,forKey: "Goal")
       
        _ = UserDefaults.standard.object(forKey: "Hold")
        var hold:Double
        hold = Double(MoneyYouHold.text!)!
        print("Have\(hold)")
        UserDefaults.standard.set(hold,forKey: "Hold")
        
        _ = UserDefaults.standard.object(forKey: "MonthGoal")
        var Monthgoal:Double
        Monthgoal = Double(GoalMonthly.text!)!
        print("Goal\(Monthgoal)")
        UserDefaults.standard.set(Monthgoal,forKey: "MonthGoal")
        
        _ = UserDefaults.standard.object(forKey: "MonthBudget")
        var monthHold:Double
        monthHold = Double(BudgetMonthly.text!)!
        print("Have\(monthHold)")
        UserDefaults.standard.set(monthHold,forKey: "MonthBudget")
        
        
        _ = UserDefaults.standard.object(forKey: "FinalGoal")
        var FGoal:Double
        FGoal = Double(FinalGoal.text!)!
        print("Have\(monthHold)")
        UserDefaults.standard.set(FGoal,forKey: "FinalGoal")

    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
         var mondaysDate: NSDate {
            let iso8601 =  NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)!
            return iso8601.date(from: iso8601.components([.yearForWeekOfYear, .weekOfYear], from: NSDate() as Date))! as NSDate
        }
        let timer = Timer(fireAt: mondaysDate as Date, interval: 0, target: self, selector: #selector(weeklyUpdate), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        setBarChart(saved:10, range:10)
       let goalObject = UserDefaults.standard.object(forKey: "Goal")
        if (goalObject as? Double) != nil{
         WeekGoal = goalObject as! Double
        }
        
        let holdObject = UserDefaults.standard.object(forKey: "Hold")
        if (holdObject as? Double) != nil{
            WeekBudget = holdObject as! Double
        }
        
        let MonthGoalObject = UserDefaults.standard.object(forKey: "MonthGoal")
        if (MonthGoalObject as? Double) != nil{
            MonthGoal = MonthGoalObject as! Double
        }
        
        let MonthBudgetObject = UserDefaults.standard.object(forKey: "MonthBudget")
        if (MonthBudgetObject as? Double) != nil{
            MonthBudget = MonthBudgetObject as! Double
        }

        let FinalGoalObject = UserDefaults.standard.object(forKey: "FinalGoal")
        if (MonthBudgetObject as? Double) != nil{
            Goal = FinalGoalObject as! Double
        }
        
        BudgetGoal.text = String(WeekGoal)
        MoneyYouHold.text = String(WeekBudget)
        BudgetMonthly.text = String(MonthBudget)
        GoalMonthly.text = String(MonthGoal)
        FinalGoal.text = String(Goal)
        
       
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // this is the cool animated bar chart behind the pig logo.
    // saved : how much the user has saved.
    // range : how much the user wants to save.
    
    func setBarChart(saved: Double, range: Double){
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.maxVisibleCount = 100
        
        let xAxis  = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        xAxis.granularity = 0.0
        xAxis.enabled = false
        var text = ""
        let percent = saved/range
        text = "You are" + " \(1-percent)"+"% away from your goal!!! Keep up!"
        descriptionLabel.text = text
        let leftAxis = barChartView.leftAxis;
        
        leftAxis.drawAxisLineEnabled = false;
        
        leftAxis.drawGridLinesEnabled = false;
        
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        leftAxis.enabled = false;
        
        let rightAxis = barChartView.rightAxis
        
        rightAxis.enabled = false;
        
        
        
        rightAxis.drawAxisLineEnabled = false;
        
        rightAxis.drawGridLinesEnabled = false;
        
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        rightAxis.enabled = false;
        
        let l = barChartView.legend
        l.enabled =  false

        barChartView.fitBars = true;
        barChartView.drawValueAboveBarEnabled = false;
        setDataCount(saved: saved, range:range)
    }
    
    
    // support function for the bar chart.
    // saved : how much the user has saved.
    // range : how much the user wants to save.
    func setDataCount( saved: Double, range: Double){
        let barWidth = 9.0
        
        let spaceForBar =  10.0;
  
        var yVals = [BarChartDataEntry]()

        yVals.append(BarChartDataEntry(x: Double(0) * spaceForBar, y: saved))
        
        
        
        yVals.append(BarChartDataEntry(x: Double(1) * spaceForBar, y: range))
        

        var set1 : BarChartDataSet!
        
        if let count = barChartView.data?.dataSetCount, count > 0{
            
            set1 = barChartView.data?.dataSets[0] as! BarChartDataSet
            
            set1.values = yVals
            
            
            
            barChartView.chartDescription?.text = ""
            
            barChartView.data?.notifyDataChanged()
            
            barChartView.notifyDataSetChanged()
            
        }else{
            
            set1 = BarChartDataSet(values: yVals, label: "")
           // colors of bars
            set1.colors=[NSUIColor.blue,NSUIColor.white]
            var dataSets = [BarChartDataSet]()
            
            dataSets.append(set1)
            
            
            
            let data = BarChartData(dataSets: dataSets)
            
            data.setDrawValues(false)
            data.barWidth =  barWidth;
            
            
            
            barChartView.data = data
            
            barChartView.isUserInteractionEnabled = false;
            barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
            
        }
  
        
    }


}

