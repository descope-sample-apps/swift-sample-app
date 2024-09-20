## Swift Sample App

iOS Sample app using Descope for authentication. this app includes

- Swift App client

## Getting Started

This sample app allows you to get familiar with the Descope Swift SDK. It has all of the supported authentication functions built into it for you to test with.

### Run the app

1. Clone this repo
2. Open the project within Xcode
3. Within the project settings of the project, change the `myProjectId` (If in a non-US region, or using a custom domain with CNAME, replace `myBaseURL` with your specific localized base URL)

![Alt text](Images/setProjectId.png?raw=true "Set Project ID")

4. Optionally, if you are using a custom CNAME, you can also change the myBaseURL
5. Run the simulator within Xcode - The play button located in the top left

#### Running Flows

If you're running a hosted flow with this SDK, you can modify the value for the `flowUrl` in the `Flow/FlowView.swift` file to include your own hosted page with our Descope Web Component, as well as alter the `?flow=sign-up-or-in` parameter to run a different flow.

```
var flowURL: String {
    return "https://auth.descope.io/\(localProjectId)"
}
```

### Notes:

1. Enchanted link currently does not route back to the application. You will need to validate the token externally from a web or backend client.

- https://docs.descope.com/build/guides/client_sdks/enchanted-link/#user-verification
- https://docs.descope.com/build/guides/backend_sdks/enchanted-link/#user-verification
