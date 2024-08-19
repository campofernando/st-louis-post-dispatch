# st-louis-post-dispatch

Demonstration code for downloading a payload and constructing a view according to the elements in the payload.
The code uses a mock http client for simulating the api response. This was done because the links for sending requests to the API had an expiration date. For testing in a real scenario, go to the AppDependencyFactory.swift and substitute the line 
`self.httpClient = MockHttpClient()` by `self.httpClient = URLSession(configuration: .default)`

The view is not complete, there is still work to do for adjusting constraints and adding other elements like a table view for showing the offers, and loading screen while downloading the images and awaiting response from the api.

![GravaodeTela2024-08-18s23 11 52-ezgif com-resize](https://github.com/user-attachments/assets/9b98f577-7e5e-4ac2-b5cd-f26fa72e99a5)
