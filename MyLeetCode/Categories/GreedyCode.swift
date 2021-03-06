//
//  Greedy.swift
//  MyLeetCode
//
//  Created by Argost on 2022/4/30.
//  Copyright © 2022 Argost. All rights reserved.
//

import Foundation

//入口类
class GreedyCode : LeetCode {
    override func run() {
        super.run()
        
        var children=[3,10,10,6,16,11], candies=[9,4,2,7,21]
        
        allocationCandies(children: &children, candies: &candies)
        
    }
}


/*LeetCode 455，分糖果，有糖果序列和孩子序列，每个孩子需求一定数量的糖果，如果他得到
 *满足，则满足他的糖果序列会被消耗，返回最多能满足的孩子数量
 *如：6个孩子，需求分别是3,10,10,6,16,11。5个糖果序列为9,4,2,7,21
*/
func allocationCandies(children: inout [Int], candies: inout [Int]) {
    var count=0
    
    quickSort(src: &children, left: 0, right: children.count-1)
    quickSort(src: &candies, left: 0, right: candies.count-1)
    
    var i=0,j=0
    
    while i<children.count && j<candies.count {
        if candies[j]<children[i] {
            j+=1
        } else {
            count+=1
            i+=1
            j+=1
        }
    }
    
    print("allocationCandies: \(count) children can be satisfied")
}


