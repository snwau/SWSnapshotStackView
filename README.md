# Snapshot Stack View

Snapshot Stack View provides an easy means of decorating your `UIImage`'s of any aspect ratio with a rendered matte frame and associated drop shadow. It also may render your image to look as though it is the top photograph (or snapshot) within a stack (or pile) of shots. Best described with a screenshot:

![Screenshot](http://github.com/snwau/SWSnapshotStackView/raw/master/Screenshot.png)

Features:

 * Multiple display modes; single or stacked.
 * Respects image aspect, scaling snapshots to fit within the views frame
 * Supports all image aspects (landscape, square, portrait)
 * Supports dynamic modification of views frame, the image to display as the top snapshot and display mode.

Background
----------

Snapshot Stack View was developed for use in an iOS application I'm currently developing to decorate a UIImage for presentation to the user. The application must display images of unknown and varying aspect ratios.

Normally the effects rendered within the Snapshot Stack View to decorate a UIImage for display could easily generated be within Photoshop as a layer to sit over/under the `UIImage`, however the aspect and dimensions of the image must be known and static, hence not possible. 

An alternative approach often used is to crop the images to a fixed aspect, however this can lead to cropping important information from the image or destroying the general composition of a photograph, which I also did not want to risk.

I use Snapshot Stack View to display a thumbnail to the user within an article for touching which then launches into a full screen image viewer. I've tried to convey the availability of either a single image or multiple using the Snapshot Stack View display modes (single or stacked).

Compatability
-------------

Snapshot Stack View has been developed to run on iOS 3.1 or later (Deployment Target) and was developed using iOS SDK 5.0, Xcode 4.2.1 (Base SDK).

Support for iOS 3 was required for the target application I initially developed Snapshot Stack View for and hence Snapshot Stack View does NOT make use of any of the newer iOS features such as blocks or more importantly Automatic Reference Counting (ARC).

If using Snapshot Stack View within a newer ARC enabled project, disable ARC selectively for compilation of Snapshot Stack View source files:

 1.   Select the project within Xcode project navigator
 2.   Select the required target from the list of Targets
 3.   Select the Build Phases tab
 4.   Expand the list of Compile Sources and double-click on the `SWSnapshotStackView.m` file to modify the compiler flags for this file.
 5.   Add `-fno-objc-arc` to the compiler flags

Usage
-----

To use Snapshot Stack View within your project:

 1. Add `SWSnapshotStackView.h` and `SWSnapshotStackView.m` to project your Xcode project.
 2. Ensure `QuartzCore.framework` framework is added to the project if not already.
 3. Import the Snapshot Stack View header file to the destination View Controller source using `#import "SWSnapshotStackView.h"`.
 4. Create an instance of the Snapshot Stack View class either within a XIB using Interface Builder (IB) or programatically as you would any other view.
 5. Set the desired image (an existing `UIImage`) to display using the `image` property within code.
 6. Set the desired display mode using the `displayAsStack` property within code.

Refer to the Demonstration application `SWSnapshotStackViewDemo/` for example of use.

Demonstration
-------------

A demonstration application is provided to illustrate (and test) the use of Snapshot Stack View, demonstrating support for;

 *   Multiple images of differing aspect ratios (Image 1 - landscape, Image 2 - square, Image 3 - portrait).
 *   Dynamic resizing of view's frame via slider.
 *   Selection and rendering of display mode (single or stack) via switch.


![Screenshot](http://github.com/snwau/SWSnapshotStackView/raw/master/ScreenshotDemo.png)

Known Issues
------------

At time of release:

 * Matte and shadow effects require scaling to suit smaller frame sizes, otherwise effects can look exaggerated.

For an updated list of issues/bugs, refer to [Issues on GitHub](https://github.com/snwau/SWSnapshotStackView/issues?labels=Bug&sort=created&direction=desc&state=open&page=1).

Future Work
-----------

A list of future enhancements is being maintained within the [GitHub Issue Tracker](https://github.com/snwau/SWSnapshotStackView/issues?labels=Enhancement&sort=created&direction=desc&state=open&page=1), under the `Enhancement` label. 

If there is a particular enhancement you would like to "up-vote" to increase priority for completion, please leave a comment within the respective enhancement issue.

Contributing
------------

If you find an problem you are welcome to raise a [new issue](https://github.com/snwau/SWSnapshotStackView/issues/new) otherwise fork the repository, make the required changes and submit a pull request for merge consideration.

Also don't hesitate to email me with any suggestions or feedback.

License (Source Code)
---------------------

Copyright (c) 2012 Scott White. All rights reserved.

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Refer to the LICENSE file for a copy of the MIT License
along with this program.  Otherwise, see <http://www.opensource.org/licenses/MIT>.

License (Images)
----------------

The images (`350D_IMG_3157_20071030w.jpg`, `IMG_2777_080216w6s.jpg`, and `IMG_5737_081229w7sq.jpg`) used within the Snapshot Stack View demonstration application are exceptions to the aforementioned Source Code license and hence not covered by MIT.

Copyright (c) 2012 Scott White. All rights reserved.

No reproduction in any form or by any means, graphic, electronic or mechanical is authorised outside of the Snapshot Stack View demonstration application, without the express permission of Scott White.

Contact
-------

* Email: Refer to source code file header for email address.
* Twitter: [@snwau](http://www.twitter.com/snwau)
* GitHub: [snwau](http://github.com/snwau)
