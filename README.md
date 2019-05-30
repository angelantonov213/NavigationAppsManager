# NavigationAppsManager
Helps redirecting to some navigation apps from UIViewController or UIView.

## Navigation app options
- Maps (iOS default map app)
- Google Maps
- Waze
- Here WeGo

If none of the above apps is available it will open Safari with Google Maps url.

## Usage
`import NavigationAppsManager`

`class MyViewController: CanOpenNavigationApps`

`navigate(CLLocation(latitude: 42.6940949, longitude: 23.3255298))`

If you want to use specific navigation apps:
`navigate(CLLocation(latitude: 42.6940949, longitude: 23.3255298), appsToUse: [.here, .waze])`

## LSApplicationQueriesSchemes

Google Maps - `comgooglemaps`
Waze - `waze`
Here WeGo - `here-route`
Maps (iOS) - nothing to do here
