//
//  MOJailBrokenDector.swift
//  MOJailBrokenDetector
//
//  Created by JungMin Ahn on 2015. 9. 21..
//  Copyright © 2015년 minsOne. All rights reserved.
//

import Foundation

enum JailBrokenError: ErrorType {
    case Detected
}

#if (arch(i386) || arch(x86_64)) && os(iOS)
let DEVICE_IS_SIMULATOR = true
    #else
let DEVICE_IS_SIMULATOR = false
#endif

public class MOJailBrokenDector {
    class func isBroken() throws -> Bool {
        if DEVICE_IS_SIMULATOR { return false }

        try isFileExistsAtPath("/Applications/Cydia.app")
        try isFileExistsAtPath("/Library/MobileSubstrate/MobileSubstrate.dylib")
        try isFileExistsAtPath("/bin/bash")
        try isFileExistsAtPath("/usr/sbin/sshd")
        try isFileExistsAtPath("/etc/apt")
        try isFileExistsAtPath("/private/var/lib/apt/")
        try isOpenFile("/bin/bash")
        try isOpenFile("/Applications/Cydia.app")
        try isOpenFile("/Library/MobileSubstrate/MobileSubstrate.dylib")
        try isOpenFile("/usr/sbin/sshd")
        try isOpenFile("/etc/apt")
        try isWriteToFile("/private/jailbreak.txt")

        return false
    }

    class private func isFileExistsAtPath(fileName: String) throws -> Bool {
        if NSFileManager.defaultManager().fileExistsAtPath(fileName) {
            throw JailBrokenError.Detected
        }
        return false
    }

    class private func isOpenFile(fileName: String) throws -> Bool {
        let file = fopen(fileName, "r")
        if file != nil {
            defer { fclose(file) }
            throw JailBrokenError.Detected
        }
        return false
    }

    class private func isWriteToFile(fileName: String) throws -> Bool {
        do {
            try "This is a test.".writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
            throw JailBrokenError.Detected
        } catch {
            return false
        }
    }
}