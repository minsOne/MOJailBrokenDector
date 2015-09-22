## MOJailBrokenDector

I`m inspired [JailBrokenDector](https://github.com/0dayZh/JailbrokenDetector) Project. But JailBrokenDector proejct is writed Objective-C. Then I rewrite this code from Objective-C to Swift 2.0.

### How to use it

	// using do-try-catch
	do {
		try MOJailBrokenDector.isBroken()
	} catch JailBrokenError.Detected(let fileName) {
		print("Device is broken : \(fileName)")
	} catch {
		print("Error : \(error)")
	}

	// using guard
	guard let isBroken: Bool? = try? MOJailBrokenDector.isBroken() where isBroken != nil else {
	    print("Device is broken")
	    return;
	}

### But..

I don`t have jail broken device.. then, I didn`t test real device.