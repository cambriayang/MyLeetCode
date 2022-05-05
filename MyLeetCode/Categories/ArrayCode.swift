//
//  ArrayCode.swift
//  MyLeetCode
//
//  Created by Argost on 2020/9/4.
//  Copyright © 2020 Argost. All rights reserved.
//

import UIKit

class ArrayCode: LeetCode {
    override func run() {
        super.run()
        
//        let _=findTheMidNumber([4,3,2,7,8,10,11,18,9])
//        let _=maxProfit([7,1,5,3,6,4])
//        let _=maxProfitII([7,1,5,3,6,4])
//        var source=[4,3,2,7,8,10,11,18,9,10,76,1,6]
//        print("quickSort before: \(source)")
//        quickSort(src: &source, left: 0, right: source.count-1)
//        print("quickSort after: \(source)")
//        let _=binarySearch(insert: 14, into: source)
//        bubleSort(source: &source)
        let _=findLongestIncrementSequenceWithDP(src: [10,9,2,5,3,7,101,18,20])
        let _=findLongestIncrementSequence(src: [10,9,2,5,3,7,101,18,20])
    }
}


///Methods
//二分查找法（已经排好序），返回插入的index，并不做插入
func binarySearch(insert target: Int, into src: [Int]) -> Int {
    var left=0, right=src.count-1
    
    while left<=right {
        let mid=(left+right)/2
        let midValue=src[mid]
        
        if target==midValue {
            return mid
        } else if target>midValue {
            left=mid+1
        } else {
            right=mid-1
        }
    }
    
//    print("\(target) Should insert at Index: \(left)")
    return left;
}

//寻找最长上升子序列（不需要连续),10，9，2，5，3，7，101，18，20->2,3,7,18,20
func findLongestIncrementSequenceWithDP(src: [Int]) -> Int {
    if src.count<=0 {
        return 0
    }
    
    var rls=1
    
    var DP = Array.init(repeating: 1, count: src.count)
    
    for i in 1..<src.count {
        for j in 0..<i {
            if src[j]<src[i] {
                DP[i]=max(DP[i], DP[j]+1)
            }
        }
        
        rls=max(rls, DP[i])
    }
    
    print("\(src)'s LIS count is \(rls)")
    return rls
}

//寻找最长上升子序列（不需要连续),10，9，2，5，3，7，101，18，20->2,3,7,18,20
func findLongestIncrementSequence(src: [Int]) -> [Int] {
    if src.count<=0 {
        return []
    }
    
    var rls=[Int]()
    
    for i in 0..<src.count {
        let index=binarySearch(insert: src[i], into: rls)
        
        rls.insert(src[i], at: index)
        
        if index+1<rls.count {
            rls.remove(at: index+1)
        }
    }
    
    print("\(src)'s LIS is \(rls)")
    return rls
}
    
func bubleSort(source: inout [Int]) {
    print("bubleSort before: \(source)")
    for i in 0..<source.count {
        for j in i..<source.count {
            if source[j]<source[i] {
                source.swapAt(i, j)
            }
        }
    }
    
    print("bubleSort after: \(source)")
}

func quickSort(src: inout [Int], left: Int, right: Int) {
    if src.count<=1 {
        return
    }
    
    let left=left
    let right=right
    
    if left<right {
        //获取pivot的闭包
        let closure={ (arr: inout [Int], left: Int, right: Int) -> Int in
            let pivot=left
            var index=pivot+1
            
            for i in index...right {
                if arr[i]<arr[pivot] {
                    arr.swapAt(i, index)
                    //说明有小于pivot的数字index++
                    index+=1
                }
            }
            
            //此处相当于pivot需要更新
            arr.swapAt(pivot, index-1)
            return index-1
        }
        
        let partionIndex=closure(&src, left, right)
        
        quickSort(src: &src, left: left, right: partionIndex-1)
        quickSort(src: &src, left: partionIndex+1, right: right)
    }
}

func findTheMidNumber(_ data: [Int]) -> [Int] {
    var res = [Int]()
    
    if data.count == 0 {return res}
    if data.count <= 2 {return res}
    
    var rightMin = [Int](repeating: 0, count: data.count)
    var r_min = data[data.count-1]
    
    //从右往左，寻找每个位置及其之后的最小数
    for i in (0..<data.count).reversed() {
        if data[i] < r_min {
            r_min = data[i]
        }
        rightMin[i] = r_min
    }
    
    //从左往右，寻找左边大且比右边小的数
    var l_max = data[0]
    for i in 0..<data.count-1 {
        if data[i] > l_max {
            l_max = data[i]
            if data[i] < rightMin[i+1] {
                res.append(data[i])
            }
        }
    }
    print(res)
    return res
}

func maxProfit(_ prices: [Int]) -> Int {
    if prices.count < 2 {return 0}
    
    var minPrice = Int.max
    var maxProfit = 0
    for i in 0..<prices.count {
        if prices[i] < minPrice {
            minPrice = prices[i]
        } else if prices[i] - minPrice > maxProfit {
            maxProfit = prices[i]-minPrice
        }
    }
    
    print(maxProfit)
    return maxProfit
}

func maxProfitII(_ prices: [Int]) -> Int {
    if prices.count < 2 {
        return 0
    }
    
    var maxProfit = 0
    for i in 1..<prices.count {
        if prices[i] > prices[i-1] {
            maxProfit += prices[i]-prices[i-1]
        }
    }
    
    print(maxProfit)
    return maxProfit
}
