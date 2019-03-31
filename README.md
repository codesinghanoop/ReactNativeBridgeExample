# ReactNativeBridge
A simple counter example to show bridge between iOS between React Native

**Getting Started**

1) clone repo by git clone 
2) Navigate to root dir of project and run npm install
3) Run server by running react-native start
4) If adb device is running then run react-native run-android or run directly through android studio. In case of iOS run react-native run-ios

**How the example is build**

**Bridging in iOS**

 - Step 1- In case of iOS you have to create a swift file and for bridging with javascript you have to use interface of Objective-c. For all this first create a swift file. To create a swift file go to files then new file and a dialog will appear which will ask you about which type of file you need.
 - Step 2- After selecting swift file an alert will appear asking you about creating bridge between objective-c and swift because our primary way of briding with javascript is objective-c not swift.
 - Step 3- After selecting create bridge from the alert. 
 - Step 4- Add class, function and variable with @objc annotation. What does @objc meant? @objc meant to expose swift class and class member to objective c and there after objective-c will export all the methods to javascript.
 
 //Below is the use of objc in this example
 
 @objc(Counter)

class Counter: NSObject {
  
  @objc
  static var counting = 0;
  
  @objc
  func reset(_ value: NSInteger) {
    Counter.counting = value;
  }
  
  @objc
  func incrementCounter() {
    let count = Counter.counting
    Counter.counting = count + 1;
    print("counter:",count)
  }
  
  @objc
  func decreaseCounter() {
    let count = Counter.counting
    Counter.counting = count - 1;
    print("counter:",count)
  }
  
  @objc
  func getStatus(_ callback: RCTResponseSenderBlock) {
    callback([NSNull(), Counter.counting])
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
}

In the above code in swift file all the methods, class and variable are exposed to objective-c using @objc annotation.
 
 - Step 5- Now to expose method from above code to javascript we have to create a objective-c file and export your module to javascript. Like this 

//Export module to javascript. Add this to objective-c file
 @interface RCT_EXTERN_MODULE(Counter, NSObject)
 
In the above code we are exporting Counter class which we described in swift file to javascript and NSObject is the type of the class whereas RCT_EXTERN_MODULE will convert the NSObject class type to javascript object
 
 - Step 6- In step 5 we exposed class. Now we will expose methods of class to javascript using below code.
 
 RCT_EXTERN_METHOD(incrementCounter)
 
 - Step 7- How can we trasfer variable values from native to react native this is a big question ? To transfer values we will use callbacks. Below is the code to implement callbacks
 
 @objc
  func getStatus(_ callback: RCTResponseSenderBlock) {
    callback([NSNull(), Counter.counting])
  }
  
 In the above code @objc is used to expose function to objective-c and callback is declared as RCTResponseSenderBlock type which is a class of #import "React/RCTBridgeModule.h" and inside callback we have send error and counter value. 
 
 
 - step 8- Exposing this to react native is straight forward as discussed before export method through below code.
 
 RCT_EXTERN_METHOD(getStatus: (RCTResponseSenderBlock)callback)
 
 In the above code, RCT_EXTERN_METHOD is the way to expose method, getStatus is the method declared in swift file, RCTResponseSenderBlock is the callback type and callback itself is the parameter.
 
**Bridging in Android:-**
 
 - Step 1- Bridging in android is easier than iOS. Create a android library by creating a android module from files->New->New Module-> Android library
- Step 2- Inside the android library/java folder create two file one manager and one package. Manager is responsible for implementing all logic inside the methods and package is responsible to exporting package to mainApplication.java

- Step 3- Inside package file write below code

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }

    @Override
    public List<NativeModule> createNativeModules(
            ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();

        modules.add(new CounterManager(reactContext));

        return modules;
    }
    
In the above code createViewManagers is returning emptylist because we aren't bridging view in this example. createNativeModules returns module list which is our module manager file. In this example CounterManager is the one where methods are written to expose to react native.

- Step 4 - Like RCT_EXTERN_MODULE to expose methods in iOS we will expose method in android by using @ReactMethod annotation
above methods.

//exposing methods

@ReactMethod
public void incrementCounter() {
    counting = counting + 1;
}

- Step 5 - To transfer value from native to react native here also we will use callback.

//callback to transfer values

@ReactMethod
public void getStatus(Callback successCallback) {
    successCallback.invoke(null, counting);
}

Note - if you are using android studio add the missing import files by alt + enter

- Step 6- Now when your library is ready then add this library to mainApplication addpackages list.

@Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          new CounterPackager()
      );
    }

- Step 7- To add local android library to main app. Add dependency in app/build.gradle.

dependencies {
    implementation fileTree(dir: "libs", include: ["*.jar"])
    implementation "com.android.support:appcompat-v7:${rootProject.ext.supportLibVersion}"
    compile project(path: ':CounterCheck')//Here we have added our android library.
    implementation "com.facebook.react:react-native:+"  // From node_modules
}

**In react native:- **

All the above methods can be access in react native using NativeModules followed by class name and then class member.

incrementCounter() {
    NativeModules.Counter.incrementCounter()
    this.getCounter()
  }

  decreaseCounter() {
    NativeModules.Counter.decreaseCounter()
    this.getCounter()
  }

  getCounter() {
    NativeModules.Counter.getStatus((error, counter) => {
      this.setState({
        counter
      })
    })
  }
  
Note:- All the above steps are included in this example repo. please have a look. Thanks  


----------

**Author**

    Anoop Singh (codesingh)
    Email: anoop100singh@gmail.com
    Stack Overflow: codesingh(username)
    
----------    

**License**
    
Apache-2.0
