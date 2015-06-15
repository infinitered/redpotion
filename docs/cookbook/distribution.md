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

First, create the app in iTunes Connect. There are two different ways that you can upload to iTunes Connect: use the Application Loader application or use the `motion-appstore` gem.

### Using the motion-appstore gem

To upload the build to iTunes Connect, install the gem:

    gem install motion-appstore

This will add the following commands:

    motion validate appleid@example.com
    motion upload appleid@example.com

Use the `validate` command if you want to see if your build will upload successfully. Use the `upload` command to upload the build to iTunes Connect. Use your email address that you used to log into the Developer Center.
