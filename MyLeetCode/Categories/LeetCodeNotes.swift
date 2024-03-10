//
//  LeetCodeNotes.swift
//  MyLeetCode
//
//  Created by Argost on 2024-03-10.
//  Copyright © 2024 Argost. All rights reserved.
//

import Foundation

class LeetCodeNotes : LeetCode {
    override func run() {
        super.run()
        
        let solution = Solution()
        
        let _ = solution.trap([3, 1, 2, 4])
    }
}

class Solution {
    func trap(_ height: [Int]) -> Int {
        var rt = 0
        
        if height.isEmpty || height.count < 3 {
            return rt
        }
        
        var leftMax = height[0]
        var rightMax = height[height.count-1]
        
        var leftP = 1
        var rightP = height.count-2
        
        while leftP <= rightP {
            if leftMax <= rightMax {
                //            rt += leftMax-arr[leftP] > 0 ? leftMax-arr[leftP] : 0
                rt += max(0, leftMax-height[leftP])
                leftMax = max(leftMax, height[leftP])
                
                leftP+=1
            } else {
                //            rt += rightMax-arr[rightP] > 0 ? rightMax-arr[rightP] : 0
                rt += max(0, rightMax-height[rightP])
                rightMax = max(rightMax, height[rightP])
                
                rightP -= 1
            }
        }
        
        print("\(height)'s 柱状图接水(左右指针法) is \(rt)")
        
        return rt
    }
}
