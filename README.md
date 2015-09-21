## MOJailBrokenDector

I`m inspired [JailBrokenDector](https://github.com/0dayZh/JailbrokenDetector) Project. But JailBrokenDector proejct is writed Objective-C. Then I rewrite this code from Objective-C to Swift 2.0.

### How to use it

	do {
		try MOJailBrokenDector.isBroken()
	} catch {
		print("Device is Broken", error)
	}

### But..

I don`t have jail broken device.. then, I didn`t test real device.