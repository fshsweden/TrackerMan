//: Playground - noun: a place where people can play

import UIKit

var outerDic = [String:Any]()
var innerDic = [String:Any]()
var innerMostDic1 = [String:String?]()
var innerMostDic2 = [String:String?]()
var innerMostDic3 = [String:String?]()

outerDic["name"] = "Peter"

innerMostDic1["zzz"] = "IM1-1"
innerMostDic1["ttt"] = "IM1-2"
innerMostDic1["kkk"] = "IM1-3"
innerMostDic1["sss"] = nil

innerMostDic2["zzz"] = "IM2-1"
innerMostDic2["ttt"] = "IM2-2"
innerMostDic2["kkk"] = "IM2-3"
innerMostDic2["sss"] = nil

innerMostDic3["zzz"] = "IM3-1"
innerMostDic3["ttt"] = "IM3-2"
innerMostDic3["kkk"] = "IM3-3"
innerMostDic3["sss"] = nil


innerDic["1"] = innerMostDic1
innerDic["2"] = innerMostDic2
innerDic["3"] = innerMostDic3

innerDic

outerDic["dict2"] = innerDic

outerDic



