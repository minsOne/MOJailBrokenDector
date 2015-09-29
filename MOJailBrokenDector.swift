//
//  MOJailBrokenDector.swift
//  MOJailBrokenDetector
//
//  Created by JungMin Ahn on 2015. 9. 21..
//  Copyright © 2015년 minsOne. All rights reserved.
//

import Foundation

#if (arch(i386) || arch(x86_64)) && os(iOS)
private let DEVICE_IS_SIMULATOR = false
    #else
private let DEVICE_IS_SIMULATOR = false
#endif

enum JailBrokenError: ErrorType {
    case Detected(fileName: String)
}

private let checkList = [
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt",
    "/private/var/lib/apt/"
];

public class MOJailBrokenDector {
    class func isBroken() throws -> Bool {
        if DEVICE_IS_SIMULATOR { return false }

        try isFileExistsAtPaths(checkList)
        try isOpenFiles(checkList)
        try isWriteToFile("/private/jailbreak.txt")

        return false
    }

    class private func isFileExistsAtPaths(fileNames: [String]) throws {
        try fileNames.forEach {
            if NSFileManager.defaultManager().fileExistsAtPath($0) {
                throw JailBrokenError.Detected(fileName: $0)
            }
        }
    }

    class private func isOpenFiles(fileNames: [String]) throws {
        try fileNames.forEach {
            let file = fopen($0, "r")
            if file != nil {
                defer { fclose(file) }
                throw JailBrokenError.Detected(fileName: $0)
            }
        }
    }

    class private func isWriteToFile(fileName: String) throws {
        do {
            try "This is a test.".writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
            throw JailBrokenError.Detected(fileName: fileName)
        }
    }
}