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
        
        var nums1 = [0,0,1,1,1,1,2,3,3]
//        let _ = solution.removeDuplicates1(&nums)
//        let _ = solution.removeDuplicates2(nums: &nums)
        let _ = solution.removeDuplicates3(nums: &nums1)
        
        let nums2 = [3,2,1,0,4]

        let _ = solution.canJump(nums: nums2)
    }
}

class Solution {
    func canJump(nums: [Int]) -> Bool {
        //rightmost表示能跳到的最远距离
        var rightmost = 0;
        let len = nums.count
        
        for i in 0..<len {
            //首先要确保能到达的最右边是可以到达i位置，然后在次基础上更新rightmost，取max，再然后rightmost还能大于右边边界，即能到达
            if rightmost >= i {
                rightmost = max(rightmost, i + nums[i])
                
                //再然后的判断
                if rightmost >= len - 1 {
                    print("\(nums) 可以跳到数组最后一个元素：true")

                    return true
                }
            }
        }
        
        print("\(nums) 可以跳到数组最后一个元素：false")

        return false
    }
    
    func removeDuplicates3(nums: inout [Int]) -> Int {
        let len = nums.count
        
        if len <= 2 {
            return len
        }
        
        var rt = 0
        
        var slow = 2
        
        //slow是需要替换的位置，那么slow-2自然就是需要保留的位置
        for fast in 2..<len {
            if nums[fast] != nums[slow - 2] {
                nums[slow] = nums[fast]
                slow = slow + 1
            }
        }
                
        rt = slow
        
        print("不同的元素数组是3：\(nums) num is: \(rt)")
        
        return rt
    }
    
    func removeDuplicates2(nums: inout [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        
        var rt = 0
        
        //直接从第二个元素开始遍历
        var slow = 1
        
        for fast in 1..<nums.count {
            if nums[fast] > nums[slow-1] {
                nums[slow] = nums[fast]
                slow = slow + 1
            }
        }
        
        rt = slow
        
        print("不同的元素数组是2：\(nums) num is: \(rt)")

        return rt
    }
    
    func removeDuplicates1(_ nums: inout [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        
        var rt = 0
        
        var tmpArr = [Int]()
        
        var tmp = nums[0]
        
        tmpArr.append(tmp)
        
        for i in 1..<nums.count {
            if nums[i] > tmp {
                //说明不同，否则至少相等，因为已经排过序
                tmp = nums[i]
                tmpArr.append(tmp)
            }
        }
        
        rt = tmpArr.count
        
        print("不同的元素数组是1：\(tmpArr)")
        
        return rt
    }
    
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
