# Distribution

When you're ready to distribute your RubyMotion app to other people for testing, or submit to the App Store, here is an overview of the steps you will take:

1. Create an App ID for your app
2. Create your app in iTunes Connect
3. Add users for testing
2. Create a distribution certificate and provisioning profile.
3. Build your app for distribution.
4. Upload to iTunes Connect.
5. Enable your build for your TestFlight users.
6. Once you've uploaded a build and determined that it is ready to submit to the App Store, you can submit the build for App Store review.

## Certificates & Provisioning Profiles

In order to deploy your app to your test users, you need to sign your app using a provisioning profile with "App Store Distribution" enabled. Here are the steps you will take to create this profile:

1. Log into Apple Developer Center
2. Click on "Certificates, Identifiers & Profiles"

### Generating an App ID

1. Click on Identifiers
2. Click the plus-sign button to create a new App ID
3. Fill out the form to create your App ID.
4. Now that you have an App ID Prefix, Description, and Suffix, you can update the bundle identifier in your Rakefile.
5. Open your Rakefile and update the `app.identifier` option in the format of `prefix.description.suffix` (i.e. `com.mycompany.myapp`)

### Generating a Certificate

1. In the sidebar, click Certificates > All
2. Click the plus-sign button to create a new certificate
3. Select "App Store and Ad Hoc" as the type of certificate
4. Now you will generate a certificate signing request.
  1. In spotlight, search for and open Keychain Access
  2. From the Keychain Access menu, select Certificate Assistant > Request a Certificate from a Certificate Authority
  3. Enter the email address that you used to log into the Apple Developer Center
  4. Enter some description in the Common Name field. I used "MyApp Distribution"
  5. Leave CA Email blank (even though is says required)
  6. Select "Saved to disk" and save it somewhere.
5. Now upload the `.certSigningRequest` file that you just created.
6. Download the Certificate file that is created for you.
7. Now, double-click the file you just downloaded to open it, and store it, in the Keychain Access app.
8. Make note of the name associated with the Certificate. It should display in the format of "iPhone Distribution: NAME".
9. Open your Rakefile and update the `app.codesign_certificate` option with the value "iPhone Distribution: NAME", replacing NAME with the name displayed in Keychain Access.

### Generating a Provisioning Profile

2. In the sidebar, click on Provisioning Profiles
3. Click the plus-sign button to create a profile.
4. Select "App Store" Distribution
5. Select your App from the list of App IDs
5. Select the distribution certificate that we just created
6. Download the provisioning profile that it generated for you.
7. Create a new directory in your project called `signing`. Move this '.mobileprovision' file to that directory.
8. Open your Rakefile and update the `app.provisioning_profile` option with the relative location of that file. It should look something like this: "signing/MyApp_Distribution_Profile.mobileprovision"

Now that you've completed all the steps necessary to build your app for distribution, follow these steps to build and upload your app to iTunes Connect.

## Building for Distribution

To build your app for distribution, run the following command:

    rake archive:distribution

## Uploading to iTunes Connect

The first step in preparing to upload to iTunes Connect is to create the App record in iTunes Connect.

Once you've created the App record, there are two different ways that you can upload to iTunes Connect: use the Application Loader application to manually upload a build, or use the [`motion-appstore`](https://github.com/HipByte/motion-appstore) gem to upload from the command line. Note that the `motion-appstore` gem still uses the Application Loader application behind the scenes.

### Using the motion-appstore gem

To upload the build to iTunes Connect, install the gem:

    gem install motion-appstore

This will add the following commands:

    motion validate appleid@example.com
    motion upload appleid@example.com

Use the `validate` command if you want to see if your build will upload successfully. Use the `upload` command to upload the build to iTunes Connect. Use the email address that you used to log into the Developer Center.

### Using Application Loader

Alternatively, you can manually upload your build using Application Loader.

1. To launch Application Loader, use spotlight search, or from the Xcode menu, choose Open Developer Tool > Application Loader.
2. Sign In using your Developer Center credentials.
3. Choose "Deliver Your App"
4. Select the `.ipa` file from your `build/iPhoneOS-*-Release` directory (assuming you already ran `rake archive:distribution`)
5. Continue through the steps to upload your build. It will conclude with some messaging that makes it sound like your app has been uploaded to the App Store, but don't worry. Your build has simply been uploaded to iTunes Connect.

The build will have an initial state of "Pending". Once the build transitions to a sort of ready state, it will allow you to enable it for TestFlight Beta Testing.

## Enable Build for TestFlight

Now that you have uploaded your build to iTunes Connect, you can enable the build for TestFlight for distributing to test users. TestFlight allows two different types of testers: internal and external.

* Internal testers are meant for other members of your team. However, you can simply invite anyone by their email address. If they don't have a Apple account, they will be asked to create a TestFlight user account. A team admin will need to add these users to the team and give them a "technical" role in order to be a TestFlight internal tester.
* External testers are intended to be other people who are not on your team. However, your build must be approved by Apple before it can be sent to your External testers.

Once you've added your test users, to enable your build for TestFlight beta testing:

1. Navigate to your app in iTunes Connect.
2. Navigate to the Prerelease tab.
3. Find the build that you want to enable for tesing and click the toggle on the right side of the page (you can only enable one build at a time).

