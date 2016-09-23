# SwiftParallel
A Tiny library for concurrency

This is my promise. Usage:

Add to project using Pod:
```
pod 'SwiftState', :git => 'https://github.com/tuoitrevohoc/SwiftState.git'
```

```
Promise<String>(handler: {
  (accept, reject) in
  /// do something in background
  accept("the result")
}).then {
  data in
  print("Result is: \(data)")
}.onError {
  error in
  /// handle exception here
}
```

Or use async way;

```
async {
  /// do something fun in background
  return data;
}.then {
  data in
  /// handle data
}
```

Very useful in API implemenation:

```
protocol UserService {
  
  ///
  /// login with username and passwork
  ///
  /// - parameter username: username of the user
  /// - parameter password: password
  /// - returns the promise
  func login(username: String, password: String) -> Promise<User>
}

/// sample usage
userService.login(username: "abc", password: "xyz").then {
  user in
}.onError(handler: errorHandler)
```
